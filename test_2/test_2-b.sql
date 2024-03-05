-- Truy vấn tính doanh thu mỗi tháng
SELECT MONTH(order_date) AS month,
       SUM(total_price) AS total_revenue
FROM orders
WHERE YEAR(order_date) = YEAR(CURRENT_DATE())
GROUP BY MONTH(order_date)
ORDER BY month ASC;

-- Truy vấn lấy thương hiệu bán chạy nhất mỗi tháng
SELECT MONTH(order_date) AS month,
       maker_id,
       SUM(quantity) AS total_quantity
FROM order_details
INNER JOIN products ON order_details.product_id = products.id
WHERE YEAR(order_date) = YEAR(CURRENT_DATE())
GROUP BY MONTH(order_date), maker_id
ORDER BY total_quantity DESC
LIMIT 1;