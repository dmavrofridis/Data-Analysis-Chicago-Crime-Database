WITH trr_descr AS (
    SELECT trr_id, resistance_type, other_description, person,
           subject_race, subject_gender, crid FROM trr_actionresponse
        JOIN trr_trr tt on trr_actionresponse.trr_id = tt.id
        WHERE person = 'Subject Action'

)
,
trr_descr_cr AS (
    SELECT resistance_type, other_description, subject_race, subject_gender, trr_descr.crid,
           summary, is_officer_complaint, point FROM trr_descr
        JOIN data_allegation ON data_allegation.crid = trr_descr.crid
        WHERE summary <> ''
)

,
community_polygons AS (
    SELECT name AS community, polygon FROM data_area
        WHERE area_type = 'community'
)

,
trr_descr_cr_w_loc AS (
    SELECT resistance_type, other_description, subject_race, subject_gender, crid,
           summary, is_officer_complaint, community FROM trr_descr_cr
        JOIN community_polygons ON ST_WITHIN(trr_descr_cr.point, community_polygons.polygon)
)

SELECT * FROM trr_descr_cr_w_loc
