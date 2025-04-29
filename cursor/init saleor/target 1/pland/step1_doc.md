# Use Case Diagram cho Hệ thống Thương mại điện tử Saleor

## Tổng quan

Use Case Diagram mô tả các tác nhân và các trường hợp sử dụng chính trong hệ thống thương mại điện tử Saleor. Diagarm này minh họa cách các tác nhân tương tác với hệ thống và các chức năng mà hệ thống cung cấp.

## Actors (Tác nhân)

1. **Khách hàng không đăng nhập (Guest)**
   - Người truy cập website nhưng chưa đăng nhập/đăng ký tài khoản

2. **Khách hàng đã đăng nhập (Customer)**
   - Người dùng đã đăng ký và đăng nhập vào tài khoản

3. **Quản trị viên (Administrator)**
   - Người có toàn quyền quản lý hệ thống

4. **Nhân viên bán hàng (Staff)**
   - Nhân viên được phân quyền quản lý một số chức năng

5. **Hệ thống thanh toán (Payment Provider)**
   - Hệ thống bên thứ ba xử lý các giao dịch thanh toán

6. **Hệ thống vận chuyển (Shipping Provider)**
   - Hệ thống bên thứ ba xử lý việc vận chuyển đơn hàng

## Use Cases (Trường hợp sử dụng)

### Chức năng dành cho Khách hàng (Guest & Customer)

1. **Đăng ký/Đăng nhập**
   - Đăng ký tài khoản mới
   - Đăng nhập vào tài khoản
   - Khôi phục mật khẩu
   - Đăng nhập bằng mạng xã hội

2. **Duyệt sản phẩm**
   - Xem danh sách sản phẩm
   - Xem chi tiết sản phẩm
   - Lọc sản phẩm theo danh mục
   - Sắp xếp sản phẩm

3. **Tìm kiếm sản phẩm**
   - Tìm kiếm theo từ khóa
   - Tìm kiếm nâng cao (theo giá, danh mục, thuộc tính...)

4. **Thêm vào giỏ hàng**
   - Thêm sản phẩm vào giỏ hàng
   - Cập nhật số lượng sản phẩm
   - Xóa sản phẩm khỏi giỏ hàng
   - Lưu giỏ hàng

5. **Thanh toán đơn hàng**
   - Nhập thông tin giao hàng
   - Chọn phương thức thanh toán
   - Xác nhận đơn hàng
   - Thanh toán đơn hàng
   - Nhận xác nhận đơn hàng

6. **Quản lý tài khoản cá nhân** (chỉ Customer)
   - Xem thông tin cá nhân
   - Cập nhật thông tin cá nhân
   - Xem lịch sử đơn hàng
   - Theo dõi trạng thái đơn hàng
   - Thêm/quản lý địa chỉ
   - Quản lý phương thức thanh toán
   - Đánh giá sản phẩm đã mua

### Chức năng dành cho Quản trị viên và Nhân viên

1. **Quản lý sản phẩm**
   - Thêm/sửa/xóa sản phẩm
   - Quản lý danh mục sản phẩm
   - Quản lý thuộc tính sản phẩm
   - Quản lý hình ảnh sản phẩm
   - Quản lý tồn kho
   - Quản lý giá và thuế

2. **Quản lý đơn hàng**
   - Xem danh sách đơn hàng
   - Xem chi tiết đơn hàng
   - Cập nhật trạng thái đơn hàng
   - Xử lý hoàn tiền/hủy đơn
   - In hóa đơn/phiếu giao hàng

3. **Quản lý khách hàng**
   - Xem danh sách khách hàng
   - Xem chi tiết thông tin khách hàng
   - Chỉnh sửa thông tin khách hàng
   - Quản lý phân nhóm khách hàng

4. **Quản lý khuyến mãi**
   - Tạo/sửa/xóa chương trình khuyến mãi
   - Quản lý mã giảm giá
   - Quản lý ưu đãi theo nhóm khách hàng
   - Quản lý ưu đãi theo sản phẩm/danh mục

5. **Xem báo cáo và thống kê**
   - Báo cáo doanh thu
   - Báo cáo đơn hàng
   - Báo cáo tồn kho
   - Báo cáo khách hàng
   - Phân tích hành vi người dùng

## Mối quan hệ

### Associations (Liên kết)
- Khách hàng không đăng nhập (Guest) có thể thực hiện: Đăng ký/Đăng nhập, Duyệt sản phẩm, Tìm kiếm sản phẩm, Thêm vào giỏ hàng, Thanh toán đơn hàng
- Khách hàng đã đăng nhập (Customer) có thể thực hiện tất cả chức năng của Guest và thêm: Quản lý tài khoản cá nhân
- Quản trị viên (Administrator) có thể thực hiện tất cả chức năng quản lý
- Nhân viên bán hàng (Staff) có thể thực hiện một số chức năng quản lý tùy theo phân quyền

### Include Relationships (Quan hệ bao gồm)
- Thanh toán đơn hàng bao gồm Xác thực thanh toán (với Hệ thống thanh toán)
- Quản lý đơn hàng bao gồm Cập nhật thông tin vận chuyển (với Hệ thống vận chuyển)

### Extend Relationships (Quan hệ mở rộng)
- Đánh giá sản phẩm mở rộng từ Xem chi tiết sản phẩm
- Khôi phục mật khẩu mở rộng từ Đăng nhập

## Bản vẽ Use Case Diagram

```
+---------------------+          +-------------------------+
|                     |          |                         |
|  Guest              |----------| Đăng ký/Đăng nhập       |
|                     |          |                         |
+---------------------+          +-------------------------+
        |
        |                         +-------------------------+
        |-------------------------| Duyệt sản phẩm         |
        |                         |                         |
        |                         +-------------------------+
        |
        |                         +-------------------------+
        |-------------------------| Tìm kiếm sản phẩm      |
        |                         |                         |
        |                         +-------------------------+
        |
        |                         +-------------------------+
        |-------------------------| Thêm vào giỏ hàng      |
        |                         |                         |
        |                         +-------------------------+
        |
        |                         +-------------------------+
        |-------------------------| Thanh toán đơn hàng     |
                                  |                         |
                                  +-------------------------+
                                          ^
                                          | <<include>>
                                          |
+---------------------+          +-------------------------+
|                     |          |                         |
| Payment Provider    |----------| Xác thực thanh toán     |
|                     |          |                         |
+---------------------+          +-------------------------+

+---------------------+          +-------------------------+
|                     |          |                         |
| Customer            |----------| Quản lý tài khoản       |
| (extends Guest)     |          |                         |
+---------------------+          +-------------------------+

+---------------------+          +-------------------------+
|                     |          |                         |
| Administrator       |----------| Quản lý sản phẩm        |
|                     |          |                         |
+---------------------+          +-------------------------+
        |
        |                         +-------------------------+
        |-------------------------| Quản lý đơn hàng       |
        |                         |                         |
        |                         +-------------------------+
        |                                 ^
        |                                 | <<include>>
        |                                 |
        |                         +-------------------------+
        |                         |                         |
        |                         | Cập nhật vận chuyển     |
        |                         |                         |
        |                         +-------------------------+
        |                                 ^
        |                                 |
        |                         +---------------------+
        |                         |                     |
        |                         | Shipping Provider   |
        |                         |                     |
        |                         +---------------------+
        |
        |                         +-------------------------+
        |-------------------------| Quản lý khách hàng     |
        |                         |                         |
        |                         +-------------------------+
        |
        |                         +-------------------------+
        |-------------------------| Quản lý khuyến mãi     |
        |                         |                         |
        |                         +-------------------------+
        |
        |                         +-------------------------+
        |-------------------------| Xem báo cáo thống kê    |
                                  |                         |
                                  +-------------------------+

+---------------------+
|                     |
| Staff               |---------> Có thể truy cập một số chức năng
|                     |          quản lý tùy theo phân quyền
+---------------------+
```

## Kết luận

Use Case Diagram này cung cấp cái nhìn tổng quan về các tác nhân và chức năng trong hệ thống thương mại điện tử Saleor. Diagram này sẽ là cơ sở để phát triển các mô hình và thiết kế chi tiết hơn trong các bước tiếp theo.
