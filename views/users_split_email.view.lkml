view: users_split_email {
  derived_table: {
    sql: SELECT
        users.id as user_id,
        SUBSTRING_INDEX(SUBSTRING_INDEX(users.email, '@', numbers.n), '@', -1) as split_email
      FROM
        (SELECT 1 n UNION ALL SELECT 2
         UNION ALL SELECT 3 UNION ALL SELECT 4) numbers INNER JOIN users
        ON CHAR_LENGTH(users.email)
           -CHAR_LENGTH(REPLACE(users.email, '@', ''))>=numbers.n-1
      ORDER BY
        id, n ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }
  dimension: split_email {
    type: string
    sql: ${TABLE}.split_email ;;
  }
}
