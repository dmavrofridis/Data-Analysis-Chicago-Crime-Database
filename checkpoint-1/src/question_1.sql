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
order by number_allegations), max_temp_officer_alleg as (

select number_allegations, max(number_of_officers) as max_officers_per_allegation from  officers_count_by_number_allegations_and_reward
group by  number_allegations
having max(number_of_officers) != 1
order by number_allegations) ,
     most_probable_number_of_reward_for_number_of_allegation as (
select  officers_count_by_number_allegations_and_reward.number_allegations, officers_count_by_number_allegations_and_reward.reward_number, max_temp_officer_alleg.max_officers_per_allegation
from officers_count_by_number_allegations_and_reward join max_temp_officer_alleg on max_temp_officer_alleg.number_allegations = officers_count_by_number_allegations_and_reward.number_allegations and officers_count_by_number_allegations_and_reward.number_of_officers = max_temp_officer_alleg.max_officers_per_allegation)

select number_allegations, reward_number from  most_probable_number_of_reward_for_number_of_allegation