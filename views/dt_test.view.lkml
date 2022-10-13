view: dt_test {
  derived_table: {
    sql:
    SELECT
    users.city  AS `users_city`,
    COUNT(DISTINCT orders.id ) AS `orders_count`
FROM demo_db.order_items  AS order_items
LEFT JOIN demo_db.orders  AS orders ON order_items.order_id = orders.id
LEFT JOIN demo_db.users  AS users ON orders.user_id = users.id
GROUP BY
    1
ORDER BY
    COUNT(DISTINCT orders.id ) DESC
LIMIT 10;;
  }

  dimension: users_city {
    type: string
    sql: ${TABLE}.users_city ;;
  }
  dimension: orders_count {
    type: number
    sql: ${TABLE}.orders_count ;;
  }
}
