/*
 sixth_question.sql : SHOULD display by year...
    1) officer_complaints: the number of complaints that were registered by other officers
    2) officer_complaint_disc: the number of officer register complaints that were disciplined
    3) the total complaints

 */
SELECT EXTRACT(YEARS FROM incident_date) AS year,
       COUNT(CASE WHEN is_officer_complaint THEN 1 END) AS officer_complaints,
       COUNT(CASE WHEN is_officer_complaint AND is_officer_complaint = disciplined THEN 1 END) AS officer_complaint_disc,
       COUNT(is_officer_complaint) AS total
FROM data_officerallegation
    JOIN data_allegation ON data_officerallegation.allegation_id = data_allegation.crid
GROUP BY year
ORDER BY year