function myfactorial(n::Int)
    n >= 0 || error("n must be non-negative")
    n==0 && return 1
    n * factorial(n-1)
end
