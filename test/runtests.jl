using MintsMakieRecipes
using Test
using Makie



@testset "src/makie_defaults.jl" begin
    set_theme!(mints_theme)
    # verify that the settings are correct for a few of them
    @test theme(:fontsize).val == 17
    @test theme(:colormap).val == :viridis
end
