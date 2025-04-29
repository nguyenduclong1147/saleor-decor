# Bước 7.1: Cài đặt Saleor Core (Backend)

## Mục tiêu
Cài đặt và cấu hình thành phần backend (API) của Saleor E-commerce, tạo cơ sở cho toàn bộ hệ thống.

## Các bước thực hiện

### 1. Clone repository Saleor platform

Saleor platform là một repository chứa đầy đủ các thành phần của hệ sinh thái Saleor, bao gồm API, Dashboard, và Storefront.

```bash
git clone https://github.com/saleor/saleor-platform.git
cd saleor-platform
```

### 2. Cấu hình môi trường Docker

Saleor sử dụng Docker để đảm bảo các thành phần hoạt động trong môi trường đồng nhất và dễ dàng triển khai.

```bash
# Build tất cả các Docker images
docker-compose build
```

Kiểm tra file `docker-compose.yml` để xem cấu hình chi tiết các services:
- `api`: Service chính chứa Saleor API (Django)
- `db`: PostgreSQL database
- `redis`: Redis cache
- `celery`: Celery worker xử lý các tác vụ bất đồng bộ
- `dashboard`: Saleor Dashboard (React)
- `storefront`: Saleor Storefront (Next.js)

### 3. Khởi tạo cơ sở dữ liệu

Sau khi build xong các images, cần khởi tạo cấu trúc cơ sở dữ liệu:

```bash
# Chạy migrations để tạo schema database
docker-compose run --rm api python manage.py migrate

# Tạo dữ liệu mẫu (optional, nhưng nên thực hiện để có dữ liệu ban đầu)
docker-compose run --rm api python manage.py populatedb

# Tạo tài khoản admin để truy cập Dashboard
docker-compose run --rm api python manage.py createsuperuser
```

### 4. Cấu hình cơ bản

Các thiết lập cơ bản được định nghĩa trong file `saleor/settings.py`. Dưới đây là một số thiết lập quan trọng:

#### Cơ sở dữ liệu

```python
DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.postgresql",
        "NAME": os.environ.get("POSTGRES_DB", "saleor"),
        "USER": os.environ.get("POSTGRES_USER", "saleor"),
        "PASSWORD": os.environ.get("POSTGRES_PASSWORD", "saleor"),
        "HOST": os.environ.get("POSTGRES_HOST", "db"),
        "PORT": os.environ.get("POSTGRES_PORT", "5432"),
    }
}
```

#### Redis cache

```python
CACHES = {
    "default": {
        "BACKEND": "django_redis.cache.RedisCache",
        "LOCATION": os.environ.get("REDIS_URL", "redis://redis:6379/0"),
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
        },
    }
}
```

#### Celery configuration

```python
CELERY_BROKER_URL = os.environ.get("CELERY_BROKER_URL", "redis://redis:6379/1")
CELERY_TASK_ALWAYS_EAGER = False
CELERY_ACCEPT_CONTENT = ["json"]
CELERY_TASK_SERIALIZER = "json"
CELERY_RESULT_SERIALIZER = "json"
```

### 5. Khởi động Saleor API

Để chạy toàn bộ stack Saleor:

```bash
docker-compose up
```

Hoặc chỉ khởi động API service:

```bash
docker-compose up api
```

Sau khi khởi động, Saleor API sẽ có sẵn tại:
- GraphQL API: http://localhost:8000/graphql/
- Django Admin: http://localhost:8000/admin/

### 6. Cấu hình tùy chỉnh

#### Các plugins hệ thống

Saleor sử dụng hệ thống plugins để mở rộng chức năng. Cấu hình plugins trong `settings.py`:

```python
PLUGINS = [
    "saleor.plugins.avatax.plugin.AvataxPlugin",
    "saleor.plugins.vatlayer.plugin.VatlayerPlugin",
    "saleor.plugins.webhook.plugin.WebhookPlugin",
    "saleor.payment.gateways.dummy.plugin.DummyGatewayPlugin",
    "saleor.payment.gateways.stripe.plugin.StripeGatewayPlugin",
    "saleor.payment.gateways.paypal.plugin.PaypalGatewayPlugin",
]
```

#### Cấu hình CORS

Để cho phép các clients từ domain khác giao tiếp với Saleor API:

```python
ALLOWED_HOSTS = ["localhost", "127.0.0.1"]
CORS_ALLOWED_ORIGINS = [
    "http://localhost:3000",  # Storefront
    "http://localhost:9000",  # Dashboard
]
```

#### Authentication

Saleor sử dụng JWT cho authentication. Cấu hình JWT trong settings:

```python
JWT_EXPIRE = True
JWT_TTL_ACCESS = timedelta(seconds=int(os.environ.get("JWT_TTL_ACCESS", 3600)))
JWT_TTL_APP_ACCESS = timedelta(seconds=int(os.environ.get("JWT_TTL_APP_ACCESS", 604800)))
JWT_TTL_REFRESH = timedelta(seconds=int(os.environ.get("JWT_TTL_REFRESH", 30 * 24 * 60 * 60)))
```

### 7. Kiểm tra cài đặt

#### Kiểm tra GraphQL API

Mở GraphQL Playground tại http://localhost:8000/graphql/ và thực hiện query đơn giản:

```graphql
{
  products(first: 5) {
    edges {
      node {
        id
        name
        description
        pricing {
          priceRange {
            start {
              gross {
                amount
                currency
              }
            }
          }
        }
      }
    }
  }
}
```

#### Kiểm tra backend services

Kiểm tra logs của các services để đảm bảo hoạt động bình thường:

```bash
docker-compose logs api
docker-compose logs db
docker-compose logs redis
docker-compose logs celery
```

## Kết quả đạt được
- ✅ Saleor API đã được cài đặt và cấu hình
- ✅ Cơ sở dữ liệu PostgreSQL hoạt động bình thường
- ✅ Redis cache đã được thiết lập
- ✅ Celery worker đã sẵn sàng xử lý background tasks
- ✅ GraphQL API có thể truy cập từ frontend clients
- ✅ Admin account đã được tạo để quản lý hệ thống

## Các vấn đề thường gặp và cách giải quyết

### Database connection errors
- Kiểm tra cấu hình kết nối database trong `.env` và `settings.py`
- Đảm bảo service PostgreSQL đang chạy: `docker-compose ps`

### Migration errors
- Reset database và chạy lại migrations: 
  ```bash
  docker-compose down -v
  docker-compose up -d db
  docker-compose run --rm api python manage.py migrate
  ```

### GraphQL API không hoạt động
- Kiểm tra logs của API service: `docker-compose logs api`
- Đảm bảo Django server đang chạy
- Kiểm tra cấu hình CORS nếu gọi từ domain khác

## Bước tiếp theo
Sau khi hoàn thành cài đặt Saleor Core (Backend), bước tiếp theo là cài đặt Saleor Dashboard (Admin) để quản lý hệ thống thông qua giao diện người dùng. 