sets
         i index of candidate locations for manufacturing sites /1*8/
         j index of candidate locations for main DCs /1*10/
         k index of candidate locations for local DCs /1*31/
         kp index of candidate locations for local DCs /1*31/
         l index of customer zones including hospitals clinics and pharmacies /1*31/
         n index of possible capacity levels for main DCs /1*3/
         t index of periods /1*16/;


parameters
         f(i) fixed cost of opening manufacturing center i /1 100000, 2 102400, 3 97500, 4 102400, 5 102400, 6 100000, 7 100000, 8 102400/
         h(k) fixed cost of opening local DC k
         c(i,j) unit transportation cost of product
         a(j,k) unit transportation cost of product from main DC j to local DC k
         tr(kp,k) safety stock of product in local DC k at the end of period t
         e(k,l) unit transportation cost of product from local DC k tocustomer zone
         SC(j) unit storage cost of product family p at the end of each periodin main DC j
         SCp(k) unit storage cost of product family p at the end of each periodin local DC k
         SS(k,t) safety stock of product p in local DC k at the end of period t

         gama(k) storage capacity available at local DC k
         tha(i) effective production capacity of manufacturing site i for product;

         h(k)       = uniform(1000,9000);
         c(i,j)     = uniform(50,180);
         a(j,k)     = uniform(50,180);
         tr(kp,k)   = uniform(10,80);
         e(k,l)     = uniform(10,80);
         SC(j)      = uniform(50,450);
         SCp(k)     = uniform(50,450);
         SS(k,t)    = uniform(1,5);

         gama(k)    = uniform(100,900);
         tha(i)     = uniform(200,205);


table    delta(j,n)
         1       2       3
1        80      120     160
2        80      120     160
3        80      120     160
4        80      120     160
5        80      120     160
6        80      120     160
7        80      120     160
8        80      120     160
9        80      120     160
10       80      120     160;

table    g(j,n)
         1       2       3
1        3840    5760    7680
2        2176    3264    4352
3        2018    3072    4096
4        2176    3264    4352
5        1920    2880    3840
6        2048    3072    4096
7        2048    3072    4096
8        2176    3264    4352
9        1920    2880    3840
10       2048    3072    4096;

table    d(l,t)
         1       2       3       4
1        43.8    43.9    46.1    46.1
2        36.3    36.3    37.5    37.6
3        14.7    14.9    15.2    15.3
4        57.5    57.6    58.8    60
5        6.6     6.6     6.7     6.9
6        12.2    12.4    12.4    12.6
7        144     145     146     148
8        10.7    10.7    10.9    11
9        7.8     8       8       8.1
10       70.2    71.3    72.5    73.7
11       10.2    10.3    10.5    10.6
12       53.7    53.9    54      54.2
13       12      12.1    12.3    12.4
14       7.4     7.6     7.7     7.8
15       30      30.1    30.2    31.3
16       53.9    53.9    55      55.2
17       14.3    14.4    14.6    14.7
18       13.6    13.7    13.7    13.8
19       17.6    17.8    17.9    18.2
20       33.9    36.1    36.1    36.9
21       22.5    23.7    23.8    23.8
22       7.8     7.9     8       8
23       20.5    21.6    21.7    21.9
24       29.6    29.9    30      30.1
25       20.4    20.5    20.6    20.7
26       36.3    36.3    37.4    37.5
27       16.6    16.9    17.1    17.4
28       18.6    18.9    19.1    19.4
29       20.4    20.5    21.6    21.8
30       12.6    12.9    13      13.2
31       19.7    20      20      20.1;

variable
         W min cost;

Binary variables
         x(i)  1 if potential manufacturing center i for producing product is opened and 0 otherwise
         y(j,n)  1 if potential main DC j with capacity level n is opene and 0 otherwise
         z(k)  1 if potential local DC k is opened and 0 otherwise;
positive variables
         u(i,j,t) quantity of product manufactured at manufacturing site i in period t and shipped to main DC j
         q(j,k,t) quantity of product shipped from main DC j to localDC k in period t
         v(kp,k,t) quantity of product transshipped from local DC k to k in period t
         o(k,l,t) quantity of product shipped from local DC k to customer l in period t
         I1(j,t)  inventory level of product at main DC j at the end of period t
         Ip(k,t) inventory level of product at local DC k at the end of period t;



equations
         objective_function
         eequation1(j,t)
         eequation2(k,t)
         DCcap1(i,t)
         DCcap2(j,t)
         DCcap3(k,t)
         SSequation(k,t)
         Openingprob(j)
         Demand(l,t);

         objective_function ..  W =e= sum((i),f(i)*x(i)) + sum((j,n),g(j,n)*y(j,n))+ sum((k),h(k)*z(k))+sum((i,j,t),c(i,j)*u(i,j,t)) + sum((j,k,t),a(j,k)*q(j,k,t))+sum((k,kp,t),tr(kp,k)*v(kp,k,t))+sum((k,l,t),e(k,l)*o(k,l,t))+ sum((j,t),SC(j)*I1(j,t))+sum((k,t),SCp(k)*Ip(k,t))   ;
         eequation1(j,t) .. I1(j,t)=e=I1(j,t-1)+sum((i),u(i,j,t))-sum((k),q(j,k,t));
         eequation2(k,t) .. Ip(k,t)=e=Ip(k,t-1)+sum((j),q(j,k,t))-sum((l),o(k,l,t))+sum((kp),v(kp,k,t))-sum((kp),v(kp,k,t));
         DCcap1(i,t) ..  sum((j),u(i,j,t)) =l= x(i)*tha(i);
         DCcap2(j,t) ..  I1(j,t-1)+sum((i),u(i,j,t))  =l=sum((n),y(j,n)*delta(j,n));
         DCcap3(k,t) .. Ip(k,t-1)+sum((j),q(j,k,t))+sum((kp),v(kp,k,t)) =l= gama(k)*z(k);
         SSequation(k,t) .. Ip(k,t) =g= SS(k,t)*z(k);
         Openingprob(j) ..  sum((n),y(j,n)) =l= 1;
         Demand(l,t) .. d(l,t)-sum((k),o(k,l,t))=l=0;

model supplychain /all/;
option limrow=31 , limcol=31;
solve supplychain using MIP minimizing W;
display W.l,x.l,y.l,z.l,o.l,u.l,q.l,v.l,I1.l,Ip.l;
