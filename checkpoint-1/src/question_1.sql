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
)
--join the count of trrs on location within a community
SELECT count(trr_trr.id) AS number_of_trrs, median_income, community, population_total, cast(count(trr_trr.id) as float) / population_total as policing
    FROM trr_trr
        JOIN socio_economic_breakdown ON st_within(trr_trr.point, socio_economic_breakdown.polygon)
    GROUP BY community, median_income, population_total
    ORDER BY median_income