local engine = {}
local fire = {}

local animations = require("animations")
local ship = require("ship")

---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------|SHIP PARAMETERS|--------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
engine.img = love.graphics.newImage("libraries/Main Ship/Main Ship - Engines/Main Ship - Engines - Base Engine.png")
fire.img =
    love.graphics.newImage(
    "libraries/Main Ship/Main Ship - Engine Effects/Main Ship - Engines - Base Engine - Powering.png"
)
fire.frame = 0
fire.quads = spriteQuads(fire.img)
fire.time = 1
engine.ox = ship.ox
engine.oy = ship.oy
engine.x = ship.x
engine.y = ship.y
engine.r = ship.r
engine.speed = 3
engine.on = false
engine.off = true
---------------------------------------------------------------------------------------------------------------------
----------------------------------------------|POWER ENGINE TO MOVE SHIP|--------------------------------------------
---------------------------------------------------------------------------------------------------------------------
function engine.power(dt)
    -- slow ship with damage taken
    if ship.hp > 20 then
        engine.speed = 3 * (ship.hp / 100)
    end
    -- for k, v in pairs(ship.bonus) do
    --     if v.name == "dash" and love.keyboard.isDown("space") then
    --         engine.speed = 10
    --         -- Clean bonus
    --         ship.bonus[k] = nil
    --     end
    -- end
    -- move ship
    if love.keyboard.isDown("z") then
        --anim
        fire.frame = spriteUpdate(fire.quads, fire.frame, fire.time, dt)

        engine.on = true
        -- Mouvements avec vecteurs bidimensionnels
        local force_x = math.cos(math.rad(engine.r - 90)) * (engine.speed * dt)
        local force_y = math.sin(math.rad(engine.r - 90)) * (engine.speed * dt)
        ship.vx = ship.vx + force_x
        ship.vy = ship.vy + force_y
    else
        engine.on = false
    end

    local fpsDev = 165
    -- move
    ship.x = ship.x + ship.vx * fpsDev * dt
    ship.y = ship.y + ship.vy * fpsDev * dt
    engine.x = ship.x
    engine.y = ship.y
    engine.r = ship.r

    -- cap speed
    if math.abs(ship.vx) > engine.speed / 2 then
        if ship.vx > 0 then
            ship.vx = engine.speed / 2
        else
            ship.vx = -engine.speed / 2
        end
    end
    if math.abs(ship.vy) > engine.speed / 2 then
        if ship.vy > 0 then
            ship.vy = engine.speed / 2
        else
            ship.vy = -engine.speed / 2
        end
    end
end
---------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------|DRAW ENGINE|---------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
function engine.DrawEngine()
    love.graphics.draw(engine.img, engine.x, engine.y, math.rad(engine.r), 1, 1, engine.ox, engine.oy)
    if engine.on == true then
        spriteDraw(fire.img, fire.quads, fire.frame, engine.x, engine.y, math.rad(engine.r), 1, 1, engine.ox, engine.oy)
    end
end

return engine
