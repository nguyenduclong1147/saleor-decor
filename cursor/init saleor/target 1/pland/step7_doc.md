# Tài liệu triển khai Saleor E-commerce

## I. Giới thiệu về Saleor

Saleor là một nền tảng e-commerce headless hiện đại, được xây dựng trên Django và GraphQL. Nó cung cấp một giải pháp e-commerce linh hoạt, có thể mở rộng và tùy biến cao.

### Kiến trúc tổng thể

Saleor được chia thành ba phần chính:
1. **Saleor Core** (Backend): Django, GraphQL API
2. **Saleor Dashboard** (Admin): React, Apollo Client
3. **Saleor Storefront** (Frontend): Next.js, Apollo Client

## II. Yêu cầu hệ thống

### Môi trường phát triển

Trước khi bắt đầu triển khai, đảm bảo máy tính có các công cụ sau:

- **Docker và Docker Compose**: Phiên bản 20.10+ và 1.29+
- **Git**: Phiên bản 2.25+
- **Node.js**: Phiên bản 16+
- **npm** hoặc **yarn**: Phiên bản 7+ hoặc 1.22+
- **Python**: Phiên bản 3.9+
- **PostgreSQL**: Phiên bản 13+ (được cài đặt qua Docker)

### Yêu cầu phần cứng tối thiểu

- **CPU**: 2 cores
- **RAM**: 4GB (8GB khuyến nghị)
- **Disk**: 20GB trống

## III. Cài đặt và triển khai

### 1. Thiết lập môi trường phát triển

#### 1.1 Cài đặt công cụ cần thiết

Trên Ubuntu/Debian:

```bash
# Cài đặt Docker và Docker Compose
sudo apt update
sudo apt install docker.io docker-compose

# Cài đặt Git
sudo apt install git

# Cài đặt Node.js và npm
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install nodejs

# Cài đặt Python
sudo apt install python3 python3-pip python3-venv
```

Trên MacOS:

```bash
# Sử dụng Homebrew
brew install docker docker-compose git node python@3.9
```

Trên Windows:
- Cài đặt Docker Desktop từ [website Docker](https://www.docker.com/products/docker-desktop)
- Cài đặt Git từ [git-scm.com](https://git-scm.com/download/win)
- Cài đặt Node.js từ [nodejs.org](https://nodejs.org/)
- Cài đặt Python từ [python.org](https://www.python.org/downloads/)

#### 1.2 Clone repositories

```bash
# Tạo thư mục cho dự án
mkdir saleor-project && cd saleor-project

# Clone Saleor Core (Backend)
git clone https://github.com/saleor/saleor.git

# Clone Saleor Dashboard (Admin)
git clone https://github.com/saleor/saleor-dashboard.git

# Clone Saleor Storefront (Frontend)
git clone https://github.com/saleor/react-storefront.git
```

### 2. Cài đặt Saleor Core (Backend)

#### 2.1 Cấu hình môi trường

Đi vào thư mục Saleor Core:

```bash
cd saleor
```

Tạo file `.env` với nội dung sau:

```
SECRET_KEY=your-secret-key
DEBUG=True
DATABASE_URL=postgres://saleor:saleor@db/saleor
CELERY_BROKER_URL=redis://redis:6379/1
```

#### 2.2 Khởi động Docker Containers

```bash
# Xây dựng và khởi động các container
docker-compose up -d
```

Container đang chạy sẽ bao gồm:
- `api`: Saleor API (Django)
- `db`: PostgreSQL database
- `redis`: Redis cache
- `celery`: Celery worker
- `celery-beat`: Celery beat scheduler

#### 2.3 Khởi tạo cơ sở dữ liệu

```bash
# Chạy migrations
docker-compose exec api python manage.py migrate

# Tạo tài khoản superuser
docker-compose exec api python manage.py createsuperuser

# Tạo dữ liệu mẫu (tùy chọn)
docker-compose exec api python manage.py populatedb
```

#### 2.4 Kiểm tra API

API GraphQL sẽ chạy tại `http://localhost:8000/graphql/`. Bạn có thể sử dụng GraphQL Playground để thử nghiệm API.

Thử query đơn giản:

```graphql
{
  products(first: 5) {
    edges {
      node {
        id
        name
        description
      }
    }
  }
}
```

### 3. Cài đặt Saleor Dashboard (Admin)

#### 3.1 Cài đặt dependencies

```bash
cd ../saleor-dashboard
npm install
```

#### 3.2 Cấu hình

Tạo file `.env` với nội dung sau:

```
API_URI=http://localhost:8000/graphql/
APP_MOUNT_URI=/dashboard/
```

#### 3.3 Khởi động development server

```bash
npm start
```

Dashboard sẽ chạy tại `http://localhost:9000/dashboard/`. Đăng nhập bằng tài khoản superuser đã tạo ở bước trước.

### 4. Cài đặt Saleor Storefront (Frontend)

#### 4.1 Cài đặt dependencies

```bash
cd ../react-storefront
npm install
```

#### 4.2 Cấu hình

Tạo file `.env.local` với nội dung sau:

```
NEXT_PUBLIC_API_URI=http://localhost:8000/graphql/
NEXT_PUBLIC_CHECKOUT_APP_URL=http://localhost:3001/checkout-spa/
```

#### 4.3 Khởi động development server

```bash
npm run dev
```

Storefront sẽ chạy tại `http://localhost:3000/`.

### 5. Tùy chỉnh và mở rộng

#### 5.1 Backend

##### Tạo custom Django app

```bash
cd saleor
docker-compose exec api python manage.py startapp custom_app
```

Thêm app mới vào `INSTALLED_APPS` trong file `saleor/settings.py`:

```python
INSTALLED_APPS = [
    # ...
    'custom_app',
]
```

##### Mở rộng models

Ví dụ, mở rộng model Product trong `custom_app/models.py`:

```python
from django.db import models
from saleor.product.models import Product

class ProductExtension(models.Model):
    product = models.OneToOneField(
        Product, on_delete=models.CASCADE, related_name="extension"
    )
    custom_field = models.CharField(max_length=255, blank=True)
```

##### Tùy chỉnh GraphQL schema

Tạo file `custom_app/schema.py`:

```python
import graphene
from graphene_django import DjangoObjectType
from .models import ProductExtension

class ProductExtensionType(DjangoObjectType):
    class Meta:
        model = ProductExtension

class Query(graphene.ObjectType):
    product_extensions = graphene.List(ProductExtensionType)
    
    def resolve_product_extensions(self, info):
        return ProductExtension.objects.all()

schema = graphene.Schema(query=Query)
```

#### 5.2 Dashboard

##### Tùy chỉnh giao diện quản trị

Tạo component mới trong Dashboard:

```jsx
// src/custom/CustomComponent.tsx
import React from "react";
import { Typography } from "@material-ui/core";

const CustomComponent: React.FC = () => (
  <div>
    <Typography variant="h1">Custom Component</Typography>
  </div>
);

export default CustomComponent;
```

#### 5.3 Storefront

##### Tùy chỉnh giao diện người dùng

Tạo component mới trong Storefront:

```jsx
// components/CustomComponent.tsx
import React from "react";

const CustomComponent: React.FC = () => (
  <div className="custom-component">
    <h1>Custom Component</h1>
  </div>
);

export default CustomComponent;
```

### 6. Triển khai production

#### 6.1 Cấu hình bảo mật

Cập nhật file `.env` trong Saleor Core:

```
SECRET_KEY=your-very-secure-secret-key
DEBUG=False
ALLOWED_HOSTS=your-domain.com,www.your-domain.com
DATABASE_URL=postgres://saleor:secure-password@db/saleor
DEFAULT_FROM_EMAIL=noreply@your-domain.com
```

#### 6.2 Docker Compose cho production

Tạo file `docker-compose.prod.yml`:

```yaml
version: '3'

services:
  api:
    image: saleor/saleor:latest
    restart: always
    depends_on:
      - db
      - redis
    env_file: .env
    volumes:
      - ./media:/app/media
      - ./static:/app/static
    environment:
      - PYTHONOPTIMIZE=1

  db:
    image: postgres:13
    restart: always
    volumes:
      - postgres-data:/var/lib/postgresql/data
    environment:
      - POSTGRES_USER=saleor
      - POSTGRES_PASSWORD=secure-password
      - POSTGRES_DB=saleor

  redis:
    image: redis:6
    restart: always
    volumes:
      - redis-data:/data

  celery:
    image: saleor/saleor:latest
    restart: always
    command: celery -A saleor worker --loglevel=info
    depends_on:
      - redis
    env_file: .env

  celery-beat:
    image: saleor/saleor:latest
    restart: always
    command: celery -A saleor beat --loglevel=info
    depends_on:
      - redis
    env_file: .env

  nginx:
    image: nginx:1.21
    restart: always
    volumes:
      - ./nginx/conf.d:/etc/nginx/conf.d
      - ./nginx/ssl:/etc/nginx/ssl
      - ./media:/app/media
      - ./static:/app/static
    ports:
      - "80:80"
      - "443:443"

volumes:
  postgres-data:
  redis-data:
```

#### 6.3 Cấu hình Nginx

Tạo file `nginx/conf.d/saleor.conf`:

```nginx
server {
    listen 80;
    server_name your-domain.com www.your-domain.com;
    
    # Redirect HTTP to HTTPS
    location / {
        return 301 https://$host$request_uri;
    }
}

server {
    listen 443 ssl;
    server_name your-domain.com www.your-domain.com;
    
    ssl_certificate /etc/nginx/ssl/fullchain.pem;
    ssl_certificate_key /etc/nginx/ssl/privkey.pem;
    
    # API
    location /graphql/ {
        proxy_pass http://api:8000/graphql/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
    
    # Media files
    location /media/ {
        alias /app/media/;
    }
    
    # Static files
    location /static/ {
        alias /app/static/;
    }
    
    # Dashboard
    location /dashboard/ {
        proxy_pass http://dashboard:9000/dashboard/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
    
    # Storefront
    location / {
        proxy_pass http://storefront:3000/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

#### 6.4 Cài đặt SSL với Let's Encrypt

```bash
# Cài đặt certbot
sudo apt install certbot python3-certbot-nginx

# Lấy chứng chỉ SSL
sudo certbot --nginx -d your-domain.com -d www.your-domain.com
```

#### 6.5 Triển khai lên server

```bash
# Khởi động containers
docker-compose -f docker-compose.prod.yml up -d

# Chạy migrations
docker-compose -f docker-compose.prod.yml exec api python manage.py migrate

# Tạo tài khoản superuser
docker-compose -f docker-compose.prod.yml exec api python manage.py createsuperuser

# Thu thập static files
docker-compose -f docker-compose.prod.yml exec api python manage.py collectstatic --noinput
```

#### 6.6 Backup và cập nhật

Thiết lập backup tự động:

```bash
# Tạo script backup.sh
cat > backup.sh << 'EOF'
#!/bin/bash
DATE=$(date +%Y-%m-%d)
# Backup database
docker-compose -f docker-compose.prod.yml exec -T db pg_dump -U saleor saleor > backup-$DATE.sql
# Backup media files
tar -czf media-$DATE.tar.gz media/
EOF

# Cấp quyền thực thi
chmod +x backup.sh

# Thêm vào crontab
(crontab -l 2>/dev/null; echo "0 2 * * * /path/to/backup.sh") | crontab -
```

Quy trình cập nhật:

```bash
# Pull latest changes
git pull

# Rebuild and restart containers
docker-compose -f docker-compose.prod.yml up -d --build

# Run migrations
docker-compose -f docker-compose.prod.yml exec api python manage.py migrate

# Collect static files
docker-compose -f docker-compose.prod.yml exec api python manage.py collectstatic --noinput
```

## IV. Kiểm thử và giám sát

### Kiểm thử API

```bash
# Kiểm tra server status
curl -I http://your-domain.com/graphql/
```

### Kiểm thử Dashboard

Truy cập `https://your-domain.com/dashboard/` và kiểm tra:
- Đăng nhập
- Quản lý sản phẩm
- Quản lý đơn hàng
- Quản lý người dùng

### Kiểm thử Storefront

Truy cập `https://your-domain.com/` và kiểm tra:
- Hiển thị sản phẩm
- Thêm vào giỏ hàng
- Thanh toán
- Đăng ký và đăng nhập

## V. Kết luận

Tài liệu này cung cấp hướng dẫn chi tiết để triển khai Saleor E-commerce từ môi trường phát triển đến production. Quan trọng là duy trì hệ thống:
- Thường xuyên cập nhật các phiên bản mới
- Kiểm tra lỗ hổng bảo mật
- Backup dữ liệu định kỳ
- Mở rộng chức năng khi cần thiết

Việc sử dụng Docker giúp đơn giản hóa quá trình triển khai và bảo trì. Kiến trúc headless của Saleor cho phép tùy biến và mở rộng linh hoạt để đáp ứng các nhu cầu kinh doanh cụ thể. 