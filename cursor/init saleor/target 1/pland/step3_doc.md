# Activity Diagram cho Saleor E-commerce

## 1. Quy trình Mua hàng

```
@startuml Quy trình Mua hàng
start
:Khách hàng truy cập trang web;

:Tìm kiếm/Duyệt sản phẩm;

:Xem chi tiết sản phẩm;

if (Có sẵn hàng?) then (có)
  :Chọn biến thể sản phẩm (màu sắc, kích thước...);
  :Thêm vào giỏ hàng;
  
  :Xem giỏ hàng;
  
  if (Tiếp tục mua?) then (có)
    goto Tìm kiếm/Duyệt sản phẩm;
  else (không)
    :Tiến hành thanh toán;
    
    :Nhập thông tin giao hàng;
    
    :Chọn phương thức vận chuyển;
    
    :Chọn phương thức thanh toán;
    
    :Xác nhận đơn hàng;
    
    if (Phương thức thanh toán?) then (trực tuyến)
      :Chuyển hướng đến cổng thanh toán;
      
      if (Thanh toán thành công?) then (có)
        :Hiển thị xác nhận đơn hàng;
      else (không)
        :Hiển thị thông báo lỗi;
        goto Chọn phương thức thanh toán;
      endif
    else (COD/Chuyển khoản)
      :Hiển thị thông tin thanh toán/hướng dẫn;
      :Hiển thị xác nhận đơn hàng;
    endif
  endif
else (không)
  :Hiển thị thông báo hết hàng;
  :Đề xuất sản phẩm thay thế;
  goto Tìm kiếm/Duyệt sản phẩm;
endif

:Nhận email xác nhận đơn hàng;

stop
@enduml
```

## 2. Quy trình Quản lý Sản phẩm

```
@startuml Quy trình Quản lý Sản phẩm
start

:Admin đăng nhập vào hệ thống quản lý;

:Truy cập mục Quản lý Sản phẩm;

if (Tạo sản phẩm mới?) then (có)
  :Nhập thông tin cơ bản sản phẩm 
  (tên, mô tả, danh mục...);
  
  :Tạo biến thể sản phẩm 
  (nếu có: màu sắc, kích thước...);
  
  :Nhập thông tin giá và khuyến mãi;
  
  :Tải lên hình ảnh sản phẩm;
  
  :Nhập thông tin SEO;
  
  :Nhập thông tin kho hàng;

else (không)
  :Tìm kiếm sản phẩm hiện có;
  
  :Chọn sản phẩm để chỉnh sửa;
  
  :Cập nhật thông tin sản phẩm;
endif

if (Sản phẩm hợp lệ?) then (có)
  if (Xuất bản ngay?) then (có)
    :Đánh dấu sản phẩm là "đang hoạt động";
  else (không)
    :Lưu sản phẩm ở trạng thái "nháp";
  endif
else (không)
  :Hiển thị thông báo lỗi;
  :Sửa các lỗi;
  goto Sản phẩm hợp lệ?;
endif

:Cập nhật dữ liệu catalog;

stop
@enduml
```

## 3. Quy trình Thanh toán

```
@startuml Quy trình Thanh toán
start

:Khách hàng hoàn tất thông tin giao hàng;

:Chọn phương thức thanh toán;

if (Phương thức?) then (Thẻ tín dụng/Ví điện tử)
  :Chuyển hướng đến cổng thanh toán;
  
  :Khách hàng nhập thông tin thanh toán;
  
  if (Xác thực thành công?) then (có)
    :Cổng thanh toán xử lý giao dịch;
    
    if (Giao dịch thành công?) then (có)
      :Ghi nhận thanh toán thành công;
    else (không)
      :Ghi nhận thanh toán thất bại;
      :Thông báo lỗi cho khách hàng;
      stop
    endif
  else (không)
    :Thông báo lỗi xác thực;
    :Yêu cầu nhập lại thông tin;
    goto Khách hàng nhập thông tin thanh toán;
  endif
  
else if (Phương thức?) then (Chuyển khoản ngân hàng)
  :Hiển thị thông tin tài khoản ngân hàng;
  
  :Khách hàng thực hiện chuyển khoản;
  
  :Admin kiểm tra và xác nhận thanh toán;
  
  if (Xác nhận thanh toán?) then (có)
    :Ghi nhận thanh toán thành công;
  else (không)
    :Ghi nhận thanh toán chưa hoàn tất;
    :Gửi nhắc nhở cho khách hàng;
    stop
  endif
  
else (COD)
  :Ghi nhận phương thức thanh toán khi nhận hàng;
  :Đánh dấu thanh toán "chờ xử lý";
endif

:Tạo đơn hàng với trạng thái "Đã thanh toán" hoặc "Chờ thanh toán";

:Gửi email xác nhận thanh toán cho khách hàng;

:Chuyển đơn hàng sang bộ phận xử lý;

stop
@enduml
```

## Giải thích

### 1. Quy trình Mua hàng
Activity Diagram trên mô tả luồng hoạt động khi khách hàng thực hiện quá trình mua hàng trên Saleor, từ khi truy cập website đến khi hoàn tất đơn hàng. Diagram thể hiện các điều kiện rẽ nhánh như kiểm tra tồn kho, lựa chọn tiếp tục mua hàng, và xử lý các phương thức thanh toán khác nhau.

### 2. Quy trình Quản lý Sản phẩm
Activity Diagram này mô tả quy trình quản lý sản phẩm từ phía Admin, bao gồm việc tạo mới hoặc cập nhật sản phẩm, thiết lập các thông tin và thuộc tính sản phẩm, xử lý biến thể và quản lý tồn kho. Diagram thể hiện các điểm quyết định như kiểm tra tính hợp lệ của sản phẩm và lựa chọn xuất bản ngay hay lưu ở trạng thái nháp.

### 3. Quy trình Thanh toán
Activity Diagram này mô tả chi tiết luồng xử lý thanh toán trong hệ thống Saleor, bao gồm các phương thức thanh toán khác nhau như thẻ tín dụng/ví điện tử, chuyển khoản ngân hàng và COD. Diagram thể hiện các điểm quyết định và xử lý các trường hợp thành công/thất bại khác nhau trong quá trình thanh toán. 