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


if isdefined(Main,:UseFloat128) || (!isdefined(Main,:UseFloat256) & !isdefined(Main,:UseFloat512) & !isdefined(Main,:UseFloat1024))
export Float128

immutable (Float128) <: Real
   re::Ball
end
Real128 = ArbField(157)
convert{T<:SystemNum}(::Type{Float128}, x::T) = (Float128)(Real128(x))

TypeSym = :Float128; RoundDigs=38; FmtStr="%0.38g"
include("type.jl")
end

if isdefined(Main,:UseFloat256) && Main.UseFloat256==true
export Float256

immutable (Float256) <: Real
   re::Ball
end
Real256 = ArbField(288)
convert{T<:SystemNum}(::Type{Float256}, x::T) = (Float256)(Real256(x))

TypeSym = :Float256; RoundDigs=76; FmtStr="%0.76g"
include("type.jl")
end

if isdefined(Main,:UseFloat512) && Main.UseFloat512==true
export Float512

immutable (Float512) <: Real
   re::Ball
end
Real512 = ArbField(544)
convert{T<:SystemNum}(::Type{Float512}, x::T) = (Float512)(Real512(x))

TypeSym = :Float512; RoundDigs=152; FmtStr="%0.152g"
include("type.jl")
end

if isdefined(Main,:UseFloat1024) && Main.UseFloat1024==true
export Float1024

immutable (Float1024) <: Real
   re::Ball
end
Real1024 = ArbField(1088)
convert{T<:SystemNum}(::Type{Float1024}, x::T) = (Float1024)(Real1024(x))

TypeSym = :Float1024; RoundDigs=304; FmtStr="%0.304g"
include("type.jl")
end

if isdefined(Main,:UseFloat

end # FloatHigher
