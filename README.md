# MintsMakieRecipes

[![Build Status](https://github.com/mi3nts/MintsMakieRecipes.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/mi3nts/MintsMakieRecipes.jl/actions/workflows/CI.yml?query=branch%3Amain)


This package is a collection of Makie plotting recipes, themes, and configurations for generating publication-ready figures for the MINTS research group. 

# Installation
Install the package via 
```julia
pkg.add("MintsMakieRecipes")
```
or in the repl. 

# Setting the Makie Theme
To make Makie use the MINTS group theme, first import the module with 
```julia
using MintsMakieRecipes
```
and then call 
```julia
set_theme!(mints_theme)
```
This will configure a variety of settings including fonts, font-sizes, default color cycles, color maps, etc...

![MINTS plotting recipe](./assets/demo.pdf)

# Plot Recipes
Coming soon! 
## Plotting Recipes for Supervised Regression
- Customized scatter diagrams with marginal PDFs
- Customize Quantile-Quantile plots

