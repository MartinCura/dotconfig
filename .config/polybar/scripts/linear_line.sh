#!/usr/bin/env bash
source $(dirname "$0")/.env

N_TODO=$( \
  curl --silent \
  -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: ${LINEAR_API_KEY}" \
  --data '{ "query": "{ issues(filter: { state: { name: { eq: \"Todo\" } } }) { nodes { title } } }" }' \
  https://api.linear.app/graphql \
  | jq '.data.issues.nodes | length'
)
N_INPROGRESS=$( \
  curl --silent \
  -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: ${LINEAR_API_KEY}" \
  --data '{ "query": "{ issues(filter: { state: { name: { eq: \"In Progress\" } } }) { nodes { title } } }" }' \
  https://api.linear.app/graphql \
  | jq '.data.issues.nodes | length' 
)

echo "Todo: ${N_TODO}, In Progress: ${N_INPROGRESS}"
