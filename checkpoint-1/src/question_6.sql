with weapon_response as (
select trr_subjectweapon.trr_id,  trr_subjectweapon.weapon_type, trr_actionresponse.action_sub_category from  trr_subjectweapon
join trr_actionresponse on trr_subjectweapon.trr_id = trr_actionresponse.trr_id)


select  action_sub_category, weapon_type, count(trr_id) as count from  weapon_response
where  weapon_type  = 'HANDS/FISTS'  or  weapon_type  = 'FEET ' or weapon_type = 'MOUTH (SPIT,BITE,ETC)' or
      weapon_type = 'FEET' or weapon_type = 'VERBAL THREAT (ASSAULT)' or weapon_type = 'MOUTH (SPIT,BITE,ETC)'
group by action_sub_category, weapon_type
order by action_sub_category desc , count
