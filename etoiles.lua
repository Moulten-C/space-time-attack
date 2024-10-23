local etoiles = {}
local engine = require("engine")
local ship = require("ship")

windowDimensions = {}
windowDimensions.width = love.graphics.getWidth()
windowDimensions.height = love.graphics.getHeight()
---------------------------------------------------------------------------------------------------------------------
-------------------------------------------------|STARS PARAMETERS|--------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
etoiles.listeEtoiles = {}
etoiles.speed = 100
etoiles.background = {}
etoiles.background["img"] = love.graphics.newImage("libraries/Backgrounds/Purple_Nebula_02-1024x1024.png")
etoiles.background["x"] = 0
etoiles.background["y"] = 0
etoiles.background["ox"] = etoiles.background["img"]:getWidth() / 2
etoiles.background["oy"] = etoiles.background["img"]:getHeight() / 2
---------------------------------------------------------------------------------------------------------------------
----------------------------------------------------|CREATE STARS|---------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
for n = 1, 200 do
    local e = {}
    e.x = love.math.random(1, love.graphics.getWidth() - 1)
    e.y = love.math.random(1, love.graphics.getHeight() - 1)
    e.size = love.math.random(1000, 2000)
    e.speed = etoiles.speed - (10 * (4000 - e.size) / 1000)
    table.insert(etoiles.listeEtoiles, e)
end
---------------------------------------------------------------------------------------------------------------------
----------------------------------------------------|MOVE STARS|-----------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
function etoiles.update(dt)
    for _, e in ipairs(etoiles.listeEtoiles) do
        local force_x = 0
        local force_y = 0
        -- Changement de direction des étoiles selon le cap du vaisseau joueur
        if ship.vx > 0 then
            force_x = e.speed * -ship.vx * 0.5 * dt
        elseif ship.vx < 0 then
            force_x = e.speed * -ship.vx * 0.5 * dt
        elseif RUNNING_TIME == 0 then
            force_x = 0.1
        end
        if ship.vy > 0 then
            force_y = e.speed * -ship.vy * 0.5 * dt
        elseif ship.vy < 0 then
            force_y = e.speed * -ship.vy * 0.5 * dt
        elseif RUNNING_TIME == 0 then
            force_y = 0.1
        end
        -- move
        e.x = e.x + force_x
        e.y = e.y + force_y
        if SCREEN == "game" then
            etoiles.background["x"] = etoiles.background["x"] + force_x / etoiles.speed
            etoiles.background["y"] = etoiles.background["y"] + force_y / etoiles.speed
        end
        -- side switch
        if e.x < 4 then
            e.x = windowDimensions.width + 4
        elseif e.x > windowDimensions.width + 4 then
            e.x = 0 + 4
        end
        if e.y < 4 then
            e.y = windowDimensions.height + 4
        elseif e.y > windowDimensions.height + 4 then
            e.y = 0 + 4
        end
    end
end
---------------------------------------------------------------------------------------------------------------------
-------------------------------------------------|DRAW BACKGROUND|---------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
function etoiles.draw()
    -- draw background grid 9x9
    for i = 1, 9 do
        for j = 1, 9 do
            love.graphics.draw(
                etoiles.background["img"],
                etoiles.background["x"] + ((5 - i) * etoiles.background["img"]:getWidth()),
                etoiles.background["y"] + ((5 - j) * etoiles.background["img"]:getHeight())
            )
        end
    end
    for _, e in ipairs(etoiles.listeEtoiles) do
        love.graphics.circle("fill", e.x, e.y, e.size / 1000)
    end
end

return etoiles
