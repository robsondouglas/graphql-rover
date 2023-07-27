# echo "***** CONFIGURANDO OS CONTAINERS DE DESENVOLVIMENTO *****"
# containerName=("src_veiculo" "src_cidadao" "src_multa")
# networkName=graphql_poc

# echo "- Verificando ${networkName}..."
# if [[ "$(docker network ls | grep "${networkName}")" == "" ]] ; then 
#      docker network create ${networkName} ;
#      echo "     Rede ${networkName} criada!"
# else
#     echo "     Rede ${networkName} já existe."
# fi


# echo "- Verificando os containers"
# for value in "${containerName[@]}"
# do
#     if [ "$(docker ps -a -q -f name=${value})" != "" ]; then
#         if [ "$(docker container inspect ${value} -f '{{.NetworkSettings.Networks}}' | grep "${networkName}")" == "" ] ; then
#             docker network connect ${networkName} ${value}
#             echo "     ${value} conectado na rede ${networkName}"
#         else
#             echo "     ${value} já faz parte da rede ${networkName}"
#         fi
#     else
#         echo "#### DevContainer ${value} não foi criado"
#     fi
# done
# echo "*********************************************************"
# echo ""
# echo ""
echo "***************## CONFIGURANDO O ROVER *****************"
docker build . -t rover
docker run -p 4001:4000 \
  --name rover-exec \
  --env APOLLO_ELV2_LICENSE=accept \
  --mount "type=bind,source=./graph/supergraph-config.yaml,target=/graph/supergraph-config.yaml" \
  --rm  \
  rover
docker rm rover-exec
echo "*********************************************************"
echo ""
echo ""
echo "***************## CONFIGURANDO O ROUTER *****************"
docker run -p 4001:4000 \
  --name router \
  --env APOLLO_GRAPH_REF="/dist/config/supergraph.graphql" \
  --mount "type=bind,source=./graph/supergraph.graphql,target=/dist/config/supergraph.graphql" \
  --mount "type=bind,source=./graph/router.yaml,target=/dist/config/router.yaml" \
  --rm  \
  ghcr.io/apollographql/router:v1.25.0

echo "*********************************************************"
