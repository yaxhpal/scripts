select lib from  authorised_values where category = 'CAT';


SELECT 
authorised_values.lib,
count(items.barcode)
FROM
items 
LEFT JOIN biblioitems ON (items.biblioitemnumber = biblioitems.biblioitemnumber)
LEFT JOIN biblio ON (biblioitems.biblionumber = biblio.biblionumber)
LEFT JOIN authorised_values ON (biblio.category = authorised_values.authorised_value )
LEFT JOIN issues ON (issues.itemnumber = items.itemnumber)
where authorised_values.category = 'CAT'
and items.wthdrawn = '0'
and items.itemlost = '0'
and issues.itemnumber IS NULL
group by authorised_values.lib;


select x.category as y, lib,
sum(case when (homebranch='AH' and onloan is null) then 1 else 0 end) as Ahmedabad,
sum(case when (homebranch='BL' and onloan is null) then 1 else 0 end) as Bangalore,
sum(case when (homebranch='CB' and onloan is null) then 1 else 0 end) as Colombo,
sum(case when (homebranch='CH' and onloan is null)then 1 else 0 end) as Chandigarh,
sum(case when (homebranch='CL' and onloan is null) then 1 else 0 end) as Kolkatta,
sum(case when (homebranch='DL' and onloan is null) then 1 else 0 end) as Delhi,
sum(case when (homebranch='HD' and onloan is null) then 1 else 0 end) as Hyderabad,
sum(case when (homebranch='KD' and onloan is null) then 1 else 0 end) as Kandy,
sum(case when (homebranch='MA' and onloan is null)then 1 else 0 end) as Chennai,
sum(case when (homebranch='PN' and onloan is null) then 1 else 0 end) as Pune,sum(1),
sum(case when onloan is not null then 1 else 0 end) as Issued,
round(((sum(case when onloan is not null then 1 else 0 end))/
(sum(case when itype<>'REF' then 1 else 0 end)))*100,2) as IssuedP
from (select homebranch, itype, category ,onloan from items left join biblio on
items.biblionumber=biblio.biblionumber where wthdrawn=0 and itemlost=0) x left join authorised_values on x.category = authorised_value where itype= 'BK' and authorised_values.category='CAT'  group by y order by lib