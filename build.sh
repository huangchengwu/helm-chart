#!/bin/bash
rm -rf chart/*.tgz
rm -rf chart/index.yaml
rm -rf *.tgz

for k in $(ls -l | grep -v -E "chart|make|README.md" | awk '{print $9}'); do
    helm package $k
  
done
mv *.tgz chart
helm repo index chart --url https://huangchengwu.github.io/helm-chart/chart
git add *
git commit -m "add"
git push -f
