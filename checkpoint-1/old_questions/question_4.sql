with weapon_location as (    select trr_trr.id, street, trr_subjectweapon.id, trr_subjectweapon.weapon_type from trr_trr
join trr_subjectweapon on trr_trr.id= trr_subjectweapon.id)

select  street, weapon_type, count(*) as counts from weapon_location
where weapon_type = 'FIREARM - SEMI-AUTOMATIC' or  weapon_type = 'FIREARM - REVOLVER' or  weapon_type = 'FIREARM - SHOTGUN' or
       weapon_type = 'KNIFE/OTHER CUTTING INSTRUMENT' or weapon_type = 'FIREARM - RIFLE' or weapon_type = 'VEHICLE - ATTEMPTED TO STRIKE OFFICER WITH VEHICLE'
group by street, weapon_type
order by counts desc