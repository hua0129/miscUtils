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


parcel_name=SPLICEMACHINE-2.7.0.1833.cdh5.14.0.p0.138

echo "validate parcel.json"
java -jar cm_ext/validator/target/validator.jar -p ${parcel_name}/meta/parcel.json

echo "validate directory"
java -jar cm_ext/validator/target/validator.jar -d ${parcel_name}

echo "generate parcel"
tar czvf ${parcel_name}-el7.parcel ${parcel_name} --owner=root --group=root

echo "validate parcel"
java -jar cm_ext/validator/target/validator.jar -f ${parcel_name}-el7.parcel
exit

mkdir parcelService && cd parcelService

python cm_ext/make_manifest/make_manifest.py ./parcelService
python -m SimpleHTTPServer 8001


