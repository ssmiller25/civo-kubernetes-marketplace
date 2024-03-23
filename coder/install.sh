kubectl create namespace coder
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install coder-db bitnami/postgresql \
    --namespace coder \
    --set auth.username=coder \
    --set auth.password=coder \
    --set auth.database=coder \
    --set persistence.size=10Gi

kubectl create secret generic coder-db-url -n coder \
   --from-literal=url="postgres://coder:coder@coder-db-postgresql.coder.svc.cluster.local:5432/coder?sslmode=disable"

helm repo add coder-v2 https://helm.coder.com/v2

helm install coder coder-v2/coder \
    --namespace coder \
    --values values.yaml

kubectl apply -f ingress.yaml