local Loading = GameState.new()

function Loading:init()
    self.camera = Camera.new(960 / 2, 540 / 2, 1, 0)

    self.hasLoaded = false
    self.loadingText = TextObject({
        text = "Loading...\n\n0%",
        offset = Vector2(0.5, 0.5),
        scale = Vector2(2, 2),
        align = "center",
        color = Color(0.69, 0.69, 0.69),
        font = "PS2P-R-24",
        position = Vector2(960 / 2, 540 / 2)
    })
    self.backgroundColor = Color.fromByteFormat(245, 245, 245)

    -- !IMPORTANT! Make sure the 'asset list' is up to date.
    Assets.fonts = {}
    Assets.fonts["default-R-12"] = love.graphics.newFont(12)
    ThreadedLoader.newFont(Assets.fonts, "PS2P-R-24", "assets/fonts/PressStart2P-Regular.ttf", 24)

    Assets.images = {}
    Assets.images["default"] = love.graphics.newImage("assets/images/default.png")
    ThreadedLoader.newImage(Assets.images, "dino_idle_0", "assets/images/dino_idle_0.png")
    ThreadedLoader.newImage(Assets.images, "dino_idle_1", "assets/images/dino_idle_1.png")
    ThreadedLoader.newImage(Assets.images, "ground", "assets/images/ground.png")
    ThreadedLoader.newImage(Assets.images, "cloud", "assets/images/cloud.png")
    ThreadedLoader.newImage(Assets.images, "cloud-small", "assets/images/cloud-small.png")

    ThreadedLoader.start(function()
        self.hasLoaded = true
        self.loadingText.text = "Loading...\n\n100%"
    end)
end

function Loading:update(dt)
    if not self.hasLoaded then
        ThreadedLoader.update()

        local percent = 0
        if ThreadedLoader.resourceCount ~= 0 then
            percent = ThreadedLoader.loadedCount / ThreadedLoader.resourceCount
        end
        self.loadingText.text = ("Loading...\n\n%d%%"):format(percent * 100)
    else
        local newState = require('game.states.Game')
        -- TODO: vertical flip translation state in here.
        GameState.switch(newState)
    end

    -- Funky effect lol.
    self.camera:zoomTo((1 + math.sin(love.timer.getTime() * 3) * 0.05) * (love.graphics.getWidth() / 960))
end

function Loading:draw()
    love.graphics.clear(self.backgroundColor:unpack())
    
    self.camera:attach()

    self.loadingText:draw()

    self.camera:detach()
end

return Loading