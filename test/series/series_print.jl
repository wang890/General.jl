using General.Series

include("series_print_vars/series_print_vars1.jl")

file = joinpath(@__DIR__, "series_print_dict.txt")

file = joinpath(@__DIR__, "series_print_vector.txt")
s = s[:components]

Series.print(s; width = 100, file=file)

a = 1
