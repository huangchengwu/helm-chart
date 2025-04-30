deploy-elkf:
	helm upgrade --install my-elkf  ./elkf --namespace elkf --create-namespace 
deploy-jenkins:
	helm upgrade --install new-jenkins  ./jenkins --namespace jenkins --create-namespace 
influxdb:
	helm upgrade --install new-influxdb  ./influxdb --namespace influxdb --create-namespace 
tdengine:
	helm upgrade --install new-tdengine  ./tdengine --namespace tdengine --create-namespace 
maxscale:
	helm upgrade --install maxscale  ./maxscale --namespace openstack --create-namespace 
aria2-pro:
	helm upgrade --install aria2-pro  ./aria2-pro 


influxdb-cluster:
	helm upgrade --install influxdb-cluster  ./influxdb-cluster --namespace influxdb-cluster --create-namespace 

nexus3:
	helm upgrade --install  nexus3 ./nexus3 --set storageClassName=csi-cephfs-sc  --namespace kube-system
 

