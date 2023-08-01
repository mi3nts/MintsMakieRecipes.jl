module MintsMakieRecipes


using CairoMakie
using RelocatableFolders


# font files from google fonts
const montserrat_path = @path normpath(joinpath(@__DIR__, "../assets", "font-files", "montserrat"))
@assert ispath(montserrat_path)


include("makie_defaults.jl")
export mints_colors, mints_font, mints_theme


include("basemap.jl")
export BaseMap, get_basemap

end
