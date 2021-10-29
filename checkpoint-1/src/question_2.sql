WITH area_inf AS (
     SELECT median_income, id,  name as community, polygon FROM data_area
         WHERE data_area.area_type LIKE 'community'
 ),
      total_pop AS (
     SELECT SUM(count) as population_total, area_id
     FROM data_racepopulation
     GROUP BY area_id
 ),
      area_info AS (
     SELECT id, median_income,  community, polygon, population_total
     FROM area_inf
              JOIN  total_pop ON total_pop.area_id = area_inf.id
 ),

 -- create table which contains action response category for each officer in a TRR
 action_response_breakdown AS (
     SELECT trr_trr.id,  trr_trr.point, cast(action_sub_category as float) FROM trr_actionresponse
         JOIN trr_trr ON trr_actionresponse.trr_id = trr_trr.id
     WHERE action_sub_category IS NOT NULL

 )
 -- join count of high action_sub_categories on falling within community area
 , joined as (SELECT population_total, count(CASE WHEN action_sub_category >= 4.0 THEN 1 END),
        median_income, community,
        count(CASE WHEN action_sub_category >= 4.0 THEN 1 END) * 100.0 / count(CASE WHEN TRUE THEN 1 END) AS percentage_trrs_violent FROM area_info
     JOIN action_response_breakdown ON st_within(action_response_breakdown.point, area_info.polygon)
     GROUP BY median_income, community,  population_total)


 select * from joined