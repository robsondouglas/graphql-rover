export APOLLO_KEY=service:PoC-Veiculo:LqQQNvTWfwNxXf9RWwaQOQ
  
curl -sSL -o cidadao.graphql https://raw.githubusercontent.com/robsondouglas/graphql-lambda-pessoa/main/src/schema.graphql
curl -sSL -o veiculo.graphql https://raw.githubusercontent.com/robsondouglas/graphql-lambda-veiculo/main/src/schema.graphql
curl -sSL -o multa.graphql   https://raw.githubusercontent.com/robsondouglas/graphql-lambda-multa/main/src/schema.graphql   

rover subgraph publish PoC-Veiculo@current --name cidadao --schema cidadao.graphql --routing-url https://jkmwsipoth.execute-api.sa-east-1.amazonaws.com/
rover subgraph publish PoC-Veiculo@current --name veiculo --schema veiculo.graphql --routing-url https://kruaylxn3a.execute-api.sa-east-1.amazonaws.com/
rover subgraph publish PoC-Veiculo@current --name multa   --schema multa.graphql   --routing-url https://zw2sb7aw8k.execute-api.sa-east-1.amazonaws.com/
  