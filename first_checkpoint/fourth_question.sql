
SELECT EXTRACT(YEAR FROM incident_date) AS Year, COUNT(CASE WHEN on_duty THEN 1 END) as duty_count, COUNT(on_duty) as total
       FROM data_officerallegation
    JOIN data_allegationcategory ON  data_officerallegation.allegation_category_id = data_allegationcategory.id
    JOIN data_allegation ON data_officerallegation.allegation_id = data_allegation.crid
GROUP BY Year
ORDER BY Year