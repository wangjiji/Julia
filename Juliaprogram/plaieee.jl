###for plasma frequency  确定的入射波频率 data without 2pi
import PyPlot

function oneieeecol!(wp::Float64,ret::AbstractVector{Float64},i::Int64;d::Float64=0.05,fre::Float64=2.0e9,wb::Float64=0.0)

 
    w = 2pi*fre
    cc = 299792458
    wp = 2pi*wp
    
    ven = 2pi*1e9                ##plasma collision frequency init

    venx = [0.1:0.02:2.5;2.52:0.02:10;10.02:0.05:50;50.5:0.5:200;201:2:500;
            502:5:1000;1010:10:2000;2010:20:5000;5020:50:10000]    ##1e8-1e13Hz
    #wpx=linspace(1,100,5000)

    venlen = length(venx)

    er = ones(venlen)

    ww = w-wb
    ve=venx*ven

    er = 1-(ww-1im*ve)*(wp*wp)./(w*(ww*ww+ve.*ve))

    r0 = tanh(w*1im.*sqrt(er)*d/cc)./sqrt(er)
    r1 = (r0+1)./(r0-1)

    A1 = 10*log10(abs2(r1))

    veinx = findfirst(A1,minimum(A1))
    ret[i] = minimum(A1)

    getve=1e9*venx[veinx]                 ##Hz

    return  getve
    
    
end

##different plasma frequency
function pladiff(;fre::Float64=2.0e9,d::Float64=0.05)

    
    # venx = [0.01:0.01:0.5;0.55:0.05:2.5;2.8:0.3:10;10:0.5:20;
    # 21:1:50;52:2:100;105:10:500;520:20:1000;1100:200:10000]*ven           ##2e7-2e13Hz

    # wp0 = linspace(9,11,10000)
    # wpe = 10.^wp0
    wpe = 1e9*linspace(0.1,30,5000)

    wplen = length(wpe)
    νₑ=ones(wplen)
    ret = ones(wplen)
    for xx =1:wplen

        νₑ[xx]=oneieeecol!(wpe[xx],ret,xx;fre=fre,d=d)

    end

    # print(ωₚ[1:10:end],"\n",ret[1:10:end])

    # PyPlot.plot(venx0,sqrt(10.^(ret/10)))#venx,ωₚ)

    PyPlot.plot(wpe/1e9,ret)#wpe/1e9,νₑ)

    f = open("Datapla$(fre/1e9)G.csv","w")

    write(f,"wp(GHz)\tve(GHz)\tA1(dB)\n")

    for i = 1:wplen
        write(f,"$(wpe[i]/1e9)\t$(νₑ[i]/1e9)\t$(ret[i])\n")
        
    end
    close(f)



    
end


###write file


