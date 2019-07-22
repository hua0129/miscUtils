#!/bin/bash

mkdir -p echo_csd/descriptor


name="ECHO"
label="Echo"
lowername=$(echo $name | tr '[A-Z]' '[a-z]')

cat > echo_csd/descriptor/service.sdl << EOF
{
  "name" : "ECHO",
  "label" : "Echo",
  "description" : "The echo service",
  "version" : "1.0",
  "runAs" : {
    "user" : "root",
    "group" : "root"
  }, 
  "roles" : [
    {
      "name" : "ECHO_WEBSERVER",
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

mkdir -p echo_csd/scripts
cat > echo_csd/scripts/control.sh << EOF
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
java -jar cm_ext/validator/target/validator.jar -s echo_csd/descriptor/service.sdl
# build jar
cd echo_csd
jar -cvf ECHO-1.0.jar * 
cd ..

#cp -a ECHO-1.0.jar cm master: /opt/cloudera/csd
#service cloudera-scm-server restart

