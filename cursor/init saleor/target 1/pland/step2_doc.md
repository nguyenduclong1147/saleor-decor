# Class Diagram cho Hệ thống Thương mại điện tử Saleor

## Tổng quan

Class Diagram mô tả cấu trúc tĩnh của hệ thống Saleor, thể hiện các lớp, thuộc tính, phương thức và mối quan hệ giữa các lớp. Diagram này cung cấp cái nhìn tổng quan về các thành phần phần mềm và cách chúng tương tác với nhau.

## Các nhóm lớp chính

### 1. Nhóm Sản phẩm (Product)

#### 1.1. Product (Sản phẩm)
- **Thuộc tính:**
  - id: String
  - name: String
  - slug: String
  - description: Text
  - productType: ProductType
  - category: Category
  - attributes: List\<Attribute\>
  - variants: List\<ProductVariant\>
  - isPublished: Boolean
  - visibleInListings: Boolean
  - media: List\<ProductMedia\>
  - createdAt: DateTime
  - updatedAt: DateTime
  - metadata: JSON
- **Phương thức:**
  - getMainImage(): ProductMedia
  - getVariantByAttributes(attributesList): ProductVariant
  - getBasePrice(): Money
  - getLowestPrice(): Money
  - isAvailableForPurchase(): Boolean

#### 1.2. ProductVariant (Biến thể sản phẩm)
- **Thuộc tính:**
  - id: String
  - name: String
  - sku: String
  - product: Product
  - attributes: List\<AssignedVariantAttribute\>
  - media: List\<ProductMedia\>
  - price: Money
  - costPrice: Money
  - weight: Weight
  - quantity: Integer
  - quantityAllocated: Integer
  - trackInventory: Boolean
  - metadata: JSON
- **Phương thức:**
  - isAvailable(): Boolean
  - getStockQuantity(): Integer
  - getPrice(): Money
  - getDisplayName(): String

#### 1.3. Category (Danh mục)
- **Thuộc tính:**
  - id: String
  - name: String
  - slug: String
  - description: Text
  - parent: Category
  - children: List\<Category\>
  - products: List\<Product\>
  - level: Integer
  - metadata: JSON
- **Phương thức:**
  - getAncestors(): List\<Category\>
  - getDescendants(): List\<Category\>
  - getAbsoluteUrl(): String

#### 1.4. ProductType (Loại sản phẩm)
- **Thuộc tính:**
  - id: String
  - name: String
  - slug: String
  - hasVariants: Boolean
  - productAttributes: List\<Attribute\>
  - variantAttributes: List\<Attribute\>
  - weight: Weight
  - taxRate: String
  - metadata: JSON
- **Phương thức:**
  - getAvailableAttributes(): List\<Attribute\>

#### 1.5. Attribute (Thuộc tính)
- **Thuộc tính:**
  - id: String
  - name: String
  - slug: String
  - inputType: String
  - valueRequired: Boolean
  - isVariantOnly: Boolean
  - visibleInStorefront: Boolean
  - values: List\<AttributeValue\>
  - metadata: JSON
- **Phương thức:**
  - getValues(): List\<AttributeValue\>

#### 1.6. AttributeValue (Giá trị thuộc tính)
- **Thuộc tính:**
  - id: String
  - name: String
  - slug: String
  - value: String
  - attribute: Attribute
  - metadata: JSON
- **Phương thức:**
  - getDisplayValue(): String

### 2. Nhóm Đơn hàng (Order)

#### 2.1. Order (Đơn hàng)
- **Thuộc tính:**
  - id: String
  - number: String
  - user: User
  - createdAt: DateTime
  - status: OrderStatus (Enum)
  - shippingAddress: Address
  - billingAddress: Address
  - shippingMethod: ShippingMethod
  - lines: List\<OrderLine\>
  - payments: List\<Payment\>
  - total: Money
  - subtotal: Money
  - shippingPrice: Money
  - metadata: JSON
- **Phương thức:**
  - getTotal(): Money
  - getSubtotal(): Money
  - getShippingPrice(): Money
  - getTaxAmount(): Money
  - isFullyPaid(): Boolean
  - canBeFulfilled(): Boolean

#### 2.2. OrderLine (Chi tiết đơn hàng)
- **Thuộc tính:**
  - id: String
  - order: Order
  - productVariant: ProductVariant
  - productName: String
  - variantName: String
  - quantity: Integer
  - unitPrice: Money
  - totalPrice: Money
  - taxRate: Decimal
  - metadata: JSON
- **Phương thức:**
  - getTotalPrice(): Money

#### 2.3. Checkout (Thanh toán)
- **Thuộc tính:**
  - id: String
  - token: String
  - user: User
  - email: String
  - lines: List\<CheckoutLine\>
  - shippingAddress: Address
  - billingAddress: Address
  - shippingMethod: ShippingMethod
  - paymentMethod: PaymentMethod
  - discount: Money
  - voucherCode: String
  - total: Money
  - metadata: JSON
- **Phương thức:**
  - getTotal(): Money
  - getSubtotal(): Money
  - getShippingPrice(): Money
  - getTaxAmount(): Money
  - isShippingRequired(): Boolean
  - validateFields(): List\<ValidationError\>
  - complete(): Order

#### 2.4. CheckoutLine (Chi tiết thanh toán)
- **Thuộc tính:**
  - id: String
  - checkout: Checkout
  - variant: ProductVariant
  - quantity: Integer
  - totalPrice: Money
  - metadata: JSON
- **Phương thức:**
  - getTotalPrice(): Money

### 3. Nhóm Người dùng (User)

#### 3.1. User (Người dùng)
- **Thuộc tính:**
  - id: String
  - email: String
  - firstName: String
  - lastName: String
  - isStaff: Boolean
  - isActive: Boolean
  - dateJoined: DateTime
  - lastLogin: DateTime
  - defaultBillingAddress: Address
  - defaultShippingAddress: Address
  - addresses: List\<Address\>
  - metadata: JSON
- **Phương thức:**
  - getFullName(): String
  - isAuthenticated(): Boolean
  - hasPermission(permission): Boolean

#### 3.2. Customer (Khách hàng)
- **Thuộc tính:**
  - user: User
  - orders: List\<Order\>
  - note: String
  - metadata: JSON
- **Phương thức:**
  - getOrderCount(): Integer
  - getTotalSpent(): Money

#### 3.3. Staff (Nhân viên)
- **Thuộc tính:**
  - user: User
  - permissions: List\<Permission\>
  - metadata: JSON
- **Phương thức:**
  - hasPermission(permission): Boolean

#### 3.4. Address (Địa chỉ)
- **Thuộc tính:**
  - id: String
  - firstName: String
  - lastName: String
  - companyName: String
  - streetAddress1: String
  - streetAddress2: String
  - city: String
  - cityArea: String
  - postalCode: String
  - country: Country
  - countryArea: String
  - phone: String
  - isDefaultShippingAddress: Boolean
  - isDefaultBillingAddress: Boolean
  - metadata: JSON
- **Phương thức:**
  - getFormattedAddress(): String

### 4. Nhóm Thanh toán (Payment)

#### 4.1. Payment (Thanh toán)
- **Thuộc tính:**
  - id: String
  - order: Order
  - method: PaymentMethod
  - amount: Money
  - chargeStatus: PaymentChargeStatus (Enum)
  - transactionId: String
  - createdAt: DateTime
  - capturedAmount: Money
  - metadata: JSON
- **Phương thức:**
  - canCapture(): Boolean
  - canRefund(): Boolean
  - canVoid(): Boolean
  - capture(): PaymentTransaction
  - refund(): PaymentTransaction
  - void(): PaymentTransaction

#### 4.2. PaymentMethod (Phương thức thanh toán)
- **Thuộc tính:**
  - id: String
  - name: String
  - code: String
  - isActive: Boolean
  - metadata: JSON
- **Phương thức:**
  - processPayment(payment): PaymentTransaction

#### 4.3. Transaction (Giao dịch)
- **Thuộc tính:**
  - id: String
  - payment: Payment
  - amount: Money
  - kind: TransactionKind (Enum)
  - status: TransactionStatus (Enum)
  - error: String
  - gatewayResponse: JSON
  - createdAt: DateTime
  - metadata: JSON
- **Phương thức:**
  - isSuccess(): Boolean

### 5. Nhóm Vận chuyển (Shipping)

#### 5.1. ShippingMethod (Phương thức vận chuyển)
- **Thuộc tính:**
  - id: String
  - name: String
  - description: String
  - price: Money
  - minimumOrderPrice: Money
  - maximumOrderPrice: Money
  - minimumOrderWeight: Weight
  - maximumOrderWeight: Weight
  - shippingZone: ShippingZone
  - metadata: JSON
- **Phương thức:**
  - isAvailableForOrder(order): Boolean
  - getPrice(order): Money

#### 5.2. ShippingZone (Vùng vận chuyển)
- **Thuộc tính:**
  - id: String
  - name: String
  - countries: List\<Country\>
  - shippingMethods: List\<ShippingMethod\>
  - warehouses: List\<Warehouse\>
  - metadata: JSON
- **Phương thức:**
  - isCountrySupported(country): Boolean

#### 5.3. Warehouse (Kho hàng)
- **Thuộc tính:**
  - id: String
  - name: String
  - address: Address
  - shippingZones: List\<ShippingZone\>
  - stock: List\<Stock\>
  - metadata: JSON
- **Phương thức:**
  - getStockQuantity(productVariant): Integer

#### 5.4. Stock (Tồn kho)
- **Thuộc tính:**
  - id: String
  - warehouse: Warehouse
  - productVariant: ProductVariant
  - quantity: Integer
  - metadata: JSON
- **Phương thức:**
  - isAvailable(): Boolean
  - allocate(quantity): Boolean
  - deallocate(quantity): Boolean

### 6. Nhóm Khuyến mãi (Promotion)

#### 6.1. Promotion (Chương trình khuyến mãi)
- **Thuộc tính:**
  - id: String
  - name: String
  - description: String
  - startDate: DateTime
  - endDate: DateTime
  - rules: List\<PromotionRule\>
  - type: PromotionType (Enum)
  - isActive: Boolean
  - metadata: JSON
- **Phương thức:**
  - isValid(): Boolean
  - getDiscount(order): Money

#### 6.2. Voucher (Phiếu giảm giá)
- **Thuộc tính:**
  - id: String
  - name: String
  - code: String
  - usageLimit: Integer
  - used: Integer
  - startDate: DateTime
  - endDate: DateTime
  - discountValueType: DiscountValueType (Enum)
  - discountValue: Decimal
  - minSpent: Money
  - products: List\<Product\>
  - categories: List\<Category\>
  - metadata: JSON
- **Phương thức:**
  - isValid(): Boolean
  - getDiscount(checkout): Money

#### 6.3. Discount (Giảm giá)
- **Thuộc tính:**
  - id: String
  - name: String
  - valueType: DiscountValueType (Enum)
  - value: Decimal
  - products: List\<Product\>
  - categories: List\<Category\>
  - startDate: DateTime
  - endDate: DateTime
  - metadata: JSON
- **Phương thức:**
  - isValid(): Boolean
  - getDiscountedPrice(price): Money

## Mối quan hệ giữa các lớp

### Kế thừa (Inheritance)
- Customer kế thừa từ User
- Staff kế thừa từ User

### Kết hợp (Association)
- Product có nhiều ProductVariant (one-to-many)
- Product thuộc về một Category (many-to-one)
- Product thuộc về một ProductType (many-to-one)
- Order chứa nhiều OrderLine (one-to-many)
- Order có một User (many-to-one)
- Checkout có nhiều CheckoutLine (one-to-many)
- User có nhiều Address (one-to-many)

### Tổng hợp (Composition)
- Product chứa các ProductVariant (một Product không thể tồn tại mà không có ProductVariant)
- Order chứa các OrderLine (một Order không thể tồn tại mà không có OrderLine)

### Tập hợp (Aggregation)
- Category có thể chứa nhiều Category con (parent-child relationship)
- ShippingZone chứa nhiều ShippingMethod
- ProductType chứa nhiều Attribute

### Phụ thuộc (Dependency)
- Payment phụ thuộc vào Order
- Stock phụ thuộc vào ProductVariant và Warehouse

## Sơ đồ Class Diagram

```
+------------------------+      +------------------------+
|        Product         |      |      ProductType       |
|------------------------|      |------------------------|
| id: String             |      | id: String             |
| name: String           |      | name: String           |
| slug: String           |      | hasVariants: Boolean   |
| description: Text      |<>----| productAttributes: []  |
| isPublished: Boolean   |      | variantAttributes: []  |
| media: []              |      +------------------------+
| createdAt: DateTime    |
| updatedAt: DateTime    |      +------------------------+
|------------------------|      |        Category        |
| getMainImage()         |      |------------------------|
| getBasePrice()         |      | id: String             |
| isAvailableForPurchase()|<>---| name: String           |
+------------------------+      | slug: String           |
         |                      | parent: Category       |
         | 1..*                 | children: []           |
         v                      | level: Integer         |
+------------------------+      +------------------------+
|     ProductVariant     |
|------------------------|      +------------------------+
| id: String             |      |       Attribute        |
| name: String           |      |------------------------|
| sku: String            |      | id: String             |
| price: Money           |<>----| name: String           |
| costPrice: Money       |      | slug: String           |
| weight: Weight         |      | inputType: String      |
| quantity: Integer      |      | values: []             |
|------------------------|      +------------------------+
| isAvailable()          |              |
| getStockQuantity()     |              | 1..*
| getPrice()             |              v
+------------------------+      +------------------------+
         |                      |     AttributeValue     |
         | 1                    |------------------------|
         v                      | id: String             |
+------------------------+      | name: String           |
|        Stock          |       | slug: String           |
|------------------------|      | value: String          |
| id: String             |      +------------------------+
| quantity: Integer      |
|------------------------|      +------------------------+
| isAvailable()          |      |         Order          |
| allocate(quantity)     |      |------------------------|
+------------------------+      | id: String             |
                                | number: String         |
+------------------------+      | status: OrderStatus    |
|        User            |<-----| createdAt: DateTime    |
|------------------------|      | total: Money           |
| id: String             |      | subtotal: Money        |
| email: String          |      |------------------------|
| firstName: String      |      | shippingPrice: Money   |
| lastName: String       |      |------------------------|
| isStaff: Boolean       |      | getTotal()             |
| isActive: Boolean      |      | isFullyPaid()          |
|------------------------|      | canBeFulfilled()       |
+------------------------+      +------------------------+
```

## Kết luận

Class Diagram này mô tả cấu trúc của hệ thống thương mại điện tử Saleor, bao gồm các lớp chính và mối quan hệ giữa chúng. Mô hình này phục vụ làm cơ sở cho việc phát triển và triển khai hệ thống, đồng thời giúp hiểu rõ hơn về các thành phần và chức năng của Saleor. 