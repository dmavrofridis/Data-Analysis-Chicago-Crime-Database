select EXTRACT(YEAR FROM incident_date) as year, count(is_extracted_summary) as count from data_allegation
group by year
order by year
