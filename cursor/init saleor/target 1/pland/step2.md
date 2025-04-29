# Step 2: Class Diagram (Bản vẽ lớp)

## Mục tiêu
- Xác định đầy đủ các lớp chính trong hệ thống thương mại điện tử Saleor
- Mô tả thuộc tính và phương thức của từng lớp
- Vẽ mối quan hệ giữa các lớp
- Tạo bản vẽ class diagram cho toàn bộ hệ thống

## Các bước thực hiện

### 1. Xác định các lớp chính trong hệ thống
- **Lớp quản lý sản phẩm**: Product, ProductVariant, Category, ProductType, Attribute...
- **Lớp quản lý đơn hàng**: Order, OrderLine, Checkout, Cart...
- **Lớp người dùng**: User, Customer, Staff, Address...
- **Lớp thanh toán**: Payment, Transaction, PaymentMethod...
- **Lớp vận chuyển**: ShippingMethod, ShippingZone, Warehouse...
- **Lớp khuyến mãi**: Promotion, Discount, Voucher...

### 2. Xác định thuộc tính của từng lớp
- Xác định các thuộc tính (attributes) của mỗi lớp
- Xác định kiểu dữ liệu của mỗi thuộc tính
- Xác định phạm vi truy cập (public, private, protected)

### 3. Xác định phương thức của từng lớp
- Xác định các phương thức (methods) của mỗi lớp
- Xác định các tham số đầu vào và kiểu dữ liệu trả về
- Xác định phạm vi truy cập của mỗi phương thức

### 4. Xác định mối quan hệ giữa các lớp
- Mối quan hệ kế thừa (inheritance)
- Mối quan hệ kết hợp (association)
- Mối quan hệ tổng hợp (composition)
- Mối quan hệ tập hợp (aggregation)
- Mối quan hệ phụ thuộc (dependency)

### 5. Vẽ Class Diagram
- Sử dụng công cụ vẽ diagram (Lucidchart, draw.io, PlantUML)
- Thể hiện đầy đủ các lớp, thuộc tính, phương thức và mối quan hệ
- Sắp xếp các lớp theo nhóm chức năng
- Thêm chú thích và mô tả khi cần thiết 