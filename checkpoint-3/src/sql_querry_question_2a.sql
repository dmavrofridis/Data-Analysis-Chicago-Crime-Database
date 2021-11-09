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
    SELECT socio_economic_breakdown.polygon,
           subject_race,
           community,
           trr_trr.id
    FROM trr_trr
             JOIN socio_economic_breakdown ON st_within(trr_trr.point, socio_economic_breakdown.polygon
        ))

,
     final_with_polyg as (
         select ST_AsGeoJSON(polygon, 4326) as geometry, subject_race, community, count(id) as trr_count
         from final
         group by polygon, subject_race, community
         order by trr_count desc
     )

select * from final_with_polyg