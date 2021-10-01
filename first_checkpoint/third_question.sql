/*
    third_question.sql : displays by quarter (or season)
1) number of allegations
 */
select  EXTRACT(QUARTER FROM incident_date) as quarter,
       count(*) as count from data_allegation
group by quarter
order by quarter
