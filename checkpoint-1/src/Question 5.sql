
WITH area_inf AS (
select * from "Community Names and Numbers"
),
     crimes as (select * from "Crimes_2001_to_Present" ), joined_table as(
         select * from "Crimes_2001_to_Present"  join  area_inf on area_inf."Community Number" = "Crimes_2001_to_Present"."Community Area"
    ), crimes_by_community as (
select "Community Name" as community,  count(*) crimes from  joined_table
group by "Community Name"),

     area_info AS (
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
    ORDER BY median_income), crimes_and_population as (
select  crimes_by_community.community, crimes, population_total from crimes_by_community
    join without_race_orig on crimes_by_community.community =  without_race_orig.community)

select  sum(population_total) as population,  sum(crimes) as crimes ,  community as community, (sum(crimes) /sum(population_total)) as ratio from crimes_and_population
group by community











