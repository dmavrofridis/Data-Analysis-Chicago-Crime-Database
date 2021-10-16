with  locations_by_police as (select count(*) as number_of_altercations,  street from trr_trr
group by  street
order by number_of_altercations desc), dangerous_areas as (
select count(*) as counts, add2 as alleg_locations from data_allegation
group by alleg_locations
order by counts desc)


select * from  dangerous_areas
where alleg_locations is not Null and alleg_locations != '?' and alleg_locations != ''







