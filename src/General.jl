module General

    export Series
    include("series/series.jl")
    # include("series/dict.jl")

    # export Layout
    include("Layout.jl")

    export Explore
    include("Explore.jl")

    export Aux
    include("Au.jl")

    # export Plot
    include("Plot/Plot.jl")

    export Reg
    include("Reg.jl")

end
