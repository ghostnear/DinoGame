local Sprite = Object:extend()

function Sprite.configTable_defaults(configTable)
    configTable["image"] = configTable["image"] or "default"
    configTable["position"] = configTable["position"] or Vector2(0, 0)
    configTable["scale"] = configTable["scale"] or Vector2(1, 1)
    configTable["offset"] = configTable["offset"] or Vector2(0, 0)
    configTable["rotation"] = configTable["rotation"] or 0

    return configTable
end

function Sprite:getImage()
    if self.image == nil or Assets.images[self.image .. "_" .. self.frame] == nil then
        return Assets.images["default"]
    else
        return Assets.images[self.image .. "_" .. self.frame]
    end
end

function Sprite:constructor(configTable)
    configTable = Sprite.configTable_defaults(configTable)

    self.image = configTable["image"]
    self.position = configTable["position"]
    self.scale = configTable["scale"]
    self.offset = configTable["offset"]
    self.rotation = configTable["rotation"]
    self.frame = 0
end

function Sprite:draw()
    love.graphics.push()
    love.graphics.draw(
        self:getImage(),
        self.position.x, self.position.y,
        self.rotation,
        self.scale.x, self.scale.y,
        -self.offset.x * self:getImage():getWidth(),
        -self.offset.y * self:getImage():getHeight()
    )
    love.graphics.pop()
end

return Sprite