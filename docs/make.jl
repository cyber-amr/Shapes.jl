using NShapes
using Documenter

DocMeta.setdocmeta!(NShapes, :DocTestSetup, :(using NShapes); recursive=true)

makedocs(;
    modules=[NShapes],
    authors="Amr <amr@programmer.net>",
    sitename="NShapes.jl",
    format=Documenter.HTML(;
        canonical="https://cyber-amr.github.io/NShapes.jl",
        edit_link="main",
        assets=["assets/favicon.ico"],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/cyber-amr/NShapes.jl",
    devbranch="main",
)
