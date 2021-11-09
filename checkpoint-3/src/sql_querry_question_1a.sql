with total_pop AS (
     SELECT SUM(count) as population_total, race
     FROM data_racepopulation
     GROUP BY race
 ), data_race_population_by_trr as (
     select subject_race, count(subject_race) as count
     from trr_trr
     group by subject_race
 ), response_type_by_race as (

     select subject_race, trr_trr.id, action, officer_id, resistance_type, action_sub_category,crid,  ta.action as act from trr_trr
     join trr_actionresponse ta on trr_trr.id = ta.trr_id

 ),  resistance_count_grouped_race as (
     select subject_race, resistance_type, count(*) as resistance_count from response_type_by_race
     group by subject_race, resistance_type),

      response_type_grouped_by_resistance_type_and_race as (
         select subject_race, resistance_type, action_sub_category, count(*) as count_number_of_response from response_type_by_race
         where action_sub_category is not Null
         group by  subject_race, resistance_type, action_sub_category
         order by  count_number_of_response
 ),
filtered_raw as (
    select *
    from response_type_by_race
    where action_sub_category is not Null
), filtered_further as(
select subject_race, id, officer_id, crid, resistance_type,act, max(action_sub_category) as sub_category from filtered_raw
group by   subject_race, id, officer_id, crid, act, resistance_type)
,
      added_allegation as (

          select  subject_race, filtered_further.id, filtered_further.crid, resistance_type, sub_category,  final_outcome from filtered_further
           left join data_officerallegation on filtered_further.crid = data_officerallegation.allegation_id

      )
,
 filtered_even_further as(
      select subject_race, id, officer_id, max(sub_category) as sub_category from filtered_further
     group by subject_race, id, officer_id )
, final as (
        select filtered_further.subject_race, filtered_further.id, filtered_further.crid, filtered_further.officer_id, resistance_type,
        act, filtered_further.sub_category from filtered_further
join  filtered_even_further on filtered_even_further.officer_id = filtered_further.officer_id and filtered_even_further.id = filtered_further.id and
                               filtered_even_further.subject_race = filtered_further.subject_race and    filtered_even_further.sub_category = filtered_further.sub_category
), fin as (
     select subject_race,
            final.id,
            final.officer_id,
            resistance_type,
            act,
            sub_category,
            data_officerallegation.final_outcome
     from final
              left join data_officerallegation on crid = allegation_id
 )

select * from fin