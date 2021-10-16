select count(*) as number_of_altercations,  street from trr_trr
group by  street
order by number_of_altercations desc
