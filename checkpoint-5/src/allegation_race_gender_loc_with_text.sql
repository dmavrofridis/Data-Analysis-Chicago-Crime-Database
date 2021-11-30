WITH complainant_info AS (
    SELECT gender, race, allegation_id FROM data_complainant
        WHERE race IS NOT NULL AND race <> ''
)
,

allegations_with_text AS (
    SELECT crid, summary, cr_text, point FROM data_allegation
        WHERE (cr_text IS NOT NULL AND cr_text NOT LIKE '%None Entered%') --OR (summary <> '' AND summary IS NOT NULL)
)
,

community_polygons AS (
    SELECT name AS community, polygon FROM data_area
        WHERE area_type = 'community'
)
,

allegation_text_with_loc_race_gender AS (
    SELECT crid, gender, race, community, cr_text FROM complainant_info
        JOIN (SELECT * FROM allegations_with_text JOIN community_polygons
            ON ST_WITHIN(allegations_with_text.point, community_polygons.polygon)) temp1
        ON temp1.crid = complainant_info.allegation_id
)

SELECT DISTINCT * FROM allegation_text_with_loc_race_gender
    ORDER BY community