###for collision 

import PyPlot

function oneieeecol!(ven::Float64,ret::AbstractVector{Float64},i::Int64;d::Float64=0.05,fre::Float64=2.0e9,wb::Float64=0.0)

 
    w = 2pi*fre
    cc = 299792458
    ven = 2pi*ven
    
    wp = 2pi*2e9                ##plasma frequency

    wpx = [0.01:0.01:0.5;0.55:0.05:2.5;2.8:0.3:10;10:0.5:50;52:2:100]    ##2e7-2e11Hz
    wplen = length(wpx)

    er = ones(wplen)

    ww = w-wb
    wpe=wpx*wp

    er = 1-(ww-1im*ven)/(w*(ww*ww+ven*ven))*(wpe.*wpe)

    r0 = tanh(w*1im.*sqrt(er)*d/cc)./sqrt(er)
    r1 = (r0+1)./(r0-1)

    A1 = 10*log10(abs2(r1))

    wpinx = findfirst(A1,minimum(A1))
    ret[i] = minimum(A1)

    getwp=2e9*wpx[wpinx]                 ##Hz

    return  getwp
    
    
end

##different collision frequency
function coldiff()

    ven = 2e9
    # venx = [0.01:0.01:0.5;0.55:0.05:2.5;2.8:0.3:10;10:0.5:20;
    # 21:1:50;52:2:100;105:10:500;520:20:1000;1100:200:10000]*ven           ##2e7-2e13Hz

    venx0 = linspace(10,11,5000)
    venx = 10.^venx0

    velen = length(venx)
    ωₚ=ones(velen)
    ret = ones(velen)
    for xx =1:velen

        ωₚ[xx]=oneieeecol!(venx[xx],ret,xx)

    end

    # print(ωₚ[1:10:end],"\n",ret[1:10:end])
    PyPlot.plot(linspace(1e10,1e11,5000),ret)


    
end