with how_many_allegations_recieved_one_cop as (
    select count(allegation_id) as number_allegations, officer_id from data_officerallegation
group by officer_id
order by number_allegations desc),
     officers_count_by_allegation_number as
    (select  number_allegations,  count(officer_id) as number_of_officers  from how_many_allegations_recieved_one_cop group by
    number_allegations order by number_of_officers desc
        )
     , rewards_count_by_officer_id as (select officer_id, count(*) as reward_number from  data_award
       group by  officer_id order by reward_number desc ),
     allegation_and_rewards_by_officer_id as (select rewards_count_by_officer_id.officer_id, rewards_count_by_officer_id.reward_number, how_many_allegations_recieved_one_cop.number_allegations from rewards_count_by_officer_id
         join how_many_allegations_recieved_one_cop on  rewards_count_by_officer_id.officer_id = how_many_allegations_recieved_one_cop.officer_id ),
     officers_count_by_number_allegations_and_reward as (select number_allegations, reward_number, count(officer_id) as number_of_officers from allegation_and_rewards_by_officer_id group by number_allegations, reward_number
order by number_allegations, reward_number),
     avg_number_rewards_by_al as(

select number_allegations, avg(reward_number) as avg_number_rewards from  officers_count_by_number_allegations_and_reward
group by number_allegations
order by number_allegations)
select  * from officers_count_by_number_allegations_and_reward






