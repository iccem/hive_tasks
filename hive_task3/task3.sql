use test_01;

SET hive.auto.convert.join = false;

select region_, sum(male) as s_male, sum(female) as s_female
from (
select
    ipregions.region region_
    , if(sex='male', count(1), 0) as male
    , if(sex='female', count(1), 0) as female
from ipregions 
    INNER join (
        select ip, sex from users
        ) as sel_users 
        ON ipregions.ip = sel_users.ip
group by ipregions.region, sel_users.sex) as tbl
group by region_;
