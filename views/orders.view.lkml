view: orders {
  sql_table_name: demo_db.orders ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: run_date_time {

    type: date_time

    label: "Report Generated On:"

    sql: CURRENT_TIMESTAMP ;;

    html: {% if _user_attributes['locale'] == 'en' %}

                  {{ rendered_value | date: "%d-%^b-%Y %I:%M %p" }}

      {% elsif _user_attributes['locale'] == 'ja' %}

      {{ rendered_value | date: "%Y-%m-%d %H:%M" }}

      {% else %}

      {{ rendered_value | date: "%d-%^b-%Y %I:%M %p" }}

      {% endif %};;

    convert_tz: no

  }



  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.id,
      users.first_name,
      users.last_name,
      billion_orders.count,
      fakeorders.count,
      hundred_million_orders.count,
      hundred_million_orders_wide.count,
      order_items.count,
      order_items_vijaya.count,
      ten_million_orders.count
    ]
  }
}
