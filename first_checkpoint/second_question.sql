/*
 second_question.sql: Displays per year (incident)
    1) number of officer complaints


 */
select EXTRACT(YEAR FROM incident_date) as incident, is_officer_complaint,
       count(*) as count from data_allegation
    where EXTRACT(YEAR FROM incident_date) > 2000
        and EXTRACT(YEAR FROM incident_date) < 2020
group by  incident, is_officer_complaint
order by  incident, is_officer_complaint

