# copy files in include/dataset/countries.csv to GCS
gsutil -m cp -r ../include/dataset/countries.csv gs://retail-etl-dsy/dataset