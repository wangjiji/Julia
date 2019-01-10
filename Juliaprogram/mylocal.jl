###group 1
function mylocal(n)
    x = 0
    for i = 1:n
        x = x +i
    end
    x
end

function mylocal2(n)
    x = 0
    for i = 1:n
        local x
        x = i
    end
    x
end


###group2

x,y=1,2     #x0


function myscope()
    x = 2           #x1
    function bar()
        x = 10      #改变了x1的值
        return x+y  #10+2
    end
    return bar() + x    #12 +10
end


function bar2()
    x = 10      #x1
    return x+y  #12
end

function myscope2()
    x = 2       #x2
    return bar2() + x  #12+2
    
end


