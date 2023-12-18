use test_01;

select dt, count(1) as c
from logs
group by dt
order by c desc;
