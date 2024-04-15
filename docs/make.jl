using General
using Documenter

DocMeta.setdocmeta!(General, :DocTestSetup, :(using General); recursive=true)

makedocs(;
    modules=[General],
    authors="wang890 <wisecash@126.com> and contributors",
    sitename="General.jl",
    format=Documenter.HTML(;
        canonical="https://wang890.github.io/General.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/wang890/General.jl",
    devbranch="master",
)
