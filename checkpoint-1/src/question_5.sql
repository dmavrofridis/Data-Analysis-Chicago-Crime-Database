
WITH area_info AS (
    SELECT id,  name as community, polygon FROM data_area
        WHERE data_area.area_type LIKE 'community'
)
,
total_pop AS (
    SELECT SUM(count) AS Population_total, area_id FROM data_racepopulation
    GROUP BY area_id
)
,

ethnicity AS (
    SELECT area_id,
        SUM(COUNT) FILTER ( WHERE race = 'Black' ) AS BLACK,
        SUM(COUNT) FILTER ( WHERE race = 'Hispanic' )AS HISPANIC,
        SUM(COUNT) FILTER ( WHERE race = 'Asian' ) AS ASIAN,
        SUM(COUNT) FILTER ( WHERE race = 'White' ) AS WHITE,
        SUM(COUNT) FILTER ( WHERE race = 'Other' ) AS OTHER
    FROM data_racepopulation
    GROUP BY area_id
    ORDER BY area_id
)
,

ethnicity_percentage AS (
        SELECT total_pop.area_id,
            CAST (BLACK AS float) * 100.0  / total_pop.population_total AS BLACK_PERCENT,
            CAST (WHITE AS float) * 100.0 / total_pop.population_total AS WHITE_PERCENT,
            CAST (HISPANIC AS float) * 100.0 / total_pop.population_total AS HISPANIC_PERCENT,
            CAST (ASIAN AS float) * 100.0 / total_pop.population_total AS ASIAN_PERCENT,
            CAST (OTHER AS float) * 100.0 / total_pop.population_total AS OTHER_PERCENT

        FROM ethnicity
            JOIN total_pop ON ethnicity.area_id = total_pop.area_id
    )

,

area_with_percents AS (
    SELECT BLACK_PERCENT, HISPANIC_PERCENT, WHITE_PERCENT, ASIAN_PERCENT,
           OTHER_PERCENT, area_id, community, polygon
    FROM ethnicity_percentage
    JOIN area_info ON ethnicity_percentage.area_id = area_info.id
)

,
-- create table which contains action response category for each officer in a TRR
action_response_breakdown AS (
    SELECT trr_trr.id, trr_trr.point, cast(action_sub_category as float) FROM trr_actionresponse
        JOIN trr_trr ON trr_actionresponse.trr_id = trr_trr.id
    WHERE action_sub_category IS NOT NULL

)
,almost_ready as (
     SELECT area_id,
       count(CASE WHEN action_sub_category >= 4.0 THEN 1 END),

        community,
       count(CASE WHEN action_sub_category >= 4.0 THEN 1 END) * 100.0 / sum(count(action_sub_category)) over() AS percentage_trrs_violent,
        BLACK_PERCENT,
        WHITE_PERCENT,
        HISPANIC_PERCENT,
        ASIAN_PERCENT,
        OTHER_PERCENT

FROM area_with_percents
    JOIN action_response_breakdown ON st_within(action_response_breakdown.point, area_with_percents.polygon)
    GROUP BY  community, BLACK_PERCENT, WHITE_PERCENT, HISPANIC_PERCENT, ASIAN_PERCENT, OTHER_PERCENT, area_id
    ORDER BY area_id)

select * from almost_ready join crime_ratio_community on crime_ratio_community.community =almost_ready.community
order by ratio desc