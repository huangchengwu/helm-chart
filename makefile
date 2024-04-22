deploy-elkf:
	helm upgrade --install my-elkf  ./elkf --namespace elkf --create-namespace 
deploy-jenkins:

	helm upgrade --install new-jenkins  ./jenkins --namespace jenkins --create-namespace 

