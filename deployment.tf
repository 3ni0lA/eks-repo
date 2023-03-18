---
apiVersion: apps/v1
kind: Deployment
metadata : 
   namespace: laravel
   name: laravel
   spec: 
    replicas: 3
    selector: 
      match_labels:
        app: mylaravelapp
      template: 
      metadata: 
        labels:
          app: = "my-laravel-app"
      spec :
        container:
        -  name: laravel-pod
           image: 3niola/webapp02:latest
           imagePULLPolicy: IfNotPresent
           ports: 
           - container_port:  80
        env:
          - name: PORT
            value: "80"
