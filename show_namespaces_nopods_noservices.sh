#!/bin/bash

# Obter a lista de namespaces
namespaces=$(oc get namespaces -o jsonpath='{.items[*].metadata.name}')

# Listar namespaces sem Pods e Services em execução
echo "Namespaces sem Pods e Services em execução:"
for ns in $namespaces; do
    # Verificar a contagem de Pods
    pod_count=$(oc get pods -n "$ns" --no-headers 2>/dev/null | grep -c 'Running')

    # Verificar a contagem de Services
    svc_count=$(oc get svc -n "$ns" --no-headers 2>/dev/null | wc -l)

    # Se não houver Pods nem Services, listar o namespace
    if [ "$pod_count" -eq 0 ] && [ "$svc_count" -eq 0 ]; then
        echo "$ns"
    fi
done

