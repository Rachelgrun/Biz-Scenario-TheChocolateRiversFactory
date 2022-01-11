use chocolateFactoryDB
go

drop table if exists Chocolate

create table dbo.Chocolate(
    ChocolateId int not null primary key identity,
    ChocolateName as concat(ChocolateShape, ' ', 'shaped', ' ', ChocolateFlavor, ' ', chocolateType),
    --ChocolateName varchar(45) not null constraint ck_Chocolate_Chocolate_Name_is_not_blank check(ChocolateName <> ''),
    ChocolateType varchar(25) not null constraint ck_Chocolate_Chocolate_Type_has_to_be_one_of_the_following_options check(ChocolateType in ('Solid Block', 'Chocolate Trouffles', 'Chocolate Candy Bar')),
    ChocolateFlavor varchar(50) not null constraint ck_Chocolate_Chocolate_Flavor_has_to_be_one_of_the_following_options check(ChocolateFlavor in ('Caramalized white chocolate','Milk Chocolate Hazelnut Espresso','Dark 54 Chocolate Rasberry Pomegranate','Dark salted caramel','milk creme & Dark Creme')),
    ChocolateShape varchar(15) not null constraint ck_Chocolate_Chocolate_Shape_has_to_be_one_of_the_following_options check(ChocolateShape in ('heart','oval','square','oracle','ripple','thimble')),
    Country varchar(25) not null constraint ck_Chocolate_Country_cannot_be_blank check(Country <> ''),
    YearOnMarket int not null,
    WeightOfChocolate int not null constraint ck_Chocolate_Weight_Of_Chocolate_must_between_one_and_six check(WeightOfChocolate between 1 and 6),
    DateOfExpiration date not null,
    DateSold date null,
    constraint ck_Chocolate_Date_Sold_must_be_before_date_of_expiration check(DateSold < DateOfExpiration)
)

go 


insert Chocolate(ChocolateType, ChocolateFlavor, ChocolateShape, Country, YearOnMarket, WeightOfChocolate, DateOfExpiration, DateSold)
select 
    ChocolateType = 
        case 
            when m.Medal = 'gold'  then 'Solid Block'
            when m.medal = 'silver' then 'Chocolate Trouffles'
            when m.Medal = 'Bronze' then 'Chocolate Candy Bar'
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
    ChocolateShape =
        case 
            when m.OlympicYear - m.YearBorn between 14 and 16 then 'heart'
            when m.OlympicYear - m.YearBorn between 17 and 27 then 'oval'
            when m.OlympicYear - m.YearBorn between 29 and 41 then 'square'
            when m.OlympicYear - m.YearBorn between 48 and 58 then 'oracle'
            when m.OlympicYear - m.YearBorn between 59 and 60 then 'ripple'
            else 'thimble'
        end,
    Country = m.Country,
    YearOnMarket = m.YearBorn,
    WeightOfChocolate = 
        (m.OlympicYear - m.YearBorn) / 10,
    DateOfExpiration = 
        concat(datepart(year, m.OlympicYear) + 5, '-', '0', datepart(month, m.OlympicYear - m.YearBorn / 6), '-', datepart(day, m.OlympicYear - m.YearBorn / 4)),
    DateSold = 
    concat(datepart(year, m.OlympicYear), '-', '0', datepart(month, m.OlympicYear - m.YearBorn / 6), '-', datepart(day, m.OlympicYear - m.YearBorn / 4))
from RecordKeeperDB.dbo.Medalist m 

select * from Chocolate p 
