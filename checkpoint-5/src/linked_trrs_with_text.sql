WITH trr_crids AS (
    SELECT crid, subject_race, officer_id, point FROM trr_trr
        WHERE crid IS NOT NULL
)
,

data_allegation_crids AS (
    SELECT crid, summary, cr_text FROM data_allegation
        WHERE (cr_text IS NOT NULL AND cr_text NOT LIKE '%None Entered%') OR (summary <> '' AND summary IS NOT NULL)
)
,

crids_combined AS (
    SELECT data_allegation_crids.crid, subject_race, officer_id, summary, cr_text FROM trr_crids
        JOIN data_allegation_crids ON trr_crids.crid = data_allegation_crids.crid
)

SELECT * FROM crids_combined