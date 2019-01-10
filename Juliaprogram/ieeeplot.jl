import PyPlot
function ieeeplot(wp::Float64,ven::Float64,d::Float64,freq=[2e9,40e9])
    f = linspace(freq[1],freq[2],500)
    w = 2*pi*f
    wpe = wp
    ve = ven
    er = 1-(wpe^2./(w.^2+ve^2))+im*((wpe^2*ve)./(w.^3+w.*ve^2))
    d1 =d
    cc = 299792458
    t1 = tanh(2*pi*im*f.*sqrt(er).*d1/cc)./sqrt(er)
    r1 = (t1+1)./(t1-1)
    A1 = 10*log10(r1.*conj(r1))
    

    PyPlot.plot(f/1e9,real(A1))
    # return f/1e9,real(A1)



    fil = open("Datawp=$(round(wp/(1e9*2*pi),6))ven=$(round(ven/(1e9*2*pi),6))d=$(d).csv","w")

    write(fil,"fre(GHz)\tA1(dB)\n")

    for i = 1:500
        write(fil,"$(f[i]/1e9)\t$(real(A1[i]))\n")
        
    end
    close(fil)


end
