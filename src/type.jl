for F in (TypeSym,)
@eval begin

@inline convert(::Type{Ball}, x::($F)) = x.re
@inline convert(::Type{$F}, x::Ball) = ($F)(x)
@inline convert{T<:SystemNum}(::Type{T}, x::($F)) = (T)(x.re)

($F){T<:SystemNum}(x::T) = convert($F,x)

@inline isfinite{T<:($F)}(x::T) = (isfinite(x.re))
@inline isnan{T<:($F)}(x::T)    = (isnan(x.re))
@inline isint{T<:($F)}(x::T)    = (isint(x.re))
@inline isexact{T<:($F)}(x::T)  = (isexact(x.re))
@inline isone{T<:($F)}(x::T)    = (isone(x.re))
@inline iszero{T<:($F)}(x::T)   = (iszero(x.re))
@inline isnonzero{T<:($F)}(x::T)     = (isnonzero(x.re))
@inline isnegative{T<:($F)}(x::T)    = (isnegative(x.re))
@inline isnonnegative{T<:($F)}(x::T) = (isnonnegative(x.re))
@inline ispositive{T<:($F)}(x::T)    = (ispositive(x.re))
@inline isnonpositive{T<:($F)}(x::T) = (isnonpositive(x.re))

radius{T<:($F)}(x::T) = (radius(x.re))
midpoint{T<:($F)}(x::T) = (midpoint(x.re))


zero{T<:($F)}(::Type{T}) = convert(T, 0.0)
one{T<:($F)}(::Type{T}) = convert(T, 1.0)

function (-){T<:($F)}(a::T)
    re = (-)(a.re)
    convert(($F),re)
end

function sqrt{T<:($F)}(a::T)
    re = sqrt(a.re)
    convert(($F),re)
end

end # @eval
end # $F

for F in (TypeSym,)
for (op) in (:(<),:(<=),:(==),:(!=),:(>=),:(>))
    @eval ($op){T<:($F)}(a::T, b::T) = ($op)(a.re, b.re)
end 
end

for F in (TypeSym,)
for (op) in (:+,:-,:*,:hypot)
  @eval begin
  
      function ($op){T<:($F)}(a::T, b::T)
           re = ($op)(a.re, b.re)
           convert(($F),re)
      end
      ($op){F<:($F),T<:SystemNum}(a::F, b::T) = ($op)(a,convert(($F),b))
      ($op){F<:($F),T<:SystemNum}(a::T, b::F) = ($op)(convert(($F),a),b)

   end   
end # $op
end # $F

for F in (TypeSym,)
@eval begin

      function (/){T<:($F)}(a::T, b::T)
          re = (//)(a.re,b.re)
          convert(($F),re)
      end
      (/){F<:($F),T<:SystemNum}(a::F, b::T) = (/)(a,convert(($F),b))
      (/){F<:($F),T<:SystemNum}(a::T, b::F) = (/)(convert(($F),a),b)
      
end # @eval
end # $F

for F in (TypeSym,)
for op in (:exp,:expm1,:log,:log1p,:log2,:log10,
           :sin,:cos,:tan,:cot,
           :asin,:acos,:atan,:acot,
           :sinh,:cosh,:tanh,:coth,
           :asinh,:acosh,:atanh,:acoth)
   @eval begin

        function ($op){T<:($F)}(x::T)
            re = ($op)(x.re)
            convert(($F),re)
        end
        ($op){T<:($F)}(x::T) = convert(($F),($op)(x.re))
   end
end # $op
end # $F

for (F,Digs,Fmt) in ((TypeSym,RoundDigs,:FmtStr),)
@eval begin

function show(io::IO, x::($F))
    r = split(split(string(midpoint(x.re)),"[")[end]," ")[1]
    b = round(parse(BigFloat,r),($RoundDigs))
    s = @sprintf(($FmtStr),b)
    s = strip(s)
    print(io,s)
end

function showball(io::IO, x::($F))
    print(io,string(x.re))
end

function showball(x::($F))
    showball(STDOUT, x)
end    

end # @eval
end # $F $Digs $Fmt
