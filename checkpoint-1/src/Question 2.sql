--Question 2: Do officers react more violently areas of lower socioeconomic status?

--Construct a table which contains community areas with median income
-- and polygon information

WITH area_info AS (
    SELECT median_income,  name as community, polygon FROM data_area
        WHERE data_area.area_type LIKE 'community'
)
,

-- create table which contains action response category for each officer in a TRR
action_response_breakdown AS (
    SELECT trr_trr.id, trr_trr.point, cast(action_sub_category as float) FROM trr_actionresponse
        JOIN trr_trr ON trr_actionresponse.trr_id = trr_trr.id
    WHERE action_sub_category IS NOT NULL

)
-- join count of high action_sub_categories on falling within community area
SELECT count(CASE WHEN action_sub_category >= 4.0 THEN 1 END),
       median_income, community,
       count(CASE WHEN action_sub_category >= 4.0 THEN 1 END) * 100.0 / sum(count(action_sub_category)) over() AS percentage FROM area_info
    JOIN action_response_breakdown ON st_within(action_response_breakdown.point, area_info.polygon)
    GROUP BY median_income, community

