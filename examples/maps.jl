using PlotlyJS

function maps1(showme=true)
    marker = Dict(:size=>[20, 30, 15, 10],
                  :color=>[10, 20, 40, 50],
                  :cmin=>0,
                  :cmax=>50,
                  :colorscale=>"Greens",
                  :colorbar=>Dict(:title=>"Some rate",
                                 :ticksuffix=>"%",
                                 :showticksuffix=>"last"),
                  :line=>Dict(:color => "black"))
    trace = scattergeo(;mode="markers", locations=["FRA", "DEU", "RUS", "ESP"],
                        marker=marker, name="Europe Data")
    layout = Layout(geo_scope="europe", geo_resolution=50, width=500, height=550,
                    margin=Dict(:l=>0, :r=>0, :t=>10, :b=>0))
    p = Plot(trace, layout)
    showme && show(p)
    p
end

function maps2(showme=true)
    @eval using DataFrames

    # read Data into dataframe
    nm = tempname()
    url = "https://raw.githubusercontent.com/plotly/datasets/master/2014_us_cities.csv"
    download(url, nm)
    df = readtable(nm)
    rm(nm)

    trace = scattergeo(;locationmode="USA-states",
                        lat=df[:lat],
                        lon=df[:lon],
                        hoverinfo="text",
                        text=[string(x[:name], " pop: ", x[:pop]) for x in eachrow(df)],
                        marker_size=df[:pop]/50_000,
                        marker_line_color="black", marker_line_width=2)
    geo = Dict(:scope=>"usa",
               :projection => Dict(:type => "albers usa"),
               :showland => true,
               :landcolor => "rgb(217, 217, 217)",
               :subunitwidth => 1,
               :countrywidth => 1,
               :subunitcolor => "rgb(255,255,255)",
               :countrycolor => "rgb(255,255,255)")

    layout = Layout(;title="2014 US City Populations", showlegend=false, geo=geo)
    p = Plot(trace, layout)
    showme && show(p)
    p
end
