--Question 1: Do officers over police areas of lower socioeconomic status?

--Construct a table which contains community areas with median income
-- and polygon information

WITH area_info AS (
    SELECT * FROM data_area
        WHERE data_area.area_type LIKE 'community'
)
,
-- add populations of areas together
total_pop AS (
    SELECT SUM(count) as population_total, area_id
    FROM data_racepopulation
    GROUP BY area_id
)
,
-- JOIN area_info with population totals from data_racepopulation
socio_economic_breakdown AS (
    SELECT id, median_income, name as community, polygon, population_total
    FROM area_info
             JOIN  total_pop ON total_pop.area_id = area_info.id
),
--join the count of trrs on location within a community

without_race_orig as (
SELECT count(trr_trr.id) AS number_of_trrs, median_income, community, population_total, cast(count(trr_trr.id) as float) / population_total as policing
    FROM trr_trr
        JOIN socio_economic_breakdown ON st_within(trr_trr.point, socio_economic_breakdown.polygon)
    GROUP BY community, median_income, population_total
    ORDER BY median_income)

,











 area_info_race AS (
    SELECT * FROM data_area
        WHERE data_area.area_type LIKE 'community'
)
,
-- add populations of areas together
total_pop_race AS (
    SELECT SUM(count) as population_total, area_id, race
    FROM data_racepopulation
    GROUP BY area_id, race
)
,
-- JOIN area_info with population totals from data_racepopulation
socio_economic_breakdown_race AS (
    SELECT id, median_income, name as community, polygon, population_total, race
    FROM area_info_race
             JOIN  total_pop_race ON total_pop_race.area_id = area_info_race.id
)
--join the count of trrs on location within a community
, trr_aggregated_race as
    (
     SELECT count(trr_trr.id) AS number_of_trrs, race ,  median_income, community, population_total, cast(count(trr_trr.id) as float) / (population_total+1) as policing
    FROM trr_trr
        JOIN socio_economic_breakdown_race ON st_within(trr_trr.point, socio_economic_breakdown_race.polygon)
    GROUP BY community, race, median_income, population_total
    ORDER BY median_income) , final_race_table as (





select without_race_orig.number_of_trrs, without_race_orig.median_income,  trr_aggregated_race.population_total, without_race_orig.community, without_race_orig.policing as true_policing, race
from without_race_orig
join  trr_aggregated_race on  trr_aggregated_race.community =  without_race_orig.community)


    SELECT community, true_policing as policing_rate,
        SUM(population_total) FILTER ( WHERE race = 'Black' ) AS BLACK,
        SUM(population_total) FILTER ( WHERE race = 'Hispanic' )AS HISPANIC,
        SUM(population_total) FILTER ( WHERE race = 'Asian' ) AS ASIAN,
        SUM(population_total) FILTER ( WHERE race = 'White' ) AS WHITE,
        SUM(population_total) FILTER ( WHERE race = 'Other' ) AS OTHER
    FROM final_race_table
    GROUP BY  community,true_policing
    ORDER BY  true_policing desc
