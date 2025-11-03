reigns(syed, 1900, 1950).
reigns(ukkashah, 1950, 1980).
reigns(ahmed, 1980, 2000).
reigns(shah, 2000, 2020).

ruler(X,Y):- reigns(X,A,B),
            Y>=A,
            Y=<B.


population(china, 100).
population(india, 85).
population(usa, 30).
population(germany, 9).

area(china, 10).
area(india, 4).
area(usa, 12).
area(germany,2).

density(X,Y):- population(X,Pop),
                area(X,Ar),
                Y is Pop/Ar.