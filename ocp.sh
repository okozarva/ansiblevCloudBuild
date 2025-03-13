oc get pvc --all-namespaces -o jsonpath='{range .items[?(@.spec.storageClassName=="ibm-spectrum-scale-csi-fileset")]}{.metadata.namespace}{" "}{.metadata.name}{"\n"}{end}' | \
while read ns pvc; do
  oc get pods -n "$ns" -o jsonpath='{range .items[?(@.spec.volumes[*].persistentVolumeClaim.claimName=="'$pvc'")]}{.metadata.name}{"\n"}{end}' | \
  awk -v ns="$ns" '{print ns " " $0}'
done | sort -u