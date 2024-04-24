# copy files in include/dataset to GCS
gsutil -m cp -r ../include/dataset/* gs://retail-etl-dsy/dataset