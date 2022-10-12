# Cephes Math Library 

[cephes](https://netlib.org/cephes/)

### cmath
``` cpp
double floor(double x);
double ceil(double x);
double found(double x);

double ldexp ( double, int e);
double frexp(double x, int* e );

double log(double x) // log(1+x) = x - 0.5 x**2 + x**3 P(x)/Q(x)  ， 
// z = 2(x-1)/x+1),log(x) = z + z**3 P(z)/Q(z).  x<0.25, x>2
double exp(double x) // e**x = 1 + 2x P(x**2)/( Q(x**2) - P(x**2) )
pow(x,y) // x**y  =  exp( y log(x) )

sqrt // frexp,  x = 0.5*(x + w/x)
cbrt // frexp, polyval4
sin // x  +  x**3 P(x**2)  , 1  -  x**2 Q(x**2).
sincos
tan(x) //  x + x**3 P(x**2)/Q(x**2)
asin // x + x**3 P(x**2)/Q(x**2)
// asin(x) = pi/2 - 2 asin( sqrt( (1-x)/2 ) )
acosh(x) // sqrt(z) * P(z)/Q(z) z = x-1, is used.  Otherwise,
// acosh(x)  =  log( x + sqrt( (x-1)(x+1) ).
cosh(x) //  ( exp(x) + exp(-x) )/2.
asinh   // x + x**3 P(x)/Q(x).
// asinh(x) = log( x + sqrt(1 + x*x) ).
atanh(x) // arctan(x)  = x + x^3 P(x^2)/Q(x^2)
tanh(x) // x + x**3 P(x)/Q(x)

```


### ELLF
arithmetic - geometric mean algorithm

```
ellik.c        incomplete elliptic integral of the first kind
ellpe.c        complete elliptic integral of the second kind
ellpj.c        Jacobian Elliptic Functions
ellpk.c        complete elliptic integral of the first kind
polevl.c       evaluates polynomials
cmplx.c        complex arithmetic subroutine package
ellf.c         main program
```


``` cpp
double polevl(double x, double coef[], int N )
double p1evl(double x, double coef[], int N )



double ellpk(double x) // Complete elliptic integral of the first kind: polevl(x,P,10) - log(x) * polevl(x,Q,10)
double ellik(double phi, double m ) // Incomplete elliptic integral of the first kind

double ellpe(double x) // Complete elliptic integral of the second kind: P(x)  -  x log x Q(x)
double ellie(double phi, double m )  // Incomplete elliptic integral of the second kind

int ellpj(double u,double m, double * sn,double * cn,double * dn,double * ph )// Jacobian Elliptic Functions
```