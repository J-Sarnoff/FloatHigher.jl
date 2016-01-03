# FloatHigher.jl
accurate floating point math at extended precisions

```ruby
        Jeffrey A. Sarnoff                           2015-Dec-30 03:21:21 UTC America/New_York
                                                     2015-Dec-31 06:00:00 UTC (multityped ops)
```                    



*__+__*  
   Calculations are substantially faster than BigFloat.  
   Accuracy more consistently tracks displayed precision than BigFloat.  

*__-__*  
   Pulls in all of Nemo to use some of Arb.  
   Does not implement some math functions and other operators available with Float64.  
   
_★_  
   Fredrik Johannson has written 2015's best intermediate precision floating point math software. The right next step would be to study William Hart's Julia interface and make Arb's Real and Complex number support directly available in Julia. Matching missing operators and smoothly adding in his other math functions is straightforward.  Julia would loose BigFloat *issues* working at precisions up through 10,000 decimal digits,
and gain speed and provide more transparent accuracy when working with extended precision real/complex floats.  

###__∵__  
  This is as far as I am comfortable taking Julia's search for a first class Float128 implementation.  
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.. with the hope this will have helped ..

-----
=====

Digits30, Digits70, Digits140, aor Digits300 are selected before 'using' this module   
( or, in separate modules: DIGITS30.jl, DIGITS70.jl, DIGITS140.jl, DIGITS300.jl ).   
When none are explicitly selected, Digits30 is used.  


```julia
using FloatHigher
julia> a=Digits30(2);sqrt2=sqrt(a)
1.4142135623730950488016887242096980786
quit()

UseDigits70=true
using FloatHigher
julia> a=Digits70(2);sqrt2=sqrt(a)
1.414213562373095048801688724209698078569671875376948073176679737990732478462
quit()

UseDigits140=true
using FloatHigher
julia> a=Digits140(0.5);println(exp(a));a-log(exp(a))
1.648721270700128146848650787814163571653776100710148011575079311640661021194  
 2140244768312883565706777193388588425688402538063164289228771285341140760306  
0

UseDigits300=true
using FloatHigher
julia> asin(Digits300(0.5))*6
3.141592653589793238462643383279502884197169399375105820974944592307816406286  
 2089986280348253421170679821480865132823066470938446095505822317253594081284  
 8111745028410270193852110555964462294895493038196442881097566593344612847564  
 8233786783165271201909145648566923460348610454326648213393607260249141273725  
 

```

Digits30, Digits70, Digits140, Digits300 can be used together.  
Intertype promotion defers to the smaller type (otherwise the result could become quite inaccurate invisibly):

```julia
UseDigits70=true
UseDigits300=true
using FloatHigher

a=sqrt(Digits70(256))
16
b=sqrt(Digits300(1024))
32
c=a+b; c, typeof(c)
48, Digits70

```

-----
   

This relies *entirely* on Fredrik Johansson's Arb software, which is included with William Hart's Nemo package.  
The Arb documentation is at http://fredrikj.net/arb/.  The documentation for Nemo is at http://nemocas.org.  
You will see Nemo's welcome message.  _Nemo is required unless Arb is separately available to Julia._

