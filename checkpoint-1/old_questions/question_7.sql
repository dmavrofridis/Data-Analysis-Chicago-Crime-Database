with
      rewards_count_by_officer_id as (select officer_id, count(*) as reward_number from  data_award
       group by  officer_id order by reward_number desc ),

     office_id_with_score as (
         select trr_actionresponse.action_sub_category, trr_actionresponse.trr_id,  trr_trr.id, trr_trr.officer_id from trr_trr
         join trr_actionresponse on trr_actionresponse.trr_id = trr_trr.id
     ),
rewards_action_score as(
select office_id_with_score.officer_id, reward_number, office_id_with_score.action_sub_category  from rewards_count_by_officer_id
join  office_id_with_score  on   rewards_count_by_officer_id.officer_id = office_id_with_score.officer_id)

select reward_number, action_sub_category, count(officer_id) as count from rewards_action_score
where action_sub_category is not NULL
group by  reward_number, action_sub_category
order by  action_sub_category desc, count desc, reward_number


--select officer_id, reward_number, trr_actionresponse.action_sub_category from  rewards_count_by_officer_id
--join trr_actionresponse on trr_actionresponse.

