build:
	rm -rf chart/*.tgz
	rm -rf chart/index.yaml
	rm -rf *.tgz
	helm package mysql
	helm package redis
	mv *.tgz chart
	helm repo index chart --url https://huangchengwu.github.io/helm-chart/chart