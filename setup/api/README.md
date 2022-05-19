# instructions

This golang code contains a POC lightweight api gateway microservice, with an emphasis on being a gateway. This service should have very little business logic (i.e. authentication and routing), delegating business logic, queries, and persitence to downstream microservices. 

To deploy to an existing k8s cluster: `kubectl apply -f api.yaml`

If you really want to deploy, you should review and edit the `build.sh` and modify the `api.yaml` to your image. The code and build can be modified to point to an organizational or local registry, if there are plans to expand this part of the POC

# sample curl calls

These assume you can connect to the api using localhost. Replace with hostname or ip address, if necessary.

* `curl http://localhost/api/` to get confirmation that the api works
* `curl -X POST -d "message=hello%20johnny" http://localhost/api/workflow1`
* `curl -X POST -d "message=whats%20up%20doc" http://localhost/api/workflow2`
