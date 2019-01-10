
type Point{T}
    x::T
    y::T
    
end

#can't be applied to arguments of type Point{Float64}

function mynorm(p::Point{Real})
    sqrt(p.x^2+p.y^2)
    
end

function mynorm2{T<:Real}(p::Point{T})
    sqrt(p.x^2+p.y^2)
end

##运行如下：
#flm=Point{Float64}(3,4)
#mynorm2(flm) ->5.0
# mynorm(flm) ->error


