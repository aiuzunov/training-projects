--SQL exercises from https://www.sql-ex.com/exercises/

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

--Exercise 26:

SELECT avg(price) FROM(
SELECT price from laptop join product on product.model=laptop.model where product.maker='a'
UNION ALL
SELECT price from pc join product on product.model=pc.model where product.maker='a') x 

--Exercise 27:

SELECT maker, avg(hd) from pc join product on product.model = pc.model where maker IN (SELECT DISTINCT maker from product where type='printer') group by maker

--Exercise 28:

 SELECT COUNT(*) from (select maker from product group by maker having count(model)=1) as x

--Exercise 29:

SELECT Income_o.point, Income_o.date, SUM(inc),SUM(out)
FROM Income_o LEFT JOIN
Outcome_o ON Income_o.point = Outcome_o.point AND
Income_o.date = Outcome_o.date
GROUP BY Income_o.point, Income_o.date
UNION
SELECT Outcome_o.point, Outcome_o.date, SUM(inc),SUM(out)
FROM Outcome_o LEFT JOIN
Income_o ON Income_o.point = Outcome_o.point AND
Income_o.date = Outcome_o.date
GROUP BY Outcome_o.point, Outcome_o.date 

--Exercise 30:

SELECT DISTINCT point,date,SUM(out) AS out, SUM(inc) AS inc FROM (
SELECT Income.point, Income.date, out, inc
FROM Income LEFT JOIN
Outcome ON Income.point = Outcome.point AND
Income.date = Outcome.date AND Income.code= Outcome.code
UNION ALL
SELECT Outcome.point, Outcome.date, out, inc
FROM Outcome LEFT JOIN
Income ON Income.point = Outcome.point AND
Income.date = Outcome.date AND Income.code=Outcome.code) AS t1
GROUP BY point, date

--Exercise 31:

SELECT class, country
FROM Classes
WHERE bore>=16

--Exercise 32:



--Exercise 33:

SELECT ship
FROM Outcomes
WHERE battle="North Atlantic"
AND result="sunk"

--Exercise 34:

SELECT name
FROM Ships, Classes
WHERE launched >=1922
AND displacement >35000
AND Classes.class = Ships.class
AND type="bb"

--Exercise 35:


--Exercise 36:

SELECT distinct c.class
FROM
(
SELECT s.class, s.name
FROM Ships s
UNION
SELECT o.ship as "class", o.ship
FROM Outcomes o
WHERE NOT EXISTS( SELECT * FROM Ships s WHERE s.name = o.ship)
) s
INNER JOIN Classes c ON (c.class = s.class) AND (c.class = s.name)

--Exercise 37:

SELECT c.class
FROM
(
SELECT s.class, s.name
FROM Ships s
UNION
SELECT o.ship as ‘class’, o.ship
FROM Outcomes o
WHERE NOT EXISTS( SELECT * FROM Ships s WHERE s.name = o.ship)
) s
INNER JOIN Classes c ON c.class = s.class
GROUP by c.class
HAVING count(*) = 1 

--Exercise 38:

Select distinct country from Classes where type ="bb"
INTERSECT
Select distinct country from Classes where type ="bc"

--Exercise 39:



--Exercise 40:



--Exercise 41:


--Exercise 42:

SELECT o.ship, o.battle
FROM outcomes o
LEFT JOIN Battles b ON b.name=o.battle
WHERE o.result = "sunk"

--Exercise 43:

--Exercise 44:

Select name
from Ships
where name like 'R%'
union
Select ship
from Outcomes
where ship like 'R%'

--Exercise 45:

--Exercise 46:

select name, displacement,numGuns
from outcomes
join (classes join ships on classes.class=ships.class) on ship=name
where battle="Guadalcanal"
union
select ship,displacement,numGuns
from outcomes
left join classes on ship=classes.class
where battle="Guadalcanal"
and ship not in (select name from ships)

--Exercise 47:



--Exercise 48:

select class
from ships, outcomes
where outcomes.ship=Ships.name
and result="sunk"
union
select ship
from outcomes, classes
where classes.class=outcomes.ship
and result="sunk"

--Exercise 49:

select name
from ships, classes
where ships.class=classes.class
and bore=16
union
select ship
from outcomes, classes
where outcomes.ship=classes.class
and bore=16

--Exercise 50:

SELECT distinct battle
FROM Classes
inner JOIN Ships  ON ships.class = classes.class
inner JOIN Outcomes  ON Classes.class=Outcomes.ship or Ships.name=Outcomes.ship
WHERE classes.class = "Kongo"
