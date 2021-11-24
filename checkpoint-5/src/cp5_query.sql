WITH trr_descr AS (
    SELECT trr_id, resistance_type,other_description, action_sub_category,person,
           subject_race, subject_gender, crid,
           member_action,
           (CASE WHEN person = 'Subject Action' THEN action else NULL END) AS subject_action,
           subject_injured, subject_alleged_injury
    FROM trr_actionresponse
        JOIN trr_trr tt on trr_actionresponse.trr_id = tt.id
--         WHERE person = 'Subject Action'

)
,
trr_descr_cr AS (
    SELECT resistance_type, action_sub_category, member_action, subject_action,
           other_description, subject_race, subject_gender, subject_injured, subject_alleged_injury,
           trr_descr.crid, summary, is_officer_complaint, point FROM trr_descr
        JOIN data_allegation ON data_allegation.crid = trr_descr.crid
        WHERE summary <> '' AND (member_action IS NOT NULL OR subject_action IS NOT NULL)
)

,
community_polygons AS (
    SELECT name AS community, polygon FROM data_area
        WHERE area_type = 'community'
)

,
trr_descr_cr_w_loc AS (
    SELECT resistance_type, action_sub_category, member_action, subject_action,
           other_description, subject_race, subject_gender,
           subject_injured, subject_alleged_injury, crid,
           summary, is_officer_complaint, community FROM trr_descr_cr
        JOIN community_polygons ON ST_WITHIN(trr_descr_cr.point, community_polygons.polygon)
)

SELECT * FROM trr_descr_cr_w_loc