local Text = Object:extend()

function Text.configTable_defaults(configTable)
    configTable["text"] = configTable["text"] or "<null>"
    configTable["position"] = configTable["position"] or Vector2(0, 0)
    configTable["offset"] = configTable["offset"] or Vector2(0, 0)
    configTable["align"] = configTable["align"] or "left"
    configTable["font"] = configTable["font"] or nil
    configTable["scale"] = configTable["scale"] or Vector2(1, 1)
    configTable["rotation"] = configTable["rotation"] or 0
    configTable["color"] = configTable["color"] or Color(1, 1, 1)

    return configTable
end

function Text:getFont()
    if self.font == nil or Assets.fonts[self.font] == nil then
        return Assets.fonts["default-R-12"]
    else
        return Assets.fonts[self.font]
    end
end

function Text:constructor(configTable)
    configTable = Text.configTable_defaults(configTable)

    self.text = configTable["text"]
    self.position = configTable["position"]
    self.offset = configTable["offset"]
    self.align = configTable["align"]
    self.font = configTable["font"]
    self.scale = configTable["scale"]
    self.rotation = configTable["rotation"]
    self.color = configTable["color"]
end

function Text:draw()
    love.graphics.push()
    love.graphics.setColor(self.color:unpack())
    love.graphics.setFont(self:getFont())
    love.graphics.printf(
        self.text,
        self.position.x,
        self.position.y,
        love.graphics.getFont():getWidth(self.text),
        self.align, self.rotation,
        self.scale.x, self.scale.y,
        love.graphics.getFont():getWidth(self.text) * self.offset.x,
        love.graphics.getFont():getHeight(self.text) * self.offset.y
    )
    love.graphics.pop()
end

return Text