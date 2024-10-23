local bonus = {}
local animations = require("animations")
local ship = require("ship")
local shield = require("shield")

windowDimensions = {}
windowDimensions.width = love.graphics.getWidth()
windowDimensions.height = love.graphics.getHeight()

activeBonus = {}

function CreateShield()
    local bShield = {}
    bShield.img =
        love.graphics.newImage(
        "libraries/Bonus/Shield Generators/Pickup Icon - Shield Generator - All around shield.png"
    )
    bShield.ox = bShield.img:getWidth() / 2
    bShield.oy = bShield.img:getHeight() / 2
    bShield.x = 0
    bShield.y = 0
    bShield.r = 0
    bShield.spawnRate = 30
    bShield.frame = 0
    bShield.quads = spriteQuads(bShield.img)
    bShield.time = 0
    bShield.name = "shield"
    return bShield
end

function CreateDash()
    local bDash = {}
    bDash.img =
        love.graphics.newImage(
        "libraries/Bonus/Shield Generators/Pickup Icon - Shield Generator - All around shield.png"
    )
    bDash.ox = bDash.img:getWidth() / 2
    bDash.oy = bDash.img:getHeight() / 2
    bDash.x = 0
    bDash.y = 0
    bDash.r = 0
    bDash.spawnRate = 20
    bDash.frame = 0
    bDash.quads = spriteQuads(bDash.img)
    bDash.time = 0
    bDash.name = "dash"
    return bDash
end

function AddBonus(dt)
    pShield = CreateShield()
    pDash = CreateDash()
    if pShield.name == "shield" then
        local spwnR = RUNNING_TIME % pShield.spawnRate
        pShield.x = math.random(10, windowDimensions.width - 10)
        pShield.y = math.random(10, windowDimensions.height - 10)
        if spwnR >= pShield.spawnRate - dt then
            spwnR = 0
            pShield.frame = spriteUpdate(pShield.quads, pShield.frame, 1, dt)
            table.insert(activeBonus, pShield)
        end
        print(tostring(spwnR))
    elseif pDash.name == "dash" then
        local spwnR = RUNNING_TIME % pDash.spawnRate
        pDash.x = math.random(10, windowDimensions.width - 10)
        pDash.y = math.random(10, windowDimensions.height - 10)
        if spwnR >= pDash.spawnRate - dt then
            spwnR = 0
            pDash.frame = spriteUpdate(pDash.quads, pDash.frame, 1, dt)
            table.insert(activeBonus, pDash)
        end
    end
end

function bonus.update(listBonus, dt)
    for k, v in ipairs(listBonus) do
        if collisions.ammoShip(listBonus, v, dt) == true then
            if v.name == "shield" then
                shield.hp = shield.hp + 50
            end
            if v.name == "dash" then
                table.insert(ship.bonus, v)
            end
            table.remove(listBonus, k)
        end
    end
end

function bonus.draw()
    for _, v in ipairs(SHOTSFIRED) do
        spriteDraw(v.img, v.quads, v.frame, v.x, v.y, v.r, 1, 1, v.ox, v.oy)
    end
end

return bonus
