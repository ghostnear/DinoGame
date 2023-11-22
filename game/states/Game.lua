local Menu = GameState.new()

function Menu:updateIdleDino()
    Timer.after(1, function()
        if self.playerstate ~= "idle" then return end

        self.player.frame = 1
        
        Timer.after(1, function()
            if self.playerstate ~= "idle" then return end

            self.player.frame = 0

            self:updateIdleDino()
        end)
    end)
end

function Menu:init()
    self.camera = Camera.new(960 / 2, 540 / 2, 1, 0)

    self.backgroundColor = Color.fromByteFormat(245, 245, 245)
    self.clouds = {}
    self.clouds[0] = SpriteObject({
        image = "cloud-small",
        position = Vector2(240 + love.math.random(240), 540 * 1 / 10),
        offset = Vector2(-1, 0.5),
        scale = Vector2(1.1, 1.1)
    })
    self.clouds[1] = SpriteObject({
        image = "cloud",
        position = Vector2(self.clouds[0].position.x + 240 + love.math.random(240), 540 * 2 / 13),
        offset = Vector2(-1, 0.5),
    })

    self.clickText = TextObject({
        text = "Click to start!",
        offset = Vector2(0.5, 0.5),
        align = "center",
        color = Color(0.69, 0.69, 0.69),
        font = "PS2P-R-24",
        position = Vector2(960 / 2, 540 * 5 / 6)
    })

    self.backgroundTerrain = SpriteObject({
        image = "ground",
        position = Vector2(0, 540 * 3 / 5),
    })

    self.player = AnimatedSpriteObject({
        image = "dino_idle",
        position = Vector2(50, 540 * 3 / 5 + 25),
        scale = Vector2(1.75, 1.75),
        offset = Vector2(0.5, -1)
    })
    self.playerstate = "idle"

    self:updateIdleDino()
end

function Menu:update(dt)
    for index = 0, #self.clouds do
        self.clouds[index].position.x = self.clouds[index].position.x + -5 * dt * (index + 1) / #self.clouds

        if self.clouds[index].position.x < 0 then
            self.clouds[index].position.x = 960 + self.clouds[index]:getImage():getWidth() * self.clouds[index].scale.x
        end
    end

    self.camera:zoomTo(love.graphics.getWidth() / 960)
end

function Menu:draw()
    love.graphics.clear(self.backgroundColor:unpack())

    self.camera:attach()

    self.backgroundTerrain:draw()
    self.player:draw()

    for index = 0, #self.clouds do
        self.clouds[index]:draw()
    end

    self.clickText:draw()

    self.camera:detach()
end

return Menu