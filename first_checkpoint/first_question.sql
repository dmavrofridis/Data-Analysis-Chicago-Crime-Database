--select EXTRACT(YEAR FROM incident_date) as year, count(is_extracted_summary) as count
--from data_allegation
--group by year
--order by year


-- the number of allegations group by officer id , we clearly see that certain police officers recieved a very high number of allegations
select count(allegation_id) as number_allegations, officer_id from data_officerallegation
group by officer_id
order by number_allegations desc

