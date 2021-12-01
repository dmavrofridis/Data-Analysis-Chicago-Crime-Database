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

   officer_connections AS (
    SELECT A.officer_id AS officer_id1, B.officer_id AS officer_id2, A.allegation_id AS allegation_id
        FROM linked_allegations A, linked_allegations B
        WHERE A.allegation_id = B.allegation_id
            AND A.officer_id <> B.officer_id
        ORDER BY officer_id1
)
select officer_id1 AS src, officer_id2 AS dst, allegation_id from  officer_connections