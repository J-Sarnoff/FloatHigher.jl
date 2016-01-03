module FloatHigher

import Base: convert, promote_rule, promote_type,
    hash, string, show, showcompact,
    (<),(<=),(==),(!=),(>=),(>),isless,isequal,
    zero,one,ldexp,floor,ceil,
    (+),(-),(*),(/),(%),(^),sqrt,hypot,
    exp,expm1,log,log1p,log2,log10,
    sin,cos,tan,cot,
    asin,acos,atan,acot,atan2,
    sinh,cosh,tanh,coth,
    asinh,acosh,atanh,acoth

import Nemo: ArbField, arb, 
    ball, midpoint, radius, trim,
    iszero, isnonzero, isone, isfinite, isexact, 
    isint, ispositive, isnonnegative, isnegative, isnonpositive,
    const_pi, const_e, const_log2, const_log10, const_euler, const_catalan,
    sincos, sinhcosh
    # floor, ceil, sqrt, hypot, atan2, sincos, sinhcosh

typealias Ball arb # types are capitalized in Julia
typealias SystemNum Union{Float64,Float32,Float16,Int128,Int64,Int32,Int16}


if isdefined(Main,:UseDigits30) || (!isdefined(Main,:UseDigits70) & !isdefined(Main,:UseDigits140) & !isdefined(Main,:UseDigits300))
export Digits30

immutable (Digits30) <: Real
   re::Ball
end
Real30 = ArbField(127)
convert{T<:SystemNum}(::Type{Digits30}, x::T) = (Digits30)(Real30(x))

TypeSym = :Digits30; RoundDigs=30; FmtStr="%0.30g"
include("type.jl")
end

if isdefined(Main,:UseDigits70) && Main.UseDigits70==true
export Digits70

immutable (Digits70) <: Real
   re::Ball
end
Real70 = ArbField(255)
convert{T<:SystemNum}(::Type{Digits70}, x::T) = (Digits70)(Real70(x))

TypeSym = :Digits70; RoundDigs=70; FmtStr="%0.70g"
include("type.jl")
end

if isdefined(Main,:UseDigits140) && Main.UseDigits140==true
export Digits140

immutable (Digits140) <: Real
   re::Ball
end
Real140 = ArbField(511)
convert{T<:SystemNum}(::Type{Digits140}, x::T) = (Float512)(Real140(x))

TypeSym = :Digits140; RoundDigs=140; FmtStr="%0.140g"
include("type.jl")
end

if isdefined(Main,:UseDigits300) && Main.UseDigits300==true
export Digits300

immutable (Digits300) <: Real
   re::Ball
end
Real300 = ArbField(1023)
convert{T<:SystemNum}(::Type{Digits300}, x::T) = (Digits300)(Real300(x))

TypeSym = :Digits300; RoundDigs=300; FmtStr="%0.300g"
include("type.jl")
end

# intertype promotion

if isdefined(:Float128)

if isdefined(:Float256)
  promote_rule(::Type{Float128}, ::Type{Float256}) = Float128
  convert(::Type{Float128}, x::Float256) = Float128(x.re)
elseif isdefined(:Float512)
  promote_rule(::Type{Float128}, ::Type{Float512}) = Float128
  convert(::Type{Float128}, x::Float512) = Float128(x.re)
elseif isdefined(:Float1024)
  promote_rule(::Type{Float128}, ::Type{Float1024}) = Float128
  convert(::Type{Float128}, x::Float1024) = Float128(x.re)
end

elseif isdefined(:Float256)

if isdefined(:Float512)
  promote_rule(::Type{Float256}, ::Type{Float512}) = Float256
  convert(::Type{Float256}, x::Float512) = Float256(x.re)
elseif isdefined(:Float1024)
  promote_rule(::Type{Float256}, ::Type{Float1024}) = Float256
  convert(::Type{Float256}, x::Float1024) = Float256(x.re)
end

elseif isdefined(:Float512)

if isdefined(:Float1024)
  promote_rule(::Type{Float512}, ::Type{Float1024}) = Float512
  convert(::Type{Float512}, x::Float1024) = Float512(x.re)
end

end # promotions

end # FloatHigher
