# Saleor E-commerce

Dự án thương mại điện tử sử dụng Saleor 3.20.82.

## Cấu trúc dự án

- **Saleor Core (Backend)**: Django, GraphQL API
- **Saleor Dashboard (Admin)**: React, Apollo Client
- **Saleor Storefront (Frontend)**: Next.js, Apollo Client

## Yêu cầu hệ thống

- Docker và Docker Compose
- Git
- Node.js (v16+)
- npm hoặc yarn
- Python (3.9+)

## Cài đặt và chạy

### Saleor Core (Backend)

```bash
cd saleor
docker-compose up -d
docker-compose exec api python manage.py migrate
docker-compose exec api python manage.py createsuperuser
docker-compose exec api python manage.py populatedb  # Tùy chọn
```

API GraphQL sẽ chạy tại http://localhost:8000/graphql/

### Saleor Dashboard (Admin)

```bash
cd saleor-dashboard
npm install
npm start
```

Dashboard sẽ chạy tại http://localhost:9000/dashboard/

### Saleor Storefront (Frontend)

```bash
cd react-storefront
npm install
npm run dev
```

Storefront sẽ chạy tại http://localhost:3000/

## Tài liệu tham khảo

- [Saleor Documentation](https://docs.saleor.io/)
- [Saleor GraphQL API](https://docs.saleor.io/docs/3.x/developer/graphql/)
- [Saleor Dashboard](https://github.com/saleor/saleor-dashboard)
- [Saleor Storefront](https://github.com/saleor/react-storefront) 