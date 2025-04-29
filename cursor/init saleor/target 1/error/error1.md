Not allowed to load local resource khi vào drashboard
cách sửa: saleor-dashboard/vite.config.js entry: path.resolve(__dirname, "src", "index.tsx") ---> entry: "/index.tsx".
Đã fix