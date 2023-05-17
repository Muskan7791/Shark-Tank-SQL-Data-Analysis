select * from project..data

-- total episodes

select max(epno) from project..data
select count(distinct epno) from project..data

-- pitches 

select count(distinct brand) from project..data

--pitches converted

select cast(sum(a.converted_not_converted) as float) /cast(count(*) as float) from (
select amountinvestedlakhs 
case 
when amountinvestedlakhs>0 then 1 else 0 end as converted_not_converted from project..data) a

-- total male

select sum(male) from project..data

-- total female

select sum(female) from project..data

--gender ratio

select sum(female)/sum(male) from project..data

-- total invested amount

select sum(amountinvestedlakhs) from project..data

-- avg equity taken

select avg(equitytaken)
from project..data 
where equitytaken>0) 

--highest deal taken

select max(amountinvestedlakhs) from project..data 

--higheest equity taken

select max(equitytakenp) from project..data

-- startups having at least one women

select count(brand) from project.. data
where female>0

-- pitches converted having atleast 0ne women

select * from project..data


select count(brand) from project.. data
where amountinvestedlakhs>0 and female>0

-- avg team members

select avg(teammembers) from project..data

-- amount invested per deal

select avg(amountinvestedlakhs) as amount_invested_per_deal from project..data
 where deal!='No Deal'

-- avg age group of contestants

select count(avgage) as cnt_avg from project..data
group by avgage
order by cnt_avg desc

-- location group of contestants

select location,count(location) as cnt from project..data
group by location 
order by cnt desc

-- sector group of contestants

select sector,count(sector) as cnt from project..data 
group by sector 
order by cnt desc


--partner deals

select partners,count(partners) as cnt from project..data  
where partners!='-' 
group by partners 
order by cnt desc

-- making the matrix


select * from project..data

select 'Ashnner' as keyy,count(ashneeramountinvested) from project..data where ashneeramountinvested is not null


select 'Ashnner' as keyy,count(ashneeramountinvested) from project..data where ashneeramountinvested is not null AND ashneeramountinvested!=0

SELECT 'Ashneer' as keyy,SUM(C.ASHNEERAMOUNTINVESTED),AVG(C.ASHNEEREQUITYTAKENP) 
FROM (SELECT * FROM PROJECT..DATA  WHERE ASHNEEREQUITYTAKENP!=0 AND ASHNEEREQUITYTAKENP IS NOT NULL) C


select m.keyy,m.total_deals_present,m.total_deals,n.total_amount_invested,n.avg_equity_taken from

(select a.keyy,a.total_deals_present,b.total_deals from(

select 'Ashneer' as keyy,count(ashneeramountinvested) total_deals_present from project..data where ashneeramountinvested is not null) a

inner join (
select 'Ashneer' as keyy,count(ashneeramountinvested) total_deals from project..data 
where ashneeramountinvested is not null AND ashneeramountinvested!=0) b 

on a.keyy=b.keyy) m

inner join 

(SELECT 'Ashneer' as keyy,SUM(C.ASHNEERAMOUNTINVESTED) total_amount_invested,
AVG(C.ASHNEEREQUITYTAKENP) avg_equity_taken
FROM (SELECT * FROM PROJECT..DATA  WHERE ASHNEEREQUITYTAKENP!=0 AND ASHNEEREQUITYTAKENP IS NOT NULL) C) n

on m.keyy=n.keyy

-- which is the startup in which the highest amount has been invested in each domain/sector




select c.* from 
(select brand,sector,amountinvestedlakhs,rank() over(partition by sector order by amountinvestedlakhs desc) rnk 

from project..data) c

where c.rnk=1
