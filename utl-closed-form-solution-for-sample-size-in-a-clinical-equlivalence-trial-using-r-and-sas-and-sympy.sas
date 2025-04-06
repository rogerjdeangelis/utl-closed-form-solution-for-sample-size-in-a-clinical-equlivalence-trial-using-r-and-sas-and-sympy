%let pgm=utl-closed-form-solution-for-sample-size-in-a-clinical-equlivalence-trial-using-r-and-sas-and-sympy;

%stop_submission;

Closed form solution for sample size in a clinical equlivalence trial using r and sas and sympy

githib
https://tinyurl.com/p8y9b9h4                                                                                                          
https://github.com/rogerjdeangelis/utl-closed-form-solution-for-sample-size-in-a-clinical-equlivalence-trial-using-r-and-sas-and-sympy

communities.sas
https://tinyurl.com/5n729mp3
https://communities.sas.com/t5/SAS-Programming/Sample-size-superiority-and-noninferiority-trial/m-p/837299#M331043

FreelanceReinh
https://communities.sas.com/t5/user/viewprofilepage/user-id/32733

 CONTENTS Clinical Equivalence Trial ( Isuspect Superiority amd Inferiority trials have a similar closed form?)

    1 closed form solution
    2 sas proc power
      https://communities.sas.com/t5/user/viewprofilepage/user-id/32733
    3 r stats package
    4 Simulation supporting Type 2 error of 0.90 for power
      https://communities.sas.com/t5/user/viewprofilepage/user-id/32733
    5 Sample sizes for the  commonly used values for power (0.80 to 0.90)
/*               _
 _ __  _ __ ___ | |__   ___ _ __ ___
| `_ \| `__/ _ \| `_ \ / _ \ `_ ` _ \
| |_) | | | (_) | |_) |  __/ | | | | |
| .__/|_|  \___/|_.__/ \___|_| |_| |_|
|_|
*/

PRODUCE THIS PLOT
                       Sample Sizes by Power

                                POWER
          0.80 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.90
        ---+----+----+----+----+----+----+----+----+----+----+---
 SAMPLE |                                                       |
        | Equivalence Trial                                     |
        |                                                       |
        | H0: |P1-p2| => 2%                                     |
        | H1: |p1-p2} <  2%                                     |
        |                                                       |
        | pavg = (P1+P2)/2                                      |
        |                                                       |
        | Per Group sample size =                             2 |
        | /       __________________            ____________ \  |
        | \z975*\/p1*(1-p1)+p2*(1-p2)+\/2*z90*\/pavg*(1-pavg)/  |
  Per   | ----------------------------------------------------- | Per
  Group |                                  2                    | Group
  Sample|                         (p1 - p2)                     | Sample
  Size  | PARAMETERS                                            | Size
        |  Number of Sides                  2                   |
   2100 +  Alpha z95                     0.05                   + 2100
        |  Group 1 Proportion P1         0.97                   |
        |  Group 2 Proportion P2         0.95                   |
        |  Power Range z## Beta          0.80-0.90              |
        |  Null Proportion Difference       0           2016 *  |
   2000 +  Pooled Proportion (p1 + p2)/2 0.96                   + 2000
        |                                                       |
        |                 ___________________                   |
        | H0 variance \/2 * pavg*(1 - pavg)            * 1948   |
        |               ________________________                |
   1900 + H1 variance \/ p1*(1 - p1)+p2*(1 - p2)                + 1900
        |                                         * 1886        |
        |                                                       |
        |CHECK                                                  |
        | proc power;                          * 1828           |
   1800 + twosamplefreq                                         + 1800
        | groupps=(0.97 0.95)             * 1774                |
        | alpha=0.05 power=0.9                                  |
        | test=pchi sides=2                                     |
        | npergroup=.;               * 1723                     |
   1700 +                                                       + 1700
        | Power=0.80           * 1675   CHECK (power=0.80)      |
        | N per group =2016             ==================      |
        |                 * 1630                                |
        |                         proc power;                   |
   1600 +                         twosamplefreq                 + 1600
        |            * 1587       groupps=(0.97 0.95)           |
        |                         alpha=0.05 power=0.8          |
        |       * 1546            test=pchi sides=2 npergroup=.;|
        |                         run;                          |
   1500 +  * 1506                                               + 1500
        |                         Power=0.80 N per group=1506   |
        ---+----+----+----+----+----+----+----+----+----+----+---
         0.80 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.90
                               POWER


SOAPBOX ON

  Please be skeptical.
  github is for software development?

I am the anti-latex guy.

Checking with SeepSeek and Perplexity query

I also did some indeoendant research.
Using the links provided.

We have previous knowledge that drug A has a rate of 97% for cancer remission.
We wish to perform a equivalence clinical trial using  Pearson Chi-square
Test for Proportion Difference against a new drug.
Medical affairs defines drug equivalence if drug b is between 95% and 99%.
How does R get a per group size of 2016 with the stats package using these prameters?
p1 <- 0.97
delta <- 0.02
alpha <- 0.025
power <- 0.9
How does sas get 2016
with this code?
proc power;
twosamplefreq groupps=(0.97 0.95) alpha=0.05 power=0.9
test=pchi sides=2 npergroup=.;
run;
Please provide closed form solutions for per group sample size.

Anti Latex ascii line printer output

%utl_pybeginx;
parmcards4;
from sympy import symbols, exp, pi, sqrt, integrate, diff, simplify, pprint, erf;
z95 = symbols('z95');
z90 = symbols('z90');
p1 = symbols('p1');
p2 = symbols('p2');
pavg = symbols('pavg');
sm=  (z95 * sqrt(2 * pavg * (1 -  pavg)) + z90 * sqrt (p1*(1 - p1) + p2*(1 - p2)))**2 /(p1-p2)**2
pprint(sm)
;;;;
%utl_pyendx;
                                                                                2
             /      ___________________________     ___       _________________\
             \z90*\/ p1*(1 - p1) + p2*(1 - p2)  + \/ 2 *z95*\/ pavg*(1 - pavg) /
sample size= --------------------------------------------------------------------
                                                   2
                                          (p1 - p2)

SOAPBOX OFF

/*        _                    _    __                                 _       _   _
/ |   ___| | ___  ___  ___  __| |  / _| ___  _ __ _ __ ___   ___  ___ | |_   _| |_(_) ___  _ __
| |  / __| |/ _ \/ __|/ _ \/ _` | | |_ / _ \| `__| `_ ` _ \ / __|/ _ \| | | | | __| |/ _ \| `_ \
| | | (__| | (_) \__ \  __/ (_| | |  _| (_) | |  | | | | | |\__ \ (_) | | |_| | |_| | (_) | | | |
|_|  \___|_|\___/|___/\___|\__,_| |_|  \___/|_|  |_| |_| |_||___/\___/|_|\__,_|\__|_|\___/|_| |_|

*/


                                              ___________________
NULL: H0: |P1-p2| => 2%        variance = \/2 * pavg*(1 - pavg)
                                            __________________________
ALTERNATE : H1: |p1-p2} <  2%  variance   \/ p1*(1 - p1) + p2*(1 - p2)

If our sample size supports the alternate hypothesis H1  |p1-p2} < 2%
with confidence 0.90 (power) and sigificance .05(two sided) then we
can reject the null's false claim that |P1-p2| => 2% .
Thus medical affairs has evidence that the new drug meets the
the medical affairs  clinically significant definition of
eqivalence.

Closed form Solution

pavg  = (p1 + p2) /2    = 0.96  Pooled proportion
z975  = probit(0.975)   = 1.960 (alpha=0.5)
z90   = probit(0.90)    = 1.282 (beta=0.90)

squaring normals allows use to use the chi-square distribution?
                                                                                            2
                        /       __________________________      ___       _________________ \
                        \z975*\/ p1*(1 - p1) + p2*(1 - p2)  + \/ 2 *z90*\/ pavg*(1 - pavg)  /
per group sample size = --------------------------------------------------------------------
                                                              2
                                                     (p1 - p2)

Note :

          __________________________
   z975*\/ p1*(1 - p1) + p2*(1 - p2)   the type 1 error  (alpha=0.05) contribution to sample size

     ___       _________________
   \/ 2 *z90*\/ pavg*(1 - pavg)        the type 2 error  (power beta=0.90) contribution to sample size


            2
   (p1 - p2)    Scaling factor


data chk;

  p1 = .97;
  p2 = .95;

  pavg = (p1 + p2)/2;

  num = ceil(( probit(.975) * sqrt(2 * pavg * (1 - pavg)) + probit(.90) * sqrt (p1*(1 - p1) + p2*(1 - p2)))**2 /(p2-p1)**2);
  put num=;

run;quit;

/**************************************************************************************************************************/
/* Sample size per group = NUM=2016                                                                                       */
/**************************************************************************************************************************/

/*___
|___ \   ___  __ _ ___   _ __  _ __ ___   ___   _ __   _____      _____ _ __
  __) | / __|/ _` / __| | `_ \| `__/ _ \ / __| | `_ \ / _ \ \ /\ / / _ \ `__|
 / __/  \__ \ (_| \__ \ | |_) | | | (_) | (__  | |_) | (_) \ V  V /  __/ |
|_____| |___/\__,_|___/ | .__/|_|  \___/ \___| | .__/ \___/ \_/\_/ \___|_|
                        |_|                    |_|
*/

proc power;
twosamplefreq groupps=(0.97 0.95) alpha=0.05 power=0.9
test=pchi sides=2 npergroup=.;
run;

proc power;
twosamplefreq groupps=(0.97 0.95) alpha=0.05 power=0.8
test=pchi sides=2 npergroup=.;
run;

/**************************************************************************************************************************/
/* The POWER Procedure                                                                                                    */
/* Pearson Chi-square Test for Proportion Difference                                                                      */
/*                                                                                                                        */
/*              Fixed Scenario Elements                                                                                   */
/*                                                                                                                        */
/* Distribution                     Asymptotic normal                                                                     */
/* Method                        Normal approximation                                                                     */
/* Number of Sides                                  2                                                                     */
/* Alpha                                         0.05                                                                     */
/* Group 1 Proportion                            0.97                                                                     */
/* Group 2 Proportion                            0.95                                                                     */
/* Nominal Power                                  0.9                                                                     */
/* Null Proportion Difference                       0                                                                     */
/*                                                                                                                        */
/*                                                                                                                        */
/* Computed N per Group                                                                                                   */
/*                                                                                                                        */
/* Actual    N per                                                                                                        */
/*  Power    Group                                                                                                        */
/*                                                                                                                        */
/*  0.900     2016                                                                                                        */
/**************************************************************************************************************************/

/*____              _        _                          _
|___ /   _ __   ___| |_ __ _| |_ ___   _ __   __ _  ___| | ____ _  __ _  ___
  |_ \  | `__| / __| __/ _` | __/ __| | `_ \ / _` |/ __| |/ / _` |/ _` |/ _ \
 ___) | | |    \__ \ || (_| | |_\__ \ | |_) | (_| | (__|   < (_| | (_| |  __/
|____/  |_|    |___/\__\__,_|\__|___/ | .__/ \__,_|\___|_|\_\__,_|\__, |\___|
                                      |_|                         |___/
*/

%utl_rbeginx;
parmcards4;
library(stats)
library(haven)
p1 <- 0.97       # Current treatment remission rate
delta <- 0.02    # Equivalence margin (2%)
alpha <- 0.025   # One-sided alpha (since equivalence is two-sided, we adjust)
power <- 0.9     # Desired power

# Assume p2 is between 95% and 99% (within equivalence margin)
# Worst-case scenario for sample size: p2 = p1 - delta = 0.95

# Using power.prop.test for equivalence (two-sided)
  n <- power.prop.test(
  p1 = p1,
  p2 = p1 - delta,  # Testing lower bound of equivalence
  sig.level = alpha * 2,  # Two-sided alpha adjustment
  power = power,
  alternative = "two.sided"
)

# Print sample size per group
print(ceiling(n$n))
writeClipboard(n$n);
;;;;
%utl_rendx(return=sample_size);

%put The per group sample size is  &sample_size;

/**************************************************************************************************************************/
/* The per group sample size is  [1] 2016                                                                                 */
/**************************************************************************************************************************/

/*  _         _                 _       _   _
| || |    ___(_)_ __ ___  _   _| | __ _| |_(_) ___  _ __
| || |_  / __| | `_ ` _ \| | | | |/ _` | __| |/ _ \| `_ \
|__   _| \__ \ | | | | | | |_| | | (_| | |_| | (_) | | | |
   |_|   |___/_|_| |_| |_|\__,_|_|\__,_|\__|_|\___/|_| |_|

https://communities.sas.com/t5/user/viewprofilepage/user-id/32733 \

*/

%let nsim=10000; /* number of simulated studies */
%let n=2016;     /* sample size per group */
%let p1=0.97;    /* success probability in group 1 */
%let p2=0.95;    /* success probability in group 2 */

/* Simulate the results of &NSIM studies */

data sim;
call streaminit(31415927);
do i=1 to &nsim;
  do grp=1, 2;
    success=1;
    k=rand('binom', choosen(grp, &p1, &p2), &n);
    output;
    success=0;
    k=&n-k;
    output;
  end;
end;
run;

/* Perform Pearson chi-square test for each study */

ods select none;
ods noresults;
ods output chisq=csq(where=(statistic='Chi-Square'));
proc freq data=sim;
by i;
weight k;
tables grp*success / chisq;
run;
ods select all;
ods results;

/* Determine the proportion of studies with a significant test result
   (i.e., showing a significant difference between the success rates)
*/

proc format;
value pvtwo
low-0.05='significant'
0.05<-high='not significant';
run;

ods exclude binomialtest;
proc freq data=csq;
format prob pvtwo.;
tables prob / binomial;
run;
ods exclude none;

/**************************************************************************************************************************/
/* Result: Point estimate of the power: 0.9040 (exact 95%-CI: 0.8981, 0.9097).                                            */
/*                                                                                                                        */
/*                                                                                                                        */
/*                                             Cumulative    Cumulative                                                   */
/*            PROB    Frequency     Percent     Frequency      Percent                                                    */
/* --------------------------------------------------------------------                                                   */
/* significant            9040       90.40          9040        90.40                                                     */
/* not significant         960        9.60         10000       100.00                                                     */
/*                                                                                                                        */
/*                                                                                                                        */
/*       Binomial Proportion                                                                                              */
/*        PROB = significant                                                                                              */
/*                                                                                                                        */
/* Proportion                0.9040                                                                                       */
/* ASE                       0.0029                                                                                       */
/* 95% Lower Conf Limit      0.8982                                                                                       */
/* 95% Upper Conf Limit      0.9098                                                                                       */
/*                                                                                                                        */
/* Exact Conf Limits                                                                                                      */
/* 95% Lower Conf Limit      0.8981                                                                                       */
/* 95% Upper Conf Limit      0.9097                                                                                       */
/*                                                                                                                        */
/*   Test of H0: Proportion = 0.5                                                                                         */
/*                                                                                                                        */
/* ASE under H0              0.0050                                                                                       */
/* Z                        80.8000                                                                                       */
/* One-sided Pr >  Z         <.0001                                                                                       */
/* Two-sided Pr > |Z|        <.0001                                                                                       */
/**************************************************************************************************************************/

/*___                             _            _           _
| ___|  ___  __ _ _ __ ___  _ __ | | ___   ___(_)_______  | |__  _   _  _ __   _____      _____ _ __
|___ \ / __|/ _` | `_ ` _ \| `_ \| |/ _ \ / __| |_  / _ \ | `_ \| | | || `_ \ / _ \ \ /\ / / _ \ `__|
 ___) |\__ \ (_| | | | | | | |_) | |  __/ \__ \ |/ /  __/ | |_) | |_| || |_) | (_) \ V  V /  __/ |
|____/ |___/\__,_|_| |_| |_| .__/|_|\___| |___/_/___\___| |_.__/ \__, || .__/ \___/ \_/\_/ \___|_|
                           |_|                                   |___/ |_|
*/

data have;

  p1 = .97;
  p2 = .95;

  pavg = (p1 + p2)/2;

  do pwr=0.80 to 0.90 by .01;

     sample = ceil(( probit(.975) * sqrt(2 * pavg * (1 - pavg)) + probit(pwr) * sqrt (p1*(1 - p1) + p2*(1 - p2)))**2 /(p2-p1)**2);
     output;
  end; ;

run;quit;

ods listing;
options ls=64 ps=44;;
proc plot data=have;
  plot sample*pwr= '*' $ sample/box;

run;quit;

/**************************************************************************************************************************/
/*                      Sample Sizes by Power                                                                             */
/*                                                                                                                        */
/*                                POWER                                                                                   */
/*          0.80 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.90                                                        */
/*        ---+----+----+----+----+----+----+----+----+----+----+---                                                       */
/* SAMPLE |                                                       |                                                       */
/*        | Equivalence Trial                                     |                                                       */
/*        |                                                       |                                                       */
/*        | H0: |P1-p2| => 2%                                     |                                                       */
/*        | H1: |p1-p2} <  2%                                     |                                                       */
/*        |                                                       |                                                       */
/*        | Per Group sample size =                             2   |                                                     */
/*        | /       __________________            ____________ \  |                                                       */
/*        | \z975*\/p1*(1-p1)+p2*(1-p2)+\/2*z90*\/pavg*(1-pavg)/  |                                                       */
/*        | ----------------------------------------------------- | Per                                                   */
/*        |                                  2                    | Group                                                 */
/*        |                         (p1 - p2)                     | Sample                                                */
/*        |                                                       | Size                                                  */
/*        |  Number of Sides                  2                   |                                                       */
/*   2100 +  Alpha z95                     0.05                   + 2100                                                  */
/*        |  Group 1 Proportion P1         0.97                   |                                                       */
/*        |  Group 2 Proportion P2         0.95                   |                                                       */
/*        |  Power Range z## Beta          0.80-0.90              |                                                       */
/*        |  Null Proportion Difference       0           2016 *  |                                                       */
/*   2000 +  Pooled Proportion (p1 + p2)/2 0.96                   + 2000                                                  */
/*        |                                                       |                                                       */
/*        |                 ___________________                   |                                                       */
/*        | H0 variance \/2 * pavg*(1 - pavg)            * 1948   |                                                       */
/*        |                                                       |                                                       */
/*   1900 + H0 variance   ________________________                + 1900                                                  */
/*        | H1 variance \/ p1*(1 - p1)+p2*(1 - p2)  * 1886        |                                                       */
/*        |                                                       |                                                       */
/*        |                                                       |                                                       */
/*        |                                     * 1828            |                                                       */
/*   1800 +                                                       + 1800                                                  */
/*        |                                * 1774                 |                                                       */
/*        |                                                       |                                                       */
/*        |                                                       |                                                       */
/*        |                           * 1723                      |                                                       */
/*   1700 +                                                       + 1700                                                  */
/*        |                      * 1675                           |                                                       */
/*        |                                                       |                                                       */
/*        |                 * 1630                                |                                                       */
/*        |                                                       |                                                       */
/*   1600 +                                                       + 1600                                                  */
/*        |            * 1587                                     |                                                       */
/*        |                                                       |                                                       */
/*        |       * 1546                                          |                                                       */
/*        |                                                       |                                                       */
/*   1500 +  * 1506                                               + 1500                                                  */
/*        |                                                       |                                                       */
/*        ---+----+----+----+----+----+----+----+----+----+----+---                                                       */
/*         0.80 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.90                                                         */
/*                               POWER                                                                                    */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
