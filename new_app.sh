#!/bin/bash
helm create $1
rm -rf $1/templates/*
rm -rf $1/charts/*
rm -rf $1/.helmignore
cat > $1/values.yaml<<EOF
storageClassName: csi-cephrdb-sc1
image: $1
storageSite: 50Gi
EOF
cat prometheus/Chart.yaml|grep -v "^#"|grep -v "^$" >$1/c.yaml
mv $1/c.yaml $1/Chart.yaml

cat > $1/templates/dep.yaml<<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $1
  namespace: {{ .Release.Namespace }}
spec:
  replicas: 1
  selector:
    matchLabels:
      app: $1
  template:
    metadata:
      labels:
        app: $1
    spec:
      containers:
        - name: $1
          image: {{ .Values.image }} 
          ports:
            - containerPort: 80
          volumeMounts:
            - name: $1-data
              mountPath: /$1-data
      volumes:
        - name: $1-data
          persistentVolumeClaim:
            claimName: $1-pvc
EOF

cat > $1/templates/svc.yaml<<EOF
apiVersion: v1
kind: Service
metadata:
  name: $1-svc
  namespace: {{ .Release.Namespace }}
spec:
  selector:
    app: $1
  ports:
    - protocol: TCP
      name: $1-80
      port: 80
      targetPort: 80
  type: NodePort
EOF

cat > $1/templates/pvc.yaml<<EOF
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: $1-pvc
  namespace: {{ .Release.Namespace }}
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage:  {{ .Values.storageSite }}  
  storageClassName:  {{ .Values.storageClassName }} 
  volumeMode: Filesystem
EOF

