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
