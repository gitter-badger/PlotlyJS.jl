module TestTraces

using Base.Test
include(joinpath(dirname(dirname(abspath(@__FILE__))), "src", "PlotlyJS.jl"))
typealias M PlotlyJS

gt = M.GenericTrace("scatter"; x=1:10, y=sin(1:10))
@test sort(collect(keys(gt.fields))) == [:x, :y]

# test setindex! methods
gt[:visible] = true
@test length(gt.fields) == 3
@test haskey(gt.fields, :visible)
@test gt.fields[:visible] == true

# now try with string. Make sure it updates inplace
gt["visible"] = false
@test length(gt.fields) == 3
@test haskey(gt.fields, :visible)
@test gt.fields[:visible] == false

# -------- #
# 2 levels #
# -------- #
gt[:line, :color] = "red"
@test length(gt.fields) == 4
@test haskey(gt.fields, :line)
@test isa(gt.fields[:line], Dict)
@test gt.fields[:line][:color] == "red"
@test gt["line.color"] == "red"

# now try string version
gt["line", "color"] = "blue"
@test length(gt.fields) == 4
@test haskey(gt.fields, :line)
@test isa(gt.fields[:line], Dict)
@test gt.fields[:line][:color] == "blue"
@test gt["line.color"] == "blue"

# now try convenience string dot notation
gt["line.color"] = "green"
@test length(gt.fields) == 4
@test haskey(gt.fields, :line)
@test isa(gt.fields[:line], Dict)
@test gt.fields[:line][:color] == "green"
@test gt["line.color"] == "green"

# now try symbol with underscore
gt[:(line_color)] = "orange"
@test length(gt.fields) == 4
@test haskey(gt.fields, :line)
@test isa(gt.fields[:line], Dict)
@test gt.fields[:line][:color] == "orange"
@test gt["line.color"] == "orange"

# now try string with underscore
gt["line_color"] = "magenta"
@test length(gt.fields) == 4
@test haskey(gt.fields, :line)
@test isa(gt.fields[:line], Dict)
@test gt.fields[:line][:color] == "magenta"
@test gt["line.color"] == "magenta"

# -------- #
# 3 levels #
# -------- #
gt[:marker, :line, :color] = "red"
@test length(gt.fields) == 5
@test haskey(gt.fields, :marker)
@test isa(gt.fields[:marker], Dict)
@test haskey(gt.fields[:marker], :line)
@test isa(gt.fields[:marker][:line], Dict)
@test haskey(gt.fields[:marker][:line], :color)
@test gt.fields[:marker][:line][:color] == "red"
@test gt["marker.line.color"] == "red"

# now try string version
gt["marker", "line", "color"] = "blue"
@test length(gt.fields) == 5
@test haskey(gt.fields, :marker)
@test isa(gt.fields[:marker], Dict)
@test haskey(gt.fields[:marker], :line)
@test isa(gt.fields[:marker][:line], Dict)
@test haskey(gt.fields[:marker][:line], :color)
@test gt.fields[:marker][:line][:color] == "blue"
@test gt["marker.line.color"] == "blue"

# now try convenience string dot notation
gt["marker.line.color"] = "green"
@test length(gt.fields) == 5
@test haskey(gt.fields, :marker)
@test isa(gt.fields[:marker], Dict)
@test haskey(gt.fields[:marker], :line)
@test isa(gt.fields[:marker][:line], Dict)
@test haskey(gt.fields[:marker][:line], :color)
@test gt.fields[:marker][:line][:color] == "green"
@test gt["marker.line.color"] == "green"

# now string with underscore notation
gt["marker_line_color"] = "orange"
@test length(gt.fields) == 5
@test haskey(gt.fields, :marker)
@test isa(gt.fields[:marker], Dict)
@test haskey(gt.fields[:marker], :line)
@test isa(gt.fields[:marker][:line], Dict)
@test haskey(gt.fields[:marker][:line], :color)
@test gt.fields[:marker][:line][:color] == "orange"
@test gt["marker.line.color"] == "orange"

# now symbol with underscore notation
gt[:(marker_line_color)] = "magenta"
@test length(gt.fields) == 5
@test haskey(gt.fields, :marker)
@test isa(gt.fields[:marker], Dict)
@test haskey(gt.fields[:marker], :line)
@test isa(gt.fields[:marker][:line], Dict)
@test haskey(gt.fields[:marker][:line], :color)
@test gt.fields[:marker][:line][:color] == "magenta"
@test gt["marker.line.color"] == "magenta"

# -------- #
# 4 levels #
# -------- #
gt[:marker, :colorbar, :tickfont, :family] = "Hasklig-ExtraLight"
@test length(gt.fields) == 5  # notice we didn't add another top level key
@test haskey(gt.fields, :marker)
@test isa(gt.fields[:marker], Dict)
@test length(gt.fields[:marker]) == 2  # but we did add a key at this level
@test haskey(gt.fields[:marker], :colorbar)
@test isa(gt.fields[:marker][:colorbar], Dict)
@test haskey(gt.fields[:marker][:colorbar], :tickfont)
@test isa(gt.fields[:marker][:colorbar][:tickfont], Dict)
@test haskey(gt.fields[:marker][:colorbar][:tickfont], :family)
@test gt.fields[:marker][:colorbar][:tickfont][:family] == "Hasklig-ExtraLight"
@test gt["marker.colorbar.tickfont.family"] == "Hasklig-ExtraLight"

# now try string version
gt["marker", "colorbar", "tickfont", "family"] = "Hasklig-Light"
@test length(gt.fields) == 5
@test haskey(gt.fields, :marker)
@test isa(gt.fields[:marker], Dict)
@test length(gt.fields[:marker]) == 2
@test haskey(gt.fields[:marker], :colorbar)
@test isa(gt.fields[:marker][:colorbar], Dict)
@test haskey(gt.fields[:marker][:colorbar], :tickfont)
@test isa(gt.fields[:marker][:colorbar][:tickfont], Dict)
@test haskey(gt.fields[:marker][:colorbar][:tickfont], :family)
@test gt.fields[:marker][:colorbar][:tickfont][:family] == "Hasklig-Light"
@test gt["marker.colorbar.tickfont.family"] == "Hasklig-Light"

# now try convenience string dot notation
gt["marker.colorbar.tickfont.family"] = "Hasklig-Medium"
@test length(gt.fields) == 5  # notice we didn't add another top level key
@test haskey(gt.fields, :marker)
@test isa(gt.fields[:marker], Dict)
@test length(gt.fields[:marker]) == 2  # but we did add a key at this level
@test haskey(gt.fields[:marker], :colorbar)
@test isa(gt.fields[:marker][:colorbar], Dict)
@test haskey(gt.fields[:marker][:colorbar], :tickfont)
@test isa(gt.fields[:marker][:colorbar][:tickfont], Dict)
@test haskey(gt.fields[:marker][:colorbar][:tickfont], :family)
@test gt.fields[:marker][:colorbar][:tickfont][:family] == "Hasklig-Medium"
@test gt["marker.colorbar.tickfont.family"] == "Hasklig-Medium"

# now string with underscore notation
gt["marker_colorbar_tickfont_family"] = "Webdings"
@test length(gt.fields) == 5  # notice we didn't add another top level key
@test haskey(gt.fields, :marker)
@test isa(gt.fields[:marker], Dict)
@test length(gt.fields[:marker]) == 2  # but we did add a key at this level
@test haskey(gt.fields[:marker], :colorbar)
@test isa(gt.fields[:marker][:colorbar], Dict)
@test haskey(gt.fields[:marker][:colorbar], :tickfont)
@test isa(gt.fields[:marker][:colorbar][:tickfont], Dict)
@test haskey(gt.fields[:marker][:colorbar][:tickfont], :family)
@test gt.fields[:marker][:colorbar][:tickfont][:family] == "Webdings"
@test gt["marker.colorbar.tickfont.family"] == "Webdings"

# now symbol with underscore notation
gt[:marker_colorbar_tickfont_family] = "Webdings42"
@test length(gt.fields) == 5  # notice we didn't add another top level key
@test haskey(gt.fields, :marker)
@test isa(gt.fields[:marker], Dict)
@test length(gt.fields[:marker]) == 2  # but we did add a key at this level
@test haskey(gt.fields[:marker], :colorbar)
@test isa(gt.fields[:marker][:colorbar], Dict)
@test haskey(gt.fields[:marker][:colorbar], :tickfont)
@test isa(gt.fields[:marker][:colorbar][:tickfont], Dict)
@test haskey(gt.fields[:marker][:colorbar][:tickfont], :family)
@test gt.fields[:marker][:colorbar][:tickfont][:family] == "Webdings42"
@test gt["marker.colorbar.tickfont.family"] == "Webdings42"


# now test underscore constructor and see if it matches gt
gt2 = M.scatter(;x=1:10, y=sin(1:10),
                 marker_colorbar_tickfont_family="Webdings42",
                 marker_line_color="magenta",
                 line_color="magenta",
                 visible=false)
@test sort(collect(keys(gt.fields))) == sort(collect(keys(gt2.fields)))
for k in keys(gt.fields)
    @test gt[k] == gt2[k]
end

# error on 5 levels
Test.@test_throws MethodError gt["marker.colorbar.tickfont.family.foo"] = :bar

end  # module
