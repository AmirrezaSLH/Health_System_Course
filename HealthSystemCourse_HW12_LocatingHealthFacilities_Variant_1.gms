sets
         i       index of candidate locations for PHCs   /1*17/
         j       index of candidate locations for RHCs /1,2,6,7,12,15/
         k       index of patients zones /1*17/
         l       index of candidate locations for DHCs /1,6,11/;

scalars
         M1
         M2
         M3
         tbudget /1000000000000000/;
parameters
         f(i) opening cost of a PHC at candidate location i /1 1903, 2 1902, 3 947, 4 1260, 5 2146, 6 3627, 7 1725, 8 2128, 9 1847, 10 1835, 11 1937, 12 1383, 13 1384, 14 1690, 15 1578, 16 641, 17 1598/
         g(j) opening cost of an RHC at candidate location j /1 36053, 2 31660, 6 49664, 7 18861, 12 19501, 15 17615/
         h(l) opening cost of a DHC at candidate location l  /1 325832, 6 378657, 11 322376/
         p(k) population of patient zone k /1 4297, 2 4611, 3 2270, 4 2765, 5 4135, 6 8000, 7 3360, 8 3982, 9 4086, 10 4002, 11 4147, 12 2972, 13 2622, 14 3738, 15 3241, 16 1499, 17 3701/
         s1(i,j) saving cost of co-opening a PHC and an RHC in the same candidate location i (i = j)
         s2(i,l) saving cost of co-opening a PHC and an DHC in the same candidate location i (i = l)
         s3(j,l) saving cost of co-opening a RHC and an DHC in the same candidate location j (j = l)
         t1(k,i) transportation time from patient zone k to PHC i
         t2(k,j) transportation time from patient zone k to RHC j
         t3(k,l) transportation time from patient zone k to DHC l
         c1(i) capacity of opened PHC at candidate location i /1 27176, 2 29165, 3 14351, 4 17491, 5 26152, 6 50592, 7 21249, 8 25182, 9 25840, 10 25309, 11 26231, 12 18795, 13 16583, 14 23642, 15 20501, 16 9481, 17 23408/
         c2(j) capacity of opened PHC at candidate location i /1 225312, 2 223109, 6 293228, 7 111556, 12 110314, 15 17615/
         c3(l) capacity of opened DHC at candidate location l /1 26354, 6 30627, 11 26074/
         d1(k) average number of visits to a PHC by an individual in patient zone k over the planning horizon
         d2(k) average number of visits to an RHC per each visit to a PHC by an individual in patient zone k over the planning horizon
         d3(k) average number of visits to a DHC for specialty service per each visit to an RHC by an individual in patient zone k over the planning horizon

table    a(k,i) equals 1 if patient zone k could be covered by PHC i and 0 otherwise
        1        2        3        4        5        6        7        8        9        10        11        12        13        14        15        16        17
1       1        1        1        1        1        1        1        1        1        1         1         1         1         1         1         1         1
2       1        1        1        1        1        1        1        1        1        1         1         1         1         1         1         1         1
3       1        1        1        1        1        1        1        1        1        1         1         1         1         1         1         1         1
4       1        1        1        1        1        1        1        1        1        1         1         1         1         1         1         1         1
5       1        1        1        1        1        1        1        1        1        1         1         1         1         1         1         1         1
6       1        1        1        1        1        1        1        1        1        1         1         1         1         1         1         1         1
7       1        1        1        1        1        1        1        1        1        1         1         1         1         1         1         1         1
8       1        1        1        1        1        1        1        1        1        1         1         1         1         1         1         1         1
9       1        1        1        1        1        1        1        1        1        1         1         1         1         1         1         1         1
10      1        1        1        1        1        1        1        1        1        1         1         1         1         1         1         1         1
11      1        1        1        1        1        1        1        1        1        1         1         1         1         1         1         1         1
12      1        1        1        1        1        1        1        1        1        1         1         1         1         1         1         1         1
13      1        1        1        1        1        1        1        1        1        1         1         1         1         1         1         1         1
14      1        1        1        1        1        1        1        1        1        1         1         1         1         1         1         1         1
15      1        1        1        1        1        1        1        1        1        1         1         1         1         1         1         1         1
16      1        1        1        1        1        1        1        1        1        1         1         1         1         1         1         1         1
17      1        1        1        1        1        1        1        1        1        1         1         1         1         1         1         1         1;

t1(k,i) = uniform(0.25,1);
t2(k,j) = uniform(0.25,1);
t3(k,l) = uniform(0.25,1);
s1(i,j) = uniform(1000,1500);
s2(i,l) = uniform(1000,1500);
s3(j,l) = uniform(1000,1500);
d1(k) = 1.265;
d2(k) = 2.52;
d3(k) = 0.065;
M1= sum(k,d1(k)*p(k));
M2= sum(k,d1(k)*d2(k)*p(k));
M3= sum(k,d1(k)*d2(k)*d3(k)*p(k));

binary variables
         x(k,i) 1 if patient zone k is assigned to PHC i otherwise 0
         y(i,j) 1 if patient zone k is assigned to PHC i otherwise 0
         z(j,l) 1 if RHC j refers patients to DHC l otherwise 0
         o1(i)  1 if a PHC is opened at candidate location i otherwise 0
         o2(j)  1 if a RHC is opened at candidate location i otherwise 0
         o3(l)  1 if a DHC is opened at candidate location i otherwise 0;

positive variable
         u(k,i)     flow amount of patients from patient zone k to PHC i over the planning horizon
         v(k,i,j)   flow amount of patients from patient zone k to RHC j through PHC i over the planninghorizon
         w(k,i,j,l) flow amount of patients from patient zone k to DHC l through PHC i and RHC j over the planning horizon;

variables
         obj1 rime;

equations
         objective_function
         facility1(i)
         facility2(j)
         facility3(l)
         cap1(k)
         cap2(k,i)
         cap3(k,i,j)
         flow1(k,i)
         flow2(i,j)
         flow3(j,l)
         allocation1(k)
         allocation2(i)
         allocation3(j)
         budget;

         objective_function  .. obj1 =e= sum((k,i) , t1(k,i)*u(k,i) ) + sum( (k,j) , t2(k,j)*(sum((i),v(k,i,j)))) + sum((k,l), t3(k,l)*(sum((i,j),w(k,i,j,l))));
         facility1(i)        .. sum((k),u(k,i)) =l=c1(i)*o1(i);
         facility2(j)        .. sum((k,i),v(k,i,j)) =l=c2(j)*o2(j);
         facility3(l)        .. sum((k,i,j),w(k,i,j,l)) =l=c3(l)*o3(l);
         cap1(k)             .. sum((i),u(k,i)) =g= d1(k)*p(k);
         cap2(k,i)           .. sum((j),v(k,i,j)) =g= d2(k)*u(k,i);
         cap3(k,i,j)         .. sum((l),w(k,i,j,l)) =g= d3(k)*v(k,i,j);
         flow1(k,i)          .. u(k,i) =l= a(k,i)*M1*x(k,i);
         flow2(i,j)          .. sum(k,v(k,i,j)) =l= M2*y(i,j);
         flow3(j,l)          .. sum((k,i),w(k,i,j,l)) =l= M3*z(j,l);
         allocation1(k)      .. sum(i,x(k,i)) =e= 1;
         allocation2(i)      .. sum(j,y(i,j)) =l= 1;
         allocation3(j)      .. sum(l,z(j,l)) =l= 1;
         budget              .. sum(i,f(i)*o1(i)) + sum(j,g(j)*o2(j)) + sum(l,h(l)*o3(l)) - sum( (i,j),s1(i,j)*o1(i)*o2(j)) - sum( (i,l),s2(i,l)*o1(i)*o3(l)) - sum( (j,l),s3(j,l)*o2(j)*o3(l)) =l= tbudget;



model supplychain /all/;
option limrow=31 , limcol=31;
solve supplychain using MINLP minimizing obj1;
display obj1.l,u.l,v.l,w.l,x.l,z.l,y.l,o1.l,o2.l,o3.l;
