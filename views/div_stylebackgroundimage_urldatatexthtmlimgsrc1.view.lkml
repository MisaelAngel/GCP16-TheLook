view: div_stylebackgroundimage_urldatatexthtmlimgsrc1 {
  sql_table_name: demo_db.div_stylebackgroundimage_urldatatexthtmlimgsrc1 ;;

  dimension: id {
    type: number
    primary_key: yes
    sql: ${TABLE}.id ;;
  }
  dimension: div_stylebackground {
    type: string
    sql: ${TABLE}.div_stylebackground ;;
  }

  measure: count {
    type: count
    drill_fields: [id, div_stylebackground, count]
  }
}
