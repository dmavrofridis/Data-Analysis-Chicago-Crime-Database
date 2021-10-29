with action_location as (
select trr_actionresponse.action_sub_category, trr_trr.street, trr_trr.id from trr_trr
join  trr_actionresponse on trr_trr.id =  trr_actionresponse.id)


select  action_sub_category, street, count(*) as count from action_location
where action_sub_category is not NULL
group by action_sub_category, street
order by action_sub_category desc, count desc


