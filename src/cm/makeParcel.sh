#!/bin/bash

# dir structure
:<<comment!
├── ECHO-1.0
│   └── meta
│       ├── echo_env.sh
│       └── parcel.json
├── ECHO-1.0-el6.parcel
├── ECHO-1.0-el6.parcel.sha1
└── manifest.json
comment!


parcel_name=ECHO-1.0
mkdir -p $parcel_name/meta

cat > ${parcel_name}/meta/parcel.json <<EOF
{
    "schema_version":1,
    "name":"ECHO",
    "version":"1.0",
    "setActiveSymlink":true,
    "conflicts":"",
    "provides":[
        "ECHO"
    ],
    "scripts":{
        "defines":"echo_env.sh"
    },
    "packages":[
        {
            "name":"echo",
            "version":"1.0"
        }
    ],
    "components":[
        {
            "name":"echo",
            "version":"1.0",
            "pkg_version":"1.0",
            "pkg_release":"1.0"
        }
    ],
    "users":{},
    "groups":[]
}
EOF


cat > ${parcel_name}/meta/echo_env.sh <<EOF
#!/bin/bash

ECHO_DIRNAME=\${PARCEL_DIRNAME}
export CDH_ECHO_HOME=\${PARCELS_ROOT}/\${ECHO_DIRNAME}
EOF


echo "validate parcel.json"
java -jar cm_ext/validator/target/validator.jar -p ECHO-1.0/meta/parcel.json

echo "validate directory"
java -jar cm_ext/validator/target/validator.jar -d ECHO-1.0

echo "generate parcel"
tar czvf ECHO-1.0-el6.parcel ECHO-1.0  # —owner=root —group=root

echo "validate parcel"
java -jar cm_ext/validator/target/validator.jar -f ECHO-1.0-el6.parcel
exit

mkdir parcelService && cd parcelService

python cm_ext/make_manifest/make_manifest.py ./parcelService
python -m SimpleHTTPServer 8001


