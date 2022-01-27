use ChocolateFactoryDB
go

delete Chocolate
insert Chocolate(ChocolateShape, ChocolateFlavor, ChocolateType, RecipeCountry, YearOnMarket, OZWeightOfChocolate, DateOfExpiration, DateSold)
select 
    ChocolateShape =
        case 
            when m.OlympicYear - m.YearBorn between 14 and 16 then 'heart'
            when m.OlympicYear - m.YearBorn between 17 and 27 then 'oval'
            when m.OlympicYear - m.YearBorn between 29 and 41 then 'square'
            when m.OlympicYear - m.YearBorn between 48 and 58 then 'oracle'
            when m.OlympicYear - m.YearBorn between 59 and 60 then 'ripple'
            else 'thimble'
        end,
    ChocolateFlavor = 
        case 
            when m.SportSubcategory like '%Women%' or m.SportSubcategory like '%ladies%' then 'Caramalized white chocolate'
            when m.SportSubcategory like 'Men%' then 'Milk Chocolate Hazelnut Espresso'
            when m.SportSubcategory like '%[0-9]%' then 'Dark 54 Chocolate Rasberry Pomegranate'
            when 
                m.SportSubcategory not like '%Women%' and 
                m.SportSubcategory not like '%ladies%' and  
                m.SportSubcategory  not like 'Men%' and  
                m.SportSubcategory not like '%[0-9]%' and 
                m.SportSubcategory like '% %' 
            then 'Dark salted caramel'
            else 'milk creme & Dark Creme'
        end,
    ChocolateType = 
        case 
            when m.Medal = 'gold'  then 'Solid Block'
            when m.medal = 'silver' then 'Chocolate Trouffles'
            when m.Medal = 'Bronze' then 'Chocolate Candy Bar'
        end,
    RecipeCountry = m.Country,
    YearOnMarket = m.YearBorn,
    OZWeightOfChocolate = (m.OlympicYear - m.YearBorn) / 10,
    DateOfExpiration = datefromparts(m.OlympicYear + 5, datepart(month, ((m.OlympicYear + 5) - m.YearBorn) / 6), datepart(month, ((m.OlympicYear + 5) - m.YearBorn) / 4)),
    DateSold = 
             case 
                when m.YearBorn > m.OlympicYear then null
                else datefromparts(m.OlympicYear, datepart(month, (m.OlympicYear - m.YearBorn) / 6), datepart(month, (m.OlympicYear - m.YearBorn) / 4))
             end
from RecordKeeperDB.dbo.Medalist m 

