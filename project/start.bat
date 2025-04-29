@echo off
echo Starting Saleor E-commerce...

REM Start Saleor Core
cd saleor
docker-compose up -d
echo Saleor Core is running at http://localhost:8000/graphql/

REM Start Saleor Dashboard
cd ..\saleor-dashboard
start cmd /k npm start

REM Start Saleor Storefront
cd ..\react-storefront
start cmd /k npm run dev

echo Saleor E-commerce is starting...
echo Dashboard will be available at http://localhost:9000/dashboard/
echo Storefront will be available at http://localhost:3000/ 