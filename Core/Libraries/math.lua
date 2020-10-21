return {
    clamp = function(val,min,max)
        assert(val and lower and upper, "Missing or nil parameter.")
        if lower > upper then lower, upper = upper, lower end -- swap if boundaries supplied the wrong way
        return math.max(lower, math.min(upper, val))
    end
}