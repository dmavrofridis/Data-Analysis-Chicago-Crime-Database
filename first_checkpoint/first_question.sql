--select EXTRACT(YEAR FROM incident_date) as year, count(is_extracted_summary) as count
--from data_allegation
--group by year
--order by year


 --the number of allegations group by officer id , we clearly see that certain police officers recieved a very high number of allegations
with groups_of_cops  as( select count(allegation_id) as number_allegations, officer_id from data_officerallegation
group by officer_id
order by number_allegations desc
    )




select count(officer_id), number_allegations from  groups_of_cops
group by number_allegations
order by  number_allegations


--select count(allegation_id) as number_allegations,  data_officerallegation.officer_id from data_officerallegation
--join data_award on (select count(*))




