module Shapes

include("./math.jl")

include("./Linear.jl")

abstract type Shape{D} end
abstract type PrimitiveShape{D} <: Shape{D} end
abstract type ComplexShape{D} <: Shape{D} end

abstract type Space{D} end

Shape4D = Shape{4}
Shape3D = Shape{3}
Shape2D = Shape{2}

Space4D = Space{4}
Space3D = Space{3}
Space2D = Space{2}

export
    # Linear
    Linear, Line, LineSegment, Ray,
    # functions
    flip, distance², distance, normalize,
    iscollinear, isparallel, isdegenerate

end
