local ammo = {}
local animations = require("animations")

windowDimensions = {}
windowDimensions.width = love.graphics.getWidth()
windowDimensions.height = love.graphics.getHeight()

-- ammo.bomb = {}
-- ammo.bomb["img"] = love.graphics.newImage("libraries/Ennemies/Weapon Effects - Projectiles/Nautolan - Bomb.png")
-- ammo.bomb["ox"] = ammo.bomb["img"]:getWidth() / 2
-- ammo.bomb["oy"] = ammo.bomb["img"]:getHeight() / 2
-- ammo.bomb["x"] = 0
-- ammo.bomb["y"] = 0
-- ammo.bomb["r"] = 0
-- ammo.bomb["vx"] = 0
-- ammo.bomb["vy"] = 0
-- ammo.bomb["speed"] = 2
-- ammo.bomb["rHitbox"] = 18
-- ammo.bomb["frame"] = 0
-- ammo.bomb["quads"] = spriteQuads(ammo.bomb["img"])
-- ammo.bomb["time"] = 0
-- ammo.bomb["dmg"] = 50
-- ammo.bomb["range"] = windowDimensions.width

function ammo.CreateBullet(pEnemies)
    local bullet = {}
    bullet = {}
    bullet["img"] = love.graphics.newImage("libraries/Ennemies/Weapon Effects - Projectiles/Nautolan - Bullet.png")
    bullet["x"] = pEnemies.x
    bullet["y"] = pEnemies.y
    bullet["r"] = pEnemies.r
    bullet["vx"] = pEnemies.vx
    bullet["vy"] = pEnemies.vy
    bullet["speed"] = 10
    bullet["rHitbox"] = 4
    bullet["frame"] = 0
    bullet["quads"] = spriteQuads(bullet["img"])
    bullet["time"] = 0
    bullet["ox"] = bullet["img"]:getWidth() / #bullet["quads"] / 2
    bullet["oy"] = bullet["img"]:getHeight() / #bullet["quads"] / 2
    bullet["dmg"] = 2
    bullet["range"] = windowDimensions.width

    return bullet
end

-- ammo.ray = {}
-- ammo.ray["img"] = love.graphics.newImage("libraries/Ennemies/Weapon Effects - Projectiles/Nautolan - Ray.png")
-- ammo.ray["ox"] = ammo.ray["img"]:getWidth() / 2
-- ammo.ray["oy"] = ammo.ray["img"]:getHeight() / 2
-- ammo.ray["x"] = 0
-- ammo.ray["y"] = 0
-- ammo.ray["r"] = 0
-- ammo.ray["vx"] = 0
-- ammo.ray["vy"] = 0
-- ammo.ray["speed"] = 3
-- ammo.ray["rHitbox"] = 18
-- ammo.ray["frame"] = 0
-- ammo.ray["quads"] = spriteQuads(ammo.ray["img"])
-- ammo.ray["time"] = 0
-- ammo.ray["dmg"] = 100
-- ammo.ray["range"] = windowDimensions.width

function ammo.CreateRocket(pEnemies)
    local rocket = {}
    rocket["img"] = love.graphics.newImage("libraries/Ennemies/Weapon Effects - Projectiles/Nautolan - Rocket.png")
    rocket["ox"] = rocket["img"]:getWidth() / 2
    rocket["oy"] = rocket["img"]:getHeight() / 2
    rocket["x"] = pEnemies.x
    rocket["y"] = pEnemies.y
    rocket["r"] = pEnemies.r
    rocket["vx"] = pEnemies.vx
    rocket["vy"] = pEnemies.vy
    rocket["speed"] = 3
    rocket["rHitbox"] = 16
    rocket["frame"] = 0
    rocket["quads"] = spriteQuads(rocket["img"])
    rocket["time"] = 0
    rocket["dmg"] = 10
    rocket["range"] = windowDimensions.width

    return rocket
end

function ammo.CreateSpinner(pEnemies)
    local spinner = {}
    spinner["img"] =
        love.graphics.newImage("libraries/Ennemies/Weapon Effects - Projectiles/Nautolan - Spinning Bullet.png")
    spinner["x"] = pEnemies.x
    spinner["y"] = pEnemies.y
    spinner["r"] = pEnemies.r
    spinner["vx"] = pEnemies.vx
    spinner["vy"] = pEnemies.vy
    spinner["speed"] = 6
    spinner["rHitbox"] = 4
    spinner["frame"] = 0
    spinner["quads"] = spriteQuads(spinner["img"])
    spinner["time"] = 0
    spinner["ox"] = spinner["img"]:getWidth() / #spinner["quads"] / 2
    spinner["oy"] = spinner["img"]:getHeight() / #spinner["quads"] / 2
    spinner["dmg"] = 5
    spinner["range"] = windowDimensions.width

    return spinner
end

return ammo
