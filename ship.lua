local ship = {}

windowDimensions = {}
windowDimensions.width = love.graphics.getWidth()
windowDimensions.height = love.graphics.getHeight()
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------|SHIP PARAMETERS|--------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
ship.img = love.graphics.newImage("libraries/Main Ship/Main Ship - Bases/Main Ship - Base - Full health.png")
ship.ox = ship.img:getWidth() / 2
ship.oy = ship.img:getHeight() / 2
ship.x = windowDimensions.width / 2
ship.y = windowDimensions.height / 2
ship.r = 0
ship.vx = 0
ship.vy = 0
ship.hp = 100
ship.rHitbox = 13
ship.bonus = {}
---------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------|MOVE SHIP|-----------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
function ship.move(dt)
    if love.keyboard.isDown("d") then
        ship.r = ship.r + 180 * dt
        if ship.r > 360 then
            ship.r = 0
        end
        if ship.r < -360 then
            ship.r = 0
        end
    end
    if love.keyboard.isDown("q") then
        ship.r = ship.r - 180 * dt
        if ship.r > 360 then
            ship.r = 0
        end
        if ship.r < -360 then
            ship.r = 0
        end
    end
    --changer de bords
    if ship.x < -ship.rHitbox then
        ship.lastX = ship.x
        ship.x = windowDimensions.width + ship.rHitbox
    elseif ship.x > windowDimensions.width + ship.rHitbox then
        ship.lastX = ship.x
        ship.x = 0 - ship.rHitbox
    end
    if ship.y < -ship.rHitbox then
        ship.lastY = ship.y
        ship.y = windowDimensions.height + ship.rHitbox
    elseif ship.y > windowDimensions.height + ship.rHitbox then
        ship.lastY = ship.y
        ship.y = 0 - ship.rHitbox
    end
end
---------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------|DRAW SHIP|-----------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
ship.Draw = function()
    love.graphics.draw(ship.img, ship.x, ship.y, math.rad(ship.r), 1, 1, ship.ox, ship.oy)
    if ship.hp == 100 then
        ship.img = love.graphics.newImage("libraries/Main Ship/Main Ship - Bases/Main Ship - Base - Full health.png")
    elseif ship.hp < 100 and ship.hp >= 75 then
        ship.img = love.graphics.newImage("libraries/Main Ship/Main Ship - Bases/Main Ship - Base - Slight damage.png")
    elseif ship.hp < 75 and ship.hp >= 25 then
        ship.img = love.graphics.newImage("libraries/Main Ship/Main Ship - Bases/Main Ship - Base - Damaged.png")
    elseif ship.hp < 25 and ship.hp >= 1 then
        ship.img = love.graphics.newImage("libraries/Main Ship/Main Ship - Bases/Main Ship - Base - Very damaged.png")
    end
end

return ship
