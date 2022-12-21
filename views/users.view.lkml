view: users {
  sql_table_name: demo_db.users ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }
#test
  dimension: age_tier {
    type: tier
    tiers: [0,10,20,30,40,50,60,70,80]
    style: integer
    sql: ${age} ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
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

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: CONCAT(${TABLE}.state," &", " Extra") ;;
    map_layer_name: us_states
    link: {
      label: "Google"
      url: "https://gcpl2216.cloud.looker.com/dashboards/92?State={{ value | url_encode}}&Created+Year="
    }
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: percentil_test {
    type: percentile
    percentile: 5
    sql: ${age} ;;
  }

  measure: average_age {
    type: average
    sql: ${age} ;;
  }

  measure: age_functions{
    type: number
    sql: CASE WHEN {%parameter type_of_function%} = 'AVG'
          THEN AVG(${age})
        ELSE
          round(100*${count},0)
        END;;
    html: {% if type_of_function._parameter_value == "'AVG'" %}
             {{ users.count._value | floor}}h {{ users.count._value | times: 67 | modulo: 60}}m
           {% else %}
             {{ rendered_value | append: "%" }}
           {% endif %}
     ;;
  }

  parameter: type_of_function {
    type: string
    label: "Function"
    allowed_value: {
      label: "Average Age"
      value: "AVG"
    }
    allowed_value: {
      label: "Highest Age"
      value: "MAX"
    }
    allowed_value: {
      label: "Lowest Age"
      value: "MIN"
    }
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      first_name,
      last_name,
      events.count,
      orders.count,
      saralooker.count,
      sindhu.count,
      user_data.count
    ]
  }
}
