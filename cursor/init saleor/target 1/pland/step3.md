# Kế hoạch thực hiện Activity Diagram (Bản vẽ hoạt động)

## Mục tiêu
Tạo bản vẽ Activity Diagram mô tả chi tiết các quy trình nghiệp vụ và luồng hoạt động trong hệ thống thương mại điện tử Saleor.

## Phạm vi
Tập trung vào ba quy trình chính:
1. Quy trình Mua hàng (từ góc độ khách hàng)
2. Quy trình Quản lý Sản phẩm (từ góc độ admin)
3. Quy trình Thanh toán (từ góc độ hệ thống và các bên liên quan)

## Các bước thực hiện

### 1. Quy trình Mua hàng
- Phân tích các bước trong quy trình mua hàng từ khi khách hàng truy cập trang web đến khi hoàn tất đơn hàng
- Xác định các điều kiện rẽ nhánh (có sẵn hàng, tiếp tục mua hàng, phương thức thanh toán...)
- Mô tả chi tiết luồng hoạt động bao gồm:
  * Truy cập trang web
  * Tìm kiếm/duyệt sản phẩm
  * Xem chi tiết sản phẩm
  * Thêm vào giỏ hàng
  * Quản lý giỏ hàng
  * Thanh toán
  * Hoàn tất đơn hàng
- Xử lý các trường hợp ngoại lệ (hết hàng, lỗi thanh toán)

### 2. Quy trình Quản lý Sản phẩm
- Phân tích các bước trong quy trình quản lý sản phẩm từ góc độ admin
- Xác định các điều kiện rẽ nhánh (tạo mới/cập nhật, sản phẩm có biến thể, kiểm tra hợp lệ...)
- Mô tả chi tiết luồng hoạt động bao gồm:
  * Đăng nhập vào hệ thống quản lý
  * Truy cập mục quản lý sản phẩm
  * Tạo mới/cập nhật sản phẩm
  * Nhập thông tin sản phẩm
  * Tạo biến thể sản phẩm
  * Quản lý giá và tồn kho
  * Xuất bản sản phẩm
- Xử lý các trường hợp ngoại lệ (thông tin không hợp lệ)

### 3. Quy trình Thanh toán
- Phân tích các bước trong quy trình thanh toán từ khi khách hàng xác nhận đến khi hoàn tất giao dịch
- Xác định các điều kiện rẽ nhánh dựa trên phương thức thanh toán (thẻ tín dụng/ví điện tử, chuyển khoản, COD)
- Mô tả chi tiết luồng hoạt động cho từng phương thức thanh toán
- Xử lý các trường hợp thành công/thất bại trong quá trình thanh toán
- Mô tả quy trình xác nhận và cập nhật trạng thái đơn hàng

## Yêu cầu kỹ thuật
- Sử dụng ký hiệu chuẩn của Activity Diagram (UML)
- Mô tả chi tiết các hành động (actions)
- Thể hiện rõ các điều kiện (conditions) và luồng điều khiển (control flows)
- Đảm bảo tính đầy đủ và chính xác của quy trình
- Sử dụng cú pháp PlantUML để tạo bản vẽ

## Kết quả đầu ra
- File `step3_doc.md` chứa mô tả và biểu diễn Activity Diagram cho ba quy trình chính
  * Quy trình Mua hàng
  * Quy trình Quản lý Sản phẩm
  * Quy trình Thanh toán
- Đảm bảo Activity Diagram có đầy đủ:
  * Điểm bắt đầu (start)
  * Các hành động (actions)
  * Các điều kiện rẽ nhánh (decision)
  * Các luồng điều khiển (flows)
  * Điểm kết thúc (end)
- Kèm theo giải thích cho từng quy trình 