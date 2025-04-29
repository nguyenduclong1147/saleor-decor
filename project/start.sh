#!/bin/bash

# Start Saleor Core
cd saleor
docker-compose up -d
echo "Saleor Core is running at http://localhost:8000/graphql/"

# Start Saleor Dashboard
cd ../saleor-dashboard
npm start &
echo "Saleor Dashboard is running at http://localhost:9000/dashboard/"

# Start Saleor Storefront
cd ../react-storefront
npm run dev &
echo "Saleor Storefront is running at http://localhost:3000/" 