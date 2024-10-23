local shield = {}
local ship = require("ship")

windowDimensions = {}
windowDimensions.width = love.graphics.getWidth()
windowDimensions.height = love.graphics.getHeight()

---------------------------------------------------------------------------------------------------------------------
-------------------------------------------------|SHIELD PARAMETERS|-------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
shield.img = love.graphics.newImage("libraries/Main Ship/Main Ship - Shields/Main Ship - Shields - Front Shield.png")
shield.ox = shield.img:getWidth() / 2
shield.oy = shield.img:getHeight() / 2
shield.x = ship.x
shield.y = ship.y
shield.edgeX = 0
shield.edgeY = 0
shield.r = ship.r
shield.rt = 0
shield.rHitbox = 20
shield.hp = 100
shield.drainRate = 0.1
shield.regenRate = 1
---------------------------------------------------------------------------------------------------------------------
function math.angle(x1, y1, x2, y2)
    return math.atan2(y2 - y1, x2 - x1)
end
---------------------------------------------------------------------------------------------------------------------
----------------------------------------------------|MOVE SHIELD|----------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
function shield.move(dt)
    local mx, my = love.mouse.getPosition()
    local angleShield = math.angle(ship.x, ship.y, mx, my)
    shield.rt = angleShield
    -- Energy managment
    local energyDrain = RUNNING_TIME % shield.drainRate
    local energyRegen = RUNNING_TIME % shield.regenRate
    if love.keyboard.isDown("z") and shield.hp >= 0 then
        if energyDrain >= shield.drainRate - dt then
            shield.hp = shield.hp - 1
        end
    elseif energyRegen >= shield.regenRate - dt and shield.hp <= 100 then
        shield.hp = shield.hp + 1
    end
end
---------------------------------------------------------------------------------------------------------------------
----------------------------------------------------|DRAW SHIELD|----------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
function shield.Draw()
    if shield.hp > 0 then
        love.graphics.draw(shield.img, ship.x, ship.y, shield.rt, 1, 1, shield.ox, shield.oy)
    end
end

return shield
