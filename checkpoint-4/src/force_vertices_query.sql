with officer_allegation_filter as (
    select id,category from data_allegationcategory)
    --where category = 'Use Of Force' )

, joined_officer_allegation_filter as (
select t2.id, officer_id, category, allegation_id from officer_allegation_filter t1
    join  data_officerallegation t2 on t1.id = t2.allegation_category_id)
, count_alleg

    as (
select  allegation_id,   count(officer_id) as count from joined_officer_allegation_filter
where category = 'Use Of Force'

    group by allegation_id
    having count(officer_id) > 1
    order by count)
,
     linked_allegations as (select
          t1.allegation_id, count, officer_id from count_alleg t1
         left join  joined_officer_allegation_filter t2 on   t1.allegation_id = t2.allegation_id
         ),

linked_allegation_race as  (

    select * from   linked_allegations join (select race, id from data_officer) as t1
    on linked_allegations.officer_id  = t1.id
)

select allegation_id, race, id from linked_allegation_race