--Exercise 1:

SELECT model,speed,hd FROM PC WHERE price<500


--Exercise 2:

SELECT distinct maker from Product where type='printer'


--Exercise 3:

SELECT model,ram,screen from laptop where price>1000


--Exercise 4:

 select * from printer where not color='n' 


--Exercise 5:

SELECT model,speed,hd from pc where price<600 and cd in ('12x','24x')


--Exercise 6:

Select distinct maker as Maker, speed from product join laptop on product.model = laptop.model where laptop.hd>=10


--Exercise 7:

SELECT distinct product.model,price from product join pc on pc.model = product.model where maker='b'
UNION
SELECT distinct product.model,price from product join laptop on laptop.model = product.model where maker='b'
UNION
SELECT distinct product.model,price from product join printer on printer.model = product.model where maker='b'

--Exercise 8:

SELECT distinct maker FROM product where type='pc'
EXCEPT
SELECT maker FROM product where type='laptop'

--Exercise 9:

SELECT distinct maker FROM product join pc on product.model = pc.model where speed>=450

--Exercise 10:

 SELECT model, price 
FROM Printer pr, (SELECT MAX(price) AS maxprice  
                  FROM Printer
                  ) AS mp 
WHERE price = mp.maxprice

--Exercise 11:

 SELECT AVG(speed) FROM PC 


--Exercise 12:

 SELECT AVG(speed) from laptop where price>1000 


--Exercise 13:

 SELECT AVG(pc.speed) from product join pc on product.model = pc.model where product.maker='a' 


--Exercise 14:

 select classes.class,name,country from ships join classes on ships.class=classes.class where numGuns>=10 


--Exercise 15:

 SELECT hd from pc group by hd having count(hd) >=2 


--Exercise 16:

 SELECT distinct a.model,b.model, a.speed, a.ram FROM PC as a JOIN PC as b on a.speed=b.speed and a.ram = b. ram and a.model!=b.model and a.model>b.model 


--Exercise 17:

 SELECT distinct type,laptop.model,speed FROM laptop join product on laptop.model = product.model WHERE laptop.speed < (SELECT min(speed) FROM PC) 


--Exercise 18:

  SELECT distinct maker,price from product join printer on printer.model = product.model where price = (SELECT min(price) FROM printer where color!='n') and color='y' 


--Exercise 19:

 select maker, avg(screen) from product join laptop on laptop.model = product.model group by maker 


--Exercise 20:

 SELECT maker,count(model) from product where type='pc' GROUP BY maker HAVING count(distinct model)>=3 


--Exercise 21:

 select maker,max(pc.price) from product join pc on product.model = pc.model GROUP BY maker 


--Exercise 22:

 SELECT speed,avg(price) from pc GROUP by speed having speed>600 


--Exercise 23:

SELECT distinct maker from product join pc on pc.model = product.model where speed >= ANY(SELECT speed FROM pc where speed>=750)
INTERSECT
SELECT distinct maker from product join laptop on laptop.model = product.model where speed >= ANY(SELECT speed FROM laptop where speed>=750) 


--Exercise 24:

with cte_model(model, HighPrice) as
(select model, max(price) as HighPrice
from laptop
group by model

union

select model, max(price)as HighPrice
from pc
group by model

union

select model, max(price)as HighPrice
from printer
group by model
)
select model from cte_model
where HighPrice=(select max(HighPrice) from cte_model) 

--Exercise 25:

 select distinct maker from product 
where type ='Printer' 

intersect 

select distinct maker from product inner join PC on product.model=pc.model 
where type='PC'and  
pc.speed in 
          (select max(speed) 
           from pc 
           where ram=
                     (select min(ram)from pc)
           )
 and pc.ram=
             (select min(ram)
              from pc) 