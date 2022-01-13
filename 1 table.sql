/*
ChocolateID pk int
ChocolateName as Concat Shape, 'Shaped', flavor, Type
ChocolateType int 1-3 not null
ChocolateTypeDesc as case when then
Flavor int 1-5 not null
FlavorDesc as case when then
Shape varchar 10 in heart,oval,square,oracle,ripple,thimble not null or blank
CountryOfOrigin varchar 50 not null or blank
YearPutOnMarket datepart(year) not null or blank or before 1840
ChocolateWeight int 1-6 not null or blank
ExpirationDate date not null or blank
SoldDate date null
    SoldDate cannot be after expiration date
*/

use ChocolateDB
go
drop table if exists Chocolate
go
create table dbo.Chocolate(
    ChocolateID int not null identity primary key,
    ChocolateName as 
        concat(
            Shape, ' Shaped ',
            case Flavor
                when 1 then 'Caramalized white chocolate'
                when 2 then 'Milk Chocolate Hazelnut Esspresso'
                when 3 then 'Dark 54 Chocolate Rasberry Pomegranate'
                when 4 then 'Dark salted caramel'
                when 5 then 'Milk creme & Dark Creme'
            end
            , ' ',
            case ChocolateType
                when 1 then 'Solid Block'
                when 2 then 'Trouffle'
                when 3 then 'Chocolate Candy Bar'
            end 
        ) persisted,
    ChocolateType int not null
        constraint ck_Chocolate_Type_must_be_entered_as_a_number_between_1_and_3 check(ChocolateType between 1 and 3),
    ChocolateTypeDesc as 
        case ChocolateType
            when 1 then 'Solid Block'
            when 2 then 'Trouffle'
            when 3 then 'Chocolate Candy Bar'
        end persisted,
    Flavor int not null
        constraint ck_Chocolate_Flavor_must_be_entered_as_a_number_between_1_and_5 check(Flavor between 1 and 5),
    FlavorDesc as 
        case Flavor
            when 1 then 'Caramalized white chocolate'
            when 2 then 'Milk Chocolate Hazelnut Esspresso'
            when 3 then 'Dark 54 Chocolate Rasberry Pomegranate'
            when 4 then 'Dark salted caramel'
            when 5 then 'Milk creme & Dark Creme'
        end persisted,
    Shape varchar(10) not null
        constraint ck_Chocolate_Shape_must_be_either_Heart_Oval_Square_Oracle_Ripple_or_Thimble 
            check(Shape in ('Heart', 'Oval', 'Square', 'Oracle', 'Ripple', 'Thimble')),
    CountryOfOrigin varchar(50) not null
        constraint ck_Country_of_Origin_cannot_be_blank check(CountryOfOrigin <> ''),
    YearPutOnMarket int not null
        constraint ck_Year_put_on_market_must_at_least_1840 check(YearPutOnMarket >= 1840),
    ChocolateWeight int not null
        constraint ck_Chocolate_Weight_must_be_between_1_and_6_oz check(ChocolateWeight between 1 and 6),
    ExpirationDate date not null
        constraint ck_Expiration_Date_cannot_be_blank check(ExpirationDate <> ''),
    SoldDate date default null,
    constraint ck_Sold_Date_must_be_between_the_year_put_on_market_and_the_Expiration_Date check(year(SoldDate) >= YearPutOnMarket and SoldDate < ExpirationDate),

)
go