using Shapes
using Documenter

DocMeta.setdocmeta!(Shapes, :DocTestSetup, :(using Shapes); recursive=true)

makedocs(;
    modules=[Shapes],
    authors="Amr <amr@programmer.net>",
    sitename="Shapes.jl",
    format=Documenter.HTML(;
        canonical="https://cyber-amr.github.io/Shapes.jl",
        edit_link="main",
        assets=["assets/favicon.ico"],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/cyber-amr/Shapes.jl",
    devbranch="main",
)
