create database diamonds
create table diamonds (
	id		bigint,
	shape	nvarchar(50),
	weight	float,
	clarity	nvarchar(10),
	colour	nvarchar(10),
	cut		nvarchar(10),
	polish	nvarchar(10),
	symmetry	nvarchar(10),
	fluorescene	nvarchar(10),
	measurement	nvarchar(10),
	price	decimal(10,2)
)

select db_name() as currentdatabase
use diamonds

select * from data_cushion$
SELECT * FROM data_emerald$
SELECT * FROM data_heart$
SELECT * FROM data_radiant$
SELECT * FROM data_round$
SELECT * FROM data_oval$
select * from combined_diamonds
--VIEW ALL RECORDS
select *
from dbo.combined_diamonds

--COUNT TOTAL DIAMONDS
select count(*) as Total_Diamonds
from dbo.combined_diamonds

--FIND MAXIMUM PRICE
select max(price) as highest_price
from dbo.combined_diamonds

--FIND MAXIMUM PRICE
select min(price) as minimum_price
from dbo.combined_diamonds

--FIND AVERAGE PRICE
select avg(price) as avg_price
from dbo.combined_diamonds

--NUMBER OF DIAMONDS BY SHAPE
select shape,
count(*) as total_diamonds
from dbo.combined_diamonds
group by Shape

--AVERAGE PRICE BY SHAPE
select shape, 
avg(price) as avg_price
from dbo.combined_diamonds
group by Shape

--HIGHEST PRICE DIAMOND IN EACH SHAPE
select shape,
max(price)as highest_price
from dbo.combined_diamonds
group by Shape

--TOTAL INVENTORY VALUE BY SHAPE
select shape,
sum(price) as total_value
from dbo.combined_diamonds
group by Shape

--AVERAGE PRICE BY SHAPE
select shape,
avg(Price) as avg_price
from dbo.combined_diamonds
group by Shape

--DIAMONDS COSTING MORE THAN 1000
select *
from dbo.combined_diamonds
where price > 1000

--DIAMOND COSTING MORE THAN 1 AND 2 WEIGHT
select *
from dbo.combined_diamonds
where Weight between 1 and 2

--ROUND DIAMONDS ONLY
select * 
from dbo.combined_diamonds
where Shape = 'round'

--WHICH SHAPE GENEREATE HIGHEST REVENUE
select top 1 
shape, sum(price) as Revenue
from dbo.combined_diamonds
group by Shape
order by Revenue desc

--TOP 10 MOST EXPENSIVE DIAMONDS
select top 10 *
from dbo.combined_diamonds
order by price desc

--TOP 5 SHAPES BY AVERAGE PRICE
select top 5
shape, avg(price) avgprice
from dbo.combined_diamonds
group by shape
order by avgprice desc

--WHICH COLOR HAS THE HIGHEST AVERAGE PRICE
select top 1
clarity, 
avg(price) AvgPrice
from dbo.combined_diamonds
group by Clarity
order by AvgPrice desc

--REVENUE CONTRIBUTION PERCENTAGE BY SHAPE
SELECT shape,
       SUM(price) Revenue,
       ROUND(
       SUM(price)*100.0/
       (SELECT SUM(price)
        FROM dbo.combined_diamonds),2)
       AS Revenue_Percentage
FROM dbo.combined_diamonds
GROUP BY shape;

--TOP PERFORMING CLARITY GRADES
select clarity,
avg(price) AvgPrice,
count(*) TotalDiamonds
from dbo.combined_diamonds
group by clarity
order by avgprice desc

--REVENUE BY CUT QUALITY
select cut, 
sum(price) revenue
from dbo.combined_diamonds
group by cut
order by revenue desc

--RANK DIAMONDS BY PRICE
select *,
rank() over
(order by price desc) PriceRank
from dbo.combined_diamonds

--TOP 3 DIAMONDS IN EACH SHAPE
with cte as
(
select *,
	row_number() over
	(partition by shape
	order by price desc) rn
from dbo.combined_diamonds
)
select *
from cte
where rn<=3

--RUNNING TOTAL REVENUE
select price,
	sum(price) over
	(order by price) RunningTotal
from dbo.combined_diamonds

--PRICE CATEGORY SEGMENTATION
select *, 
case
when price < 5000 then 'Low'
when price between 5000 and 10000 then 'Medium'
else 'high'
end as price_category
from dbo.combined_diamonds

--FIND DIAMONDS PRICED ABOVE AVERAGE
select *
from dbo.combined_diamonds
where price >
(
select avg(Price)
from dbo.combined_diamonds
)

--FIND THE 5 MOST EXPENSIVE DIAMONDS IN EACH SHAPE
with rankeddiamonds as 
(
	select *,
	row_number() over
	(
	partition by shape
	order by price desc
	) as rn
from dbo.combined_diamonds
)
select *
from rankeddiamonds
where rn <=5

--FIND SHAPES WHOSE AVERAGE PRICE IS ABOVE THE OVERALL AVERAGE
select shape,
	avg(price) as AvgPrice
from dbo.combined_diamonds
group by Shape
having avg(price) >
(
select avg(price)
from dbo.combined_diamonds
)

--FIND THE SHAPE GENERATING MAXIMUM REVENUE
select top 1
shape, sum(price) as revenue
from dbo.combined_diamonds
group by Shape
order by revenue desc

--REVENUE CONTRIBUTION PERCENTAGE OF EACH SHAPE
select shape,
sum(price) Revenue,
round(
sum(price)*100.0/
(select sum(price)
from dbo.combined_diamonds)
,2) as RevenuePercent
from dbo.combined_diamonds
group by shape

--FIND DIAMONDS PRICED ABOVE THEIR SHAPE AVERAGE
select *
from dbo.combined_diamonds d
where price >
(
select avg(price)
from dbo.combined_diamonds
where shape = d.shape
)

--RANK DIAMONDS BY PRICE
select *,
rank() over
(order by price desc) as pricerank
from dbo.combined_diamonds

--RUNNING REVENUE TOTAL
select price,
sum(price) over
(order by price)
as RunningRevenue
from dbo.combined_diamonds

--CREATE PRICE SEGMENTS
select *,
case
when price <15000 then 'Low'
when price between 5000 and 15000 then 'Medium'
else 'high'
end as PriceCategory
from dbo.combined_diamonds

--WHICH SHAPES ARE UNDERPERFORMING
select shape,
count(*) SalesVolume,
Avg(Price) AvgPrice
from dbo.combined_diamonds
group by Shape
order by salesvolume asc

--WHICH CATEGORY HAS THE HIGHEST INVENTORY VALUES
select shape,
	sum(Price) InventoryValue
from dbo.combined_diamonds
group by shape
order by InventoryValue desc

