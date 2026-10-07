-- Uloha 1

with daily_sales as 
(
  select sale_date, sum(total_amount) as total_daily_sales from flourmills_sales
  group by sale_date
)
select * from daily_sales
where total_daily_sales > 30000000
order by total_daily_sales desc
limit 5;
