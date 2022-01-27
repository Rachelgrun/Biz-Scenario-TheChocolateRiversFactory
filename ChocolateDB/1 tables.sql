use chocolateFactoryDB
go
drop table if exists Chocolate
go
create table dbo.Chocolate(
    ChocolateId int not null primary key identity,  
    ChocolateShape varchar(15) not null constraint ck_Chocolate_Chocolate_Shape_has_to_be_one_of_the_following_options check(ChocolateShape in ('heart','oval','square','oracle','ripple','thimble')),
    ChocolateFlavor varchar(50) not null constraint ck_Chocolate_Chocolate_Flavor_has_to_be_one_of_the_following_options check(ChocolateFlavor in ('Caramalized white chocolate','Milk Chocolate Hazelnut Espresso','Dark 54 Chocolate Rasberry Pomegranate','Dark salted caramel','milk creme & Dark Creme')),
    ChocolateType varchar(25) not null constraint ck_Chocolate_Chocolate_Type_has_to_be_one_of_the_following_options check(ChocolateType in ('Solid Block', 'Chocolate Trouffles', 'Chocolate Candy Bar')),
    ChocolateName as concat(ChocolateShape, ' ', 'shaped', ' ', ChocolateFlavor, ' ', chocolateType, '.') persisted,    
    RecipeCountry varchar(25) not null constraint ck_Chocolate_RecipeCountry_cannot_be_blank check(RecipeCountry <> ''),
    YearOnMarket int not null constraint ck_Chocolate_YearOnMarket_must_be_after_1840 check(YearOnMarket >= 1840),
    OZWeightOfChocolate int not null constraint ck_Chocolate_Weight_Of_Chocolate_must_between_one_and_six check(OZWeightOfChocolate between 1 and 6),
    DateOfExpiration date not null,
    DateSold date null,
    constraint ck_Chocolate_Date_Sold_must_be_before_date_of_expiration check(DateSold < DateOfExpiration), 
    constraint ck_Chocolate_YearOnMarket_must_be_before_DateSold check(YearOnMarket < year(DateSold))
)
go 
