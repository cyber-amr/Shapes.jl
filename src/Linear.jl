#
# Linear{D,T}
# ├── Line{D,T}
# ├── LineSegment{D,T}
# └── Ray{D,T}
#

abstract type Linear{D,T<:Number} end

struct Line{D,T<:Number} <: Linear{D,T}
    a::NTuple{D,T}
    b::NTuple{D,T}
end
Line(::Tuple{}, ::Tuple{}) = Line{0,Union{}}((), ())
function Line(p1::NTuple{D,Number}, p2::NTuple{D,Number}) where {D}
    T = promote_type(eltype(p1), eltype(p2))
    Line{D,T}(convert(NTuple{D,T}, p1), convert(NTuple{D,T}, p2))
end

struct LineSegment{D,T<:Number} <: Linear{D,T}
    a::NTuple{D,T}
    b::NTuple{D,T}
end
LineSegment(::Tuple{}, ::Tuple{}) = LineSegment{0,Union{}}((), ())
function LineSegment(p1::NTuple{D,Number}, p2::NTuple{D,Number}) where {D}
    T = promote_type(eltype(p1), eltype(p2))
    LineSegment{D,T}(convert(NTuple{D,T}, p1), convert(NTuple{D,T}, p2))
end

struct Ray{D,T<:Number} <: Linear{D,T}
    a::NTuple{D,T}
    b::NTuple{D,T}
end
Ray(::Tuple{}, ::Tuple{}) = Ray{0,Union{}}((), ())
function Ray(p1::NTuple{D,Number}, p2::NTuple{D,Number}) where {D}
    T = promote_type(eltype(p1), eltype(p2))
    Ray{D,T}(convert(NTuple{D,T}, p1), convert(NTuple{D,T}, p2))
end

# overloads

Base.show(io::IO, l::Line) = print(io, "<$(l.a)↔$(l.b)>")
Base.show(io::IO, l::LineSegment) = print(io, "<$(l.a)―$(l.b)>")
Base.show(io::IO, l::Ray) = print(io, "<$(l.a)→$(l.b)>")

Base.getindex(l::Linear, i::Int) = getfield(l, i)
Base.length(::Linear) = 2

Base.iterate(l::Linear, i=1) = i > 2 ? nothing : (getfield(l, i), i + 1)
Base.lastindex(::Linear) = 2
Base.last(l::Linear) = l.b

# convert(Type{Linear}, Linear)

Base.convert(::Type{Line}, l::Linear) = Line(l.a, l.b)
Base.convert(::Type{Line{D,T}}, l::Linear{D}) where {D,T<:Number} = Line{D,T}(l.a, l.b)
Base.convert(::Type{Line{D,T}}, l::Line{D,T}) where {D,T<:Number} = l
Base.convert(::Type{LineSegment}, l::Linear) = LineSegment(l.a, l.b)
Base.convert(::Type{LineSegment{D,T}}, l::Linear{D}) where {D,T<:Number} = LineSegment{D,T}(l.a, l.b)
Base.convert(::Type{LineSegment{D,T}}, l::LineSegment{D,T}) where {D,T<:Number} = l
Base.convert(::Type{Ray}, l::Linear) = Ray(l.a, l.b)
Base.convert(::Type{Ray{D,T}}, l::Linear{D}) where {D,T<:Number} = Ray{D,T}(l.a, l.b)
Base.convert(::Type{Ray{D,T}}, l::Ray{D,T}) where {D,T<:Number} = l

# in(Point, Linear) - alias `Point ∈ Linear` and `Point ∉ Linear`

function Base.in(point::NTuple{D,Number}, l::Line{D}) where {D}
    v = l.b .- l.a
    t = div_no_inf(dot(point .- l.a, v), dot(v, v))
    lerp.(l.a, l.b, t) == point
end
Base.in(point::NTuple{3,Number}, l::Line{3}) = isdegenerate(l) ? point == l.a : all(iszero, cross(point .- l.a, l.b .- l.a))
Base.in(point::NTuple{2,Number}, l::Line{2}) = isdegenerate(l) ? point == l.a : iszero(det(l.a, point, l.b))
Base.in(point::Tuple{Number}, l::Line{1}) = !isdegenerate(l) || point == l.a
Base.in(::Tuple{}, ::Line{0}) = true
function Base.in(point::NTuple{D,Number}, s::LineSegment{D}) where {D}
    v = s.b .- s.a
    t = div_no_inf(dot(point .- s.a, v), dot(v, v))
    0 <= t <= 1 && lerp.(s.a, s.b, t) == point
end
Base.in(point::NTuple{1,Number}, l::LineSegment{1}) = isdegenerate(l) ? point == l.a : 0 <= (point[1] - l.a[1]) / (l.b[1] - l.a[1]) <= 1
Base.in(::Tuple{}, ::LineSegment{0}) = true
function Base.in(point::NTuple{D,Number}, r::Ray{D}) where {D}
    v = r.b .- r.a
    t = div_no_inf(dot(point .- r.a, v), dot(v, v))
    t >= 0 && lerp.(r.a, r.b, t) == point
end
Base.in(point::NTuple{1,Number}, l::Ray{1}) = isdegenerate(l) ? point == l.a : 0 <= (point[1] - l.a[1]) / (l.b[1] - l.a[1])
Base.in(::Tuple{}, ::Ray{0}) = true

# `Linear == Linear`

Base.:(==)(::Linear, ::Linear) = false # diff types of Linear or diff dimensions are never equal
Base.:(==)(a::Line{D}, b::Line{D}) where {D} = isdegenerate(a) ? isdegenerate(b) : !isdegenerate(b) && iscollinear(a, b) # Two lines are equal if they collinear
function Base.:(==)(a::LineSegment{D}, b::LineSegment{D}) where {D}
    (a.a == b.a && a.b == b.b) || (a.a == b.b && a.b == b.a)
end # Two segments are equal if they share the same endpoints
function Base.:(==)(a::Ray{D}, b::Ray{D}) where {D}
    a.a == b.a && begin
        va, vb = a.b .- a.a, b.b .- b.a
        iscollinear(va, vb) && dot(va, vb) >= 0
    end
end # Two rays are equal if they share the same origin (a) and the same direction

# flip(Linear)

flip(l::L) where {L<:Linear} = L(l.b, l.a)

# distance(Linear)

distance(::Line) = Inf
distance(::Line{0}) = 0

distance(l::LineSegment) = distance(l.a, l.b)
distance(::LineSegment{0}) = 0

distance(::Ray) = Inf
distance(::Ray{0}) = 0

# isdegenerate(Linear)

isdegenerate(l::Linear) = l.a == l.b

# isparallel(Linear, Linear)

isparallel(a::Linear{D}, b::Linear{D}) where {D} = iscollinear(a.b .- a.a, b.b .- b.a)
isparallel(::Linear{1}, ::Linear{1}) = true
isparallel(::Linear{0}, ::Linear{0}) = true

# iscollinear(Linear, Linear)

iscollinear(a::Linear{D}, b::Linear{D}) where {D} = iscollinear(a[1], a[2], b[1]) && iscollinear(a[2], b[1], b[2])
iscollinear(::Linear{1}, ::Linear{1}) = true
iscollinear(::Linear{0}, ::Linear{0}) = true
