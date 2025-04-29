# Sequence Diagram (Bản vẽ tuần tự) cho Saleor E-commerce

## Giới thiệu

Sequence Diagram mô tả tương tác giữa các đối tượng trong hệ thống theo thứ tự thời gian. Biểu đồ này giúp hiểu rõ luồng thực thi các thao tác và sự tương tác giữa các thành phần khác nhau trong hệ thống.

## Các thành phần chính trong Saleor

- **Customer (Khách hàng)**: Người dùng cuối sử dụng Storefront
- **Storefront**: Giao diện người dùng dành cho khách hàng
- **Dashboard**: Giao diện quản trị dành cho Admin
- **Admin**: Người quản trị hệ thống
- **Saleor API**: GraphQL API cung cấp các chức năng từ Backend
- **Database**: Cơ sở dữ liệu lưu trữ thông tin

## Sequence Diagram cho quy trình mua hàng

```
Customer       Storefront        Saleor API        Database
   |               |                 |                |
   |---Browse----->|                 |                |
   |               |---Query Products-->              |
   |               |                 |---Fetch Data-->|
   |               |                 |<--Return Data--|
   |               |<--Return Products-               |
   |<--Display-----|                 |                |
   |               |                 |                |
   |---Add to Cart->|                 |                |
   |               |---Create Cart--->|                |
   |               |                 |---Save Cart--->|
   |               |                 |<--Confirm Save-|
   |               |<--Cart Created---|                |
   |<--Confirm-----|                 |                |
   |               |                 |                |
   |---Checkout--->|                 |                |
   |               |---Init Checkout->|                |
   |               |                 |---Create----->|
   |               |                 |<--Confirm-----|
   |               |<--Return ID-----|                |
   |<--Show Form---|                 |                |
   |               |                 |                |
   |---Submit Info->|                 |                |
   |               |---Update Checkout>|               |
   |               |                 |---Update----->|
   |               |                 |<--Confirm-----|
   |               |<--Confirmed-----|                |
   |               |                 |                |
   |---Pay-------->|                 |                |
   |               |---Process Payment>|               |
   |               |                 |---Payment---->|
   |               |                 |<--Confirm-----|
   |               |<--Payment OK----|                |
   |               |---Complete Order>|                |
   |               |                 |---Create Order>|
   |               |                 |<--Order Created|
   |               |<--Order Confirmed-|                |
   |<--Thank You---|                 |                |
```

## Sequence Diagram cho quản lý sản phẩm

```
Admin         Dashboard         Saleor API         Database
  |               |                 |                 |
  |---Login------>|                 |                 |
  |               |---Authenticate->|                 |
  |               |                 |---Verify------>|
  |               |                 |<--Confirmed----|
  |               |<--Auth Token----|                 |
  |<--Dashboard---|                 |                 |
  |               |                 |                 |
  |---Create Product>|              |                 |
  |               |---Mutation----->|                 |
  |               |                 |---Save Product->|
  |               |                 |<--Confirmed----|
  |               |<--Success-------|                 |
  |<--Confirmed---|                 |                 |
  |               |                 |                 |
  |---Update Product>|              |                 |
  |               |---Mutation----->|                 |
  |               |                 |---Update------>|
  |               |                 |<--Confirmed----|
  |               |<--Success-------|                 |
  |<--Confirmed---|                 |                 |
  |               |                 |                 |
  |---View Orders->|                |                 |
  |               |---Query Orders->|                 |
  |               |                 |---Fetch Data-->|
  |               |                 |<--Return Data--|
  |               |<--Return Orders-|                 |
  |<--Display-----|                 |                 |
```

## Sequence Diagram cho quản lý người dùng

```
Admin         Dashboard         Saleor API         Database
  |               |                 |                 |
  |---Manage Users>|                |                 |
  |               |---Query Users-->|                 |
  |               |                 |---Fetch Users->|
  |               |                 |<--Return Users-|
  |               |<--User List-----|                 |
  |<--Display-----|                 |                 |
  |               |                 |                 |
  |---Create Staff>|                |                 |
  |               |---Create Staff->|                 |
  |               |                 |---Save Staff-->|
  |               |                 |<--Confirmed----|
  |               |<--Success-------|                 |
  |<--Confirmed---|                 |                 |
  |               |                 |                 |
  |---Set Permissions>|             |                 |
  |               |---Update Perms->|                 |
  |               |                 |---Save Perms-->|
  |               |                 |<--Confirmed----|
  |               |<--Success-------|                 |
  |<--Confirmed---|                 |                 |
```

## Sequence Diagram cho xử lý thanh toán

```
Customer      Storefront        Payment API       Saleor API        Database
   |              |                  |                |                |
   |--Checkout--->|                  |                |                |
   |              |--Create Payment->|                |                |
   |              |                  |--Process------>|                |
   |              |                  |                |--Save Payment->|
   |              |                  |                |<--Confirmed---|
   |              |                  |<--Payment ID---|                |
   |              |<--Payment Form---|                |                |
   |              |                  |                |                |
   |--Enter Info->|                  |                |                |
   |              |--Submit Payment->|                |                |
   |              |                  |--Authorize---->|                |
   |              |                  |                |--Update------>|
   |              |                  |                |<--Confirmed---|
   |              |                  |<--Authorized---|                |
   |              |<--Redirect-------|                |                |
   |              |                  |                |                |
   |              |--Complete Order->|                |                |
   |              |                  |--Confirm------>|                |
   |              |                  |                |--Create Order->|
   |              |                  |                |<--Order Created|
   |              |                  |<--Confirmation-|                |
   |              |<--Order Complete-|                |                |
   |<--Thank You--|                  |                |                |
```

## Tính năng chính được mô tả trong Sequence Diagram

1. **Duyệt và mua sản phẩm**:
   - Xem danh sách sản phẩm
   - Thêm vào giỏ hàng
   - Xử lý thanh toán
   - Hoàn tất đơn hàng

2. **Quản lý sản phẩm**:
   - Thêm sản phẩm mới
   - Cập nhật thông tin sản phẩm
   - Quản lý tồn kho
   
3. **Quản lý người dùng**:
   - Xem danh sách người dùng
   - Thêm nhân viên mới
   - Cấp quyền quản trị

4. **Xử lý thanh toán**:
   - Tạo yêu cầu thanh toán
   - Xử lý thông tin thẻ/ví điện tử
   - Xác nhận thanh toán
   - Hoàn tất đơn hàng

## Kết luận

Các Sequence Diagram trên mô tả chi tiết các luồng tương tác chính trong hệ thống Saleor E-commerce. Các biểu đồ này giúp hiểu rõ cách các thành phần tương tác với nhau và thứ tự các hoạt động diễn ra trong hệ thống. 