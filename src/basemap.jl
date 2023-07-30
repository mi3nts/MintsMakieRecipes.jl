using TileProviders, MapTiles
using GeoInterface: Extent, extent
using FileIO



# esri_provider = Esri(:WorldImagery)
# TileProviders.list_providers()


# w= -97.717472
# n= 33.703572
# s= 33.700797
# e= -97.712413



struct BaseMap
    w
    e
    s
    n
    map
end


function calculate_zoom(w, s, e, n)
    # Calculate bounds of the bbox
    lon_length = abs(e-w)
    lat_length = abs(n-s)

    # Calculate the zoom
    zoom_lon = ceil(log2(360 * 2.0 / lon_length))
    zoom_lat = ceil(log2(360 * 2.0 / lat_length))
    zoom = min(zoom_lon, zoom_lat)
    return Int(zoom)
end


function get_basemap(w,e,s,n; provider=Esri(:WorldImagery))
    z = calculate_zoom(w,s,e,n)
    bbox = Extent(X=(w,e), Y=(s,n))

    # get grid of tiles for our bbox and zoom level
    tilegrid = TileGrid(bbox, z, MapTiles.wgs84)

    # build the urls
    urls = [geturl(provider, t.x, t.y, t.z) for t ∈ tilegrid]

    # download the tiles
    paths = Vector{String}(undef, length(tilegrid))
    Threads.@threads for i ∈ 1:length(urls)
        paths[i] = download(urls[i])
    end

    # load the tile images
    imgs = [load(p) for p ∈ paths]


    ncols, nrows = size(tilegrid.grid)
    Δrows, Δcols = size(imgs[1])


    imgout = Matrix{eltype(imgs[1])}(undef, nrows*Δrows, ncols*Δcols)

    k = 1
    for i ∈ 1:Δrows:nrows*Δrows, j∈1:Δcols:ncols*Δcols
        imgout[i:i+Δrows-1,j:j+Δcols-1] .= imgs[k]
        k+=1
    end

    # return basemap struct with result
    return BaseMap(w,e,s,n,rotr90(imgout))
end


# basemap = get_basemap(w,e,s,n)
# heatmap(basemap.w..basemap.e,basemap.s..basemap.n, basemap.map)

