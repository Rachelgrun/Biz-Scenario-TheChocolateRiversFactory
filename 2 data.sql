delete Chocolate

insert Chocolate (ChocolateType, Flavor, Shape, CountryOfOrigin, YearPutOnMarket, ChocolateWeight, ExpirationDate, SoldDate)
select
--ChocolateType
case m.Medal
    when 'Gold' then 1
    when 'Silver' then 2
    when 'Bronze' then 3
    end,
--Flavor
case
    when m.SportSubcategory like '%Women%' or m.SportSubcategory like '%Ladies%' then 1
    when m.SportSubcategory like '% Men%' or m.SportSubcategory like 'Men%' then 2
    when m.SportSubcategory like '%[0-9]%' then 3
    when m.SportSubcategory not like '% %'then 4
    else 5
    end,
--Shape
case 
    when m.OlympicYear - m.YearBorn between 14 and 16 then 'Heart'
    when m.OlympicYear - m.YearBorn between 17 and 27 then 'Oval'
    when m.OlympicYear - m.YearBorn between 29 and 41 then 'Square'
    when m.OlympicYear - m.YearBorn between 48 and 58 then 'Oracle'
    when m.OlympicYear - m.YearBorn between 59 and 60 then 'Ripple'
    else 'Thimble'
    end,
--CountryOfOrigin
m.Country,
--YearPutOnMarket
case
    when m.YearBorn > 1840 then m.YearBorn
    else 1840
end,
--ChocolateWeight
(m.OlympicYear - m.YearBorn) / 10,
--ExpirationDate
DATEFROMPARTS(m.OlympicYear + 5, (m.OlympicYear - m.YearBorn) / 6, (m.OlympicYear - m.YearBorn) / 4),
--SoldDate
DATEFROMPARTS(m.OlympicYear, (m.OlympicYear - m.YearBorn) / 6, (m.OlympicYear - m.YearBorn) / 4)
from RecordKeeperDB.dbo.Medalist m 

select * from Chocolate
