using Pkg
Pkg.add("Plots")
Pkg.add("DifferentialEquations")
Pkg.add("EzXML")
Pkg.add("CSV")
Pkg.add("DataFrames")
Pkg.add(url="https://github.com/JuliaReliab/LookupTable.jl.git")
Pkg.add(url="https://github.com/JuliaMBD/JuliaMBD.jl.git")

## download latest block library
download("https://raw.githubusercontent.com/JuliaMBD/JuliaMBD.jl/main/xml/JuliaMBD.xml", "JuliaMBD.xml")
