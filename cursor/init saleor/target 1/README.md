# Hướng dẫn sử dụng Saleor E-commerce

## Giới thiệu

Dự án Saleor E-commerce là một hệ thống thương mại điện tử hoàn chỉnh sử dụng Saleor 3.20.82, bao gồm:
- Backend: Saleor Core (GraphQL API)
- Admin: Saleor Dashboard
- Frontend: Saleor Storefront (React/Next.js)

## Cài đặt và cấu hình

### Yêu cầu hệ thống
- Docker và Docker Compose
- Git
- Node.js (v16+)
- npm hoặc yarn
- Python (3.9+)

### Các bước cài đặt

1. **Clone repositories**:
   Tất cả các thành phần đã được clone vào thư mục `project/`:
   - `saleor/` - Backend Core API
   - `saleor-dashboard/` - Admin Dashboard
   - `react-storefront/` - Frontend Storefront

2. **Cấu hình**:
   Các file cấu hình đã được tạo:
   - Backend: `.env` và `docker-compose.yml` trong thư mục `saleor/`
   - Dashboard: `.env` trong thư mục `saleor-dashboard/`
   - Storefront: `.env.local` trong thư mục `react-storefront/`

3. **Khởi động**:
   Sử dụng script có sẵn để khởi động toàn bộ hệ thống:
   - Windows: `start.bat`
   - Linux/Mac: `start.sh`

   Hoặc khởi động từng thành phần riêng biệt:
   - Backend:
     ```bash
     cd saleor
     docker-compose up -d
     ```
   - Dashboard:
     ```bash
     cd saleor-dashboard
     npm install
     npm start
     ```
   - Storefront:
     ```bash
     cd react-storefront
     npm install
     npm run dev
     ```

4. **Khởi tạo dữ liệu**:
   ```bash
   cd saleor
   docker-compose exec api python manage.py migrate
   docker-compose exec api python manage.py createsuperuser
   docker-compose exec api python manage.py populatedb  # Tùy chọn
   ```

## Truy cập hệ thống

- **API GraphQL**: http://localhost:8000/graphql/
- **Admin Dashboard**: http://localhost:9000/dashboard/
- **Storefront**: http://localhost:3000/

## Quản lý cửa hàng

### Quản lý sản phẩm
1. Đăng nhập vào Dashboard với tài khoản admin
2. Vào mục "Products" để thêm, sửa, xóa sản phẩm
3. Cấu hình thuộc tính, biến thể và giá

### Quản lý đơn hàng
1. Vào mục "Orders" để xem và quản lý đơn hàng
2. Xử lý việc thanh toán và giao hàng

### Cấu hình cửa hàng
1. Vào mục "Configuration" để thiết lập:
   - Shipping methods
   - Tax settings
   - Staff accounts
   - Permissions

## Troubleshooting

1. **Docker không khởi động**:
   - Đảm bảo Docker Desktop đang chạy
   - Kiểm tra logs: `docker-compose logs -f`

2. **Dashboard hoặc Storefront không kết nối được với API**:
   - Kiểm tra API đang chạy: `http://localhost:8000/graphql/`
   - Kiểm tra cấu hình API URL trong file `.env`

3. **Port conflict**:
   - Đảm bảo các port 8000, 9000, 3000 không bị chiếm bởi ứng dụng khác 