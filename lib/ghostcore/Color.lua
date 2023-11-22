local Color = Object:extend()

function Color:constructor(r, g, b, a)
    a = a or 1
    self.r = r
    self.g = g
    self.b = b
    self.a = a
end

function Color.fromByteFormat(r, g, b, a)
    a = a or 1
    return Color(r / 255, g / 255, b / 255, a / 255)
end

function Color:unpack()
    return self.r, self.g, self.b, self.a
end

return Color