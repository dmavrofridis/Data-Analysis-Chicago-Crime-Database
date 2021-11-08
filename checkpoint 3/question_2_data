
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
    SELECT id, name as community, polygon
    FROM area_info
             JOIN  total_pop ON total_pop.area_id = area_info.id
),
--join the count of trrs on location within a community

final as (
    SELECT count(trr_trr.id) as number_of_incidents, subject_race,
           community
            FROM trr_trr JOIN socio_economic_breakdown ON st_within(trr_trr.point, socio_economic_breakdown.polygon
)
    group by subject_race, community
    order by subject_race, community
)

select * from final


