<!-- Markdown link & img dfn's -->
[license]: LICENSE

# NShapes.jl
> Simplify your geometry-related tasks with this versatile Julia package. providing tools for defining shapes of N-dimension and performing essential calculations in real-time.

<div align="center">
  <br />
  <p>
    <a target="_blank" href="https://julialang.org/"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Julia_Programming_Language_Logo.svg/320px-Julia_Programming_Language_Logo.svg.png" alt="Julia Programming Language Logo" /></a>
  </p>
  <p>
    <a target="_blank" href="https://github.com/cyber-amr/NShapes.jl/actions/workflows/CI.yml?query=branch%3Amain"><img src="https://github.com/cyber-amr/NShapes.jl/actions/workflows/CI.yml/badge.svg?branch=main" alt="Build Status" /></a>
    <a target="_blank" href="https://JuliaCI.github.io/NanosoldierReports/pkgeval_badges/N/NShapes.html"><img src="https://JuliaCI.github.io/NanosoldierReports/pkgeval_badges/N/NShapes.svg" alt="PkgEval" /></a>
    <a target="_blank" href="https://github.com/JuliaTesting/Aqua.jl"><img src="https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg" alt="Aqua" /></a>
  </p>
  <p>
    <a target="_blank" href="https://cyber-amr.github.io/NShapes.jl/stable/"><img src="https://img.shields.io/badge/docs-stable-blue.svg" alt="Stable" /></a>
    <a target="_blank" href="https://cyber-amr.github.io/NShapes.jl/dev/"><img src="https://img.shields.io/badge/docs-dev-blue.svg" alt="Dev" /></a>
  </p>
  <p>Geometric calculations and shape drawing in Julia</p>
  <br />
</div>


> [!IMPORTANT]
> This package prioritizes **simplicity**, **ease of use**, and real-time **performance**. There may be a trade-off in terms of precision in certain geometric calculations. For use cases requiring high-precision results (e.g., scientific simulations, engineering), it's recommended to use specialized, precision-focused geometry packages.

## Installation
```julia
using Pkg; Pkg.add(url="https://github.com/cyber-amr/NShapes.jl")
```

## License
All code licensed under the [MIT license][license].

## structs:
```
AbstractTransformation{D}
├── Transformation{D}
├── Translation{D}
├── Rotation{D}
└── Scaling{D}

Linear{D,T}
├── Line{D,T}
├── LineSegment{D,T}
└── Ray{D,T}

Shape{D}
├── PrimitiveShape{D}
│   ├── NSphere{D}
│   └── Polytope{D}
│       ├── ArbitraryPolytope{D} - a raw vertices type for exporting purposes
│       ├── ConvexPolytope{D, S} - S = number of sides
│       └── ConcavePolytope{D, S} - S = number of sides
└── ComplexShape{D}
    ├── BendedShape{D}
    ├── TwistedShape{D}
    ├── AbstractExtrudedShape{D, Linear|Shape}
    │   ├── ExtrudedShape{D, Linear|Shape} - Can represent Cylinder and Prism like shapes
    │   └── TaperExtrudedShape{D, Linear|Shape} - type of ExtrudedShape but for Cone and Pyramid like shapes
    └── CompositeShape{D, Shape, Shape}
        ├── UnionShape{D, Shape, Shape}
        ├── IntersectShape{D, Shape, Shape}
        ├── SubtractShape{D, Shape, Shape}
        └── DifferenceShape{D, Shape, Shape}

Space{D}
├── InfiniteSpace{D}
└── ShapedSpace{D, Linear{D}|Shape{D}}
```

## operations:
```
Boolean
├── union(Linear|Shape, Linear|Shape) - alias `∪`
├── intersect(Linear|Shape, Linear|Shape) - alias `∩`
├── subtract(Linear|Shape, Linear|Shape)
└── difference(Linear|Shape, Linear|Shape)

Transformations
├── translate(Linear|Shape, Translation)
├── rotate(Linear|Shape, Rotation)
├── scale(Linear|Shape, Scaling)
├── extrude(Linear|Shape, Vector, [Taper])
├── bend(Linear|Shape, Vector)
├── twist(Linear|Shape, Vector)
├── reflect(Linear|Shape, Shape)
└── shear(Linear|Shape, Shape)

Mesurements
├── volume(Shape)
├── surface(Shape)
├── area(Shape{2})
├── perimeter(Shape{2})
├── distance(Linear) - Euclidean length
├── distance²(Point, Point)
├── distance(Point, Point)
└── normalize(Vector)

Queries
├── iscontaining(Linear|Shape, Linear|Shape)
├── isintersecting(Linear|Shape, Linear|Shape)
├── isoverlapping(Linear|Shape, Linear|Shape)
├── isdistant(Linear|Shape, Linear|Shape)
├── isdegenerate(Linear|Shape)
├── iscollinear(Linear, Linear)
├── iscollinear(Vector, Vector)
├── iscollinear(Point, Point, Point)
├── isparallel(Linear, Linear)
├── isconvex(Shape)
├── isregular(Shape)
├── isclockwise(Shape{2})
├── closestpoint(Linear|Shape, Vector)
├── projection(Linear|Shape, Vector)
├── centroid(Linear|Shape)
└── normal(Linear|Shape)

Bounding volumes
├── convexhull(Shape)
├── boundingbox(Shape)
└── boundingsphere(Linear|Shape)

Tessellation and Simplification
├── simplify(Shape, tolerance)
├── decompose(CompositeShape; recursive=false)
├── tessellate(Shape, resolution)
└── voxelize(Linear|Shape, resolution) - pixelize(Shape{2}, resolution)

Space
├── ShortestPath(Space, Point|Linear|Shape, Point|Linear|Shape)
├── collisions(Space)
├── isvisible(Space, Point|Linear|Shape, Point|Linear|Shape)
└── visibilitygraph(Space)
```
