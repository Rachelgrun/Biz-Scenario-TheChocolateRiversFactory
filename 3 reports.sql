/*
1)Inorder to see which flavor is most popular, can you show me how long has each flavor been 
sitting on the shelf before it was sold (per chocolate flavor and chocolateType)? overall which flavor
was on the shelf the longest? which the shortest?
*/

select c.FlavorDesc, c.ChocolateTypeDesc, AvgYearsOnShelf = 
AVG(YEAR(c.SoldDate) - c.YearPutOnMarket), MinYearsOnShelfPerFlavor = MIN(YEAR(c.SoldDate) - c.YearPutOnMarket), MaxYearsOnShelfPerFlavor = MAX(YEAR(c.SoldDate) - c.YearPutOnMarket)
from Chocolate c 
group by c.FlavorDesc, c.ChocolateTypeDesc
order by MinYearsOnShelfPerFlavor

/*
2)Can you print out a list as of January first 1917 which chocolate were put on the shelf but not yet sold.They got sold within the next 17 years.
show the pieces in this order: Chocolate Name,yearPutOnShelf,DateSold,#Yearsold(the year it got sold after this point)
*/

select c.ChocolateName, c.YearPutOnMarket, c.SoldDate, YearsAfter1917sold = YEAR(c.SoldDate) - 1917
from Chocolate c 
where c.YearPutOnMarket <= 1917
    and YEAR(c.SoldDate) >= 1917
order by YearsAfter1917sold desc 

/*
3) Mix together some flavors by subtracting 2 ingredients from 3-5 and adding 2 from 1 and 2 
what number flavor comes out? present the Recipe as the chocolate type description colon the chocolate flavor description colon the chocolate flavor numbernand then
which operation it will get either plus 2 or minus 2 based on its flavor number i.e Chocolate Candy Bar:milk creme & Dark Creme: 5-2
*/

select NewChocolate= CONCAT(c.FlavorDesc,
    case 
        when (case when c.Flavor in (1,2) then c.Flavor + 2 else c.Flavor - 2 end) = 1 then 'Caramalized white chocolate'
        when (case when c.Flavor in (1,2) then c.Flavor + 2 else c.Flavor - 2 end) = 2 then 'Milk Chocolate Hazelnut Esspresso'
        when (case when c.Flavor in (1,2) then c.Flavor + 2 else c.Flavor - 2 end) = 3 then 'Dark 54 Chocolate Rasberry Pomegranate'
        when (case when c.Flavor in (1,2) then c.Flavor + 2 else c.Flavor - 2 end) = 4 then 'Dark salted caramel'
        when (case when c.Flavor in (1,2) then c.Flavor + 2 else c.Flavor - 2 end) = 5 then 'Milk creme & Dark Creme'
    end,
    ' ', c.ChocolateTypeDesc),
Recipe = 
 CONCAT(
    c.ChocolateTypeDesc, ':', c.FlavorDesc, 
    ' ',
    ': ', c.Flavor,
    case 
    when c.Flavor between 3 and 5 then '-2'
    else '+2'
    end
)
from Chocolate c 