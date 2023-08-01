FILE=./graph/supergraph.graphqlz
if ! -f "$FILE"; then
  echo "***************## CONFIGURANDO O ROVER *****************"
  docker build . -t rover
  docker run -p 4000:4000 \
    --name rover-exec \
    --env APOLLO_ELV2_LICENSE=accept \
    --mount "type=bind,source=./graph/supergraph-config.yaml,target=/graph/supergraph-config.yaml" \
    --mount "type=bind,source=./graph/,target=/graph/" \
    --rm  \
    rover
  docker rm rover-exec
  echo "*********************************************************"
  echo ""
  echo ""
fi

echo "***************## CONFIGURANDO O ROUTER *****************"
docker run -p 4000:4000 \
  --name router \
  --mount "type=bind,source=./graph/supergraph.graphql,target=/dist/config/supergraph.graphql" \
  --mount "type=bind,source=./graph/router.yaml,target=/dist/config/router.yaml" \
  --rm  \
  ghcr.io/apollographql/router:v1.25.0 \
  --log debug \
  --supergraph="/dist/config/supergraph.graphql"\
  --dev  
  ho "*********************************************************"
