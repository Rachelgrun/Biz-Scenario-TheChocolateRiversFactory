insert Chocolate (ChocolateType, Flavor, Shape, CountryOfOrigin, YearPutOnMarket, ChocolateWeight, ExpirationDate, SoldDate)
select 1, 1, 'Heart', 'USA', '2021', 1, '2026-01-01', '2021-01-01'

--not null
insert Chocolate (ChocolateType, Flavor, Shape, CountryOfOrigin, YearPutOnMarket, ChocolateWeight, ExpirationDate, SoldDate)
select null, 1, 'Heart', 'USA', '2021', 1, '2026-01-01', '2021-01-01'

--not blank
insert Chocolate (ChocolateType, Flavor, Shape, CountryOfOrigin, YearPutOnMarket, ChocolateWeight, ExpirationDate, SoldDate)
select 1, 1, '', 'USA', '2021', 1, '2026-01-01', '2021-01-01'

--Type bet 1 and 3
insert Chocolate (ChocolateType, Flavor, Shape, CountryOfOrigin, YearPutOnMarket, ChocolateWeight, ExpirationDate, SoldDate)
--select 0, 1, 'Heart', 'USA', '2021', 1, '2026-01-01', '2021-01-01'
select 4, 1, 'Heart', 'USA', '2021', 1, '2026-01-01', '2021-01-01'

--Flavor between 1 and 5
insert Chocolate (ChocolateType, Flavor, Shape, CountryOfOrigin, YearPutOnMarket, ChocolateWeight, ExpirationDate, SoldDate)
--select 1, 0, 'Heart', 'USA', '2021', 1, '2026-01-01', '2021-01-01'
select 1, 6, 'Heart', 'USA', '2021', 1, '2026-01-01', '2021-01-01'

--Shape in heart,oval,square,oracle,ripple,thimble
insert Chocolate (ChocolateType, Flavor, Shape, CountryOfOrigin, YearPutOnMarket, ChocolateWeight, ExpirationDate, SoldDate)
select 1, 1, 'Triangle', 'USA', '2021', 1, '2026-01-01', '2021-01-01'

--YearPutOnMarket not before 1840
insert Chocolate (ChocolateType, Flavor, Shape, CountryOfOrigin, YearPutOnMarket, ChocolateWeight, ExpirationDate, SoldDate)
select 1, 1, 'Heart', 'USA', '1839', 1, '2026-01-01', '2021-01-01'

--Weight between 1 and 6
insert Chocolate (ChocolateType, Flavor, Shape, CountryOfOrigin, YearPutOnMarket, ChocolateWeight, ExpirationDate, SoldDate)
--select 1, 1, 'Heart', 'USA', '2021', 0, '2026-01-01', '2021-01-01'
select 1, 1, 'Heart', 'USA', '2021', 7, '2026-01-01', '2021-01-01'

--Sold date not after expiration date
insert Chocolate (ChocolateType, Flavor, Shape, CountryOfOrigin, YearPutOnMarket, ChocolateWeight, ExpirationDate, SoldDate)
select 1, 1, 'Heart', 'USA', '2021', 1, '2021-01-01', '2026-01-01'

