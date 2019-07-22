#!/bin/bash

name=LONGDB-1.0.0
label="Longdb"
lowername=$(echo $name | tr '[A-Z]' '[a-z]')

mkdir -p ${name}-csd/descriptor
mkdir -p ${name}-csd/scripts

cat > ${name}-csd/descriptor/service.sdl << EOF
{
  "name" : "${name}",
  "label" : "${label}",
  "description" : "Longdb is an relational database. <span class=\"error\">Before adding this service, ensure that you have installed the splice binaries, which are not included in CDH.</span>"
  "version" : "1.0.0",
  "runAs" : {
    "user" : "root",
    "group" : "root"
  }, 
  "roles" : [
    {
      "name" : "LONGDB_WEBSERVER",
      "label" : "Web Server",
      "pluralLabel" : "Web Servers",
      "parameters" : [
        {
          "name" : "port_num",
          "label" : "Webserver port",
          "description" : "The web server port number",
          "required" : "true",
          "type" : "port",
          "default" : 8080
        }
      ],
      "startRunner" : {
        "program" : "scripts/control.sh",
        "args" : [ "start" ],
        "environmentVariables" : {
          "WEBSERVER_PORT" : "\${port_num}"       
        }
      }
    }
  ]
}
EOF

cat > ${name}-csd/scripts/control.sh << EOF
#!/bin/bash
CMD=\$1
case \$CMD in
  (start)
    echo "Starting the web server on port [\$WEBSERVER_PORT]"
    exec python -m SimpleHTTPServer \$WEBSERVER_PORT
    ;;
  (*)
    echo "Don't understand [\$CMD]"
    ;;
esac
EOF

# verify
java -jar cm_ext/validator/target/validator.jar -s ${name}-csd/descriptor/service.sdl
# build jar
jar -cvf ${name}.jar ${name}-csd

#cp -a ECHO-1.0.jar cm master: /opt/cloudera/csd
#service cloudera-scm-server restart

