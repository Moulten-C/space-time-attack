local enemies = {}
local ship = require("ship")
local shield = require("shield")
local animations = require("animations")
local ammo = require("ammo")
local collisions = require("collisions")

windowDimensions = {}
windowDimensions.width = love.graphics.getWidth()
windowDimensions.height = love.graphics.getHeight()
---------------------------------------------------------------------------------------------------------------------
------------------------------------------------|ENNEMIES PARAMETERS|------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
enemies.scout = {}
enemies.scout["active"] = false
enemies.scout["state"] = "track"
enemies.scout["img"] = love.graphics.newImage("libraries/Ennemies/Nautolan Ship - Scout - Base.png")
enemies.scout["ox"] = enemies.scout["img"]:getWidth() / 2
enemies.scout["oy"] = enemies.scout["img"]:getHeight() / 2
enemies.scout["rand"] = math.floor(love.math.random(0, 2))
if enemies.scout["rand"] <= 1 then
    enemies.scout["y"] = -100
elseif enemies.scout["rand"] > 1 then
    enemies.scout["y"] = windowDimensions.height + 100
end
enemies.scout["x"] = love.math.random(0, windowDimensions.width)
enemies.scout["r"] = 0
enemies.scout["vx"] = 0
enemies.scout["vy"] = 0
enemies.scout["speed"] = 3
enemies.scout["rHitbox"] = 13
enemies.scout["jet"] = {}
enemies.scout["jet"]["img"] =
    love.graphics.newImage("libraries/Ennemies/Engine Effects/Nautolan Ship - Scout - Engine Effect.png")
enemies.scout["jet"]["frame"] = 0
enemies.scout["jet"]["quads"] = spriteQuads(enemies.scout["jet"]["img"])
enemies.scout["jet"]["time"] = 0
enemies.scout["jet"]["on"] = true
enemies.scout["jet"]["updateTime"] = 1
enemies.scout["weapons"] = {
    img = love.graphics.newImage("libraries/Ennemies/Weapons/Nautolan Ship - Scout - Weapons.png"),
    frame = 0,
    front = {
        x = 0,
        y = 0,
        mag = ammo.spinner,
        firerate = 0.2 --s/shot
    }
}
enemies.scout["weapons"]["quads"] = spriteQuads(enemies.scout["weapons"]["img"])
---------------------------------------
---------------------------------------
---------------------------------------
enemies.frigate = {}
enemies.frigate["active"] = false
enemies.frigate["state"] = "track"
enemies.frigate["img"] = love.graphics.newImage("libraries/Ennemies/Nautolan Ship - Frigate - Base.png")
enemies.frigate["ox"] = enemies.frigate["img"]:getWidth() / 2
enemies.frigate["oy"] = enemies.frigate["img"]:getHeight() / 2 - 5
enemies.frigate["rand"] = math.floor(love.math.random(0, 2))
enemies.frigate["x"] = love.math.random(0, windowDimensions.width)
if enemies.frigate["rand"] <= 1 then
    enemies.frigate["y"] = -100
elseif enemies.frigate["rand"] > 1 then
    enemies.frigate["y"] = windowDimensions.width + 100
end
enemies.frigate["r"] = 0
enemies.frigate["vx"] = 0
enemies.frigate["vy"] = 0
enemies.frigate["speed"] = 2
enemies.frigate["rHitbox"] = 18
enemies.frigate["jet"] = {}
enemies.frigate["jet"]["img"] =
    love.graphics.newImage("libraries/Ennemies/Engine Effects/Nautolan Ship - Frigate - Engine Effect.png")
enemies.frigate["jet"]["frame"] = 0
enemies.frigate["jet"]["quads"] = spriteQuads(enemies.frigate["jet"]["img"])
enemies.frigate["jet"]["time"] = 0
enemies.frigate["jet"]["on"] = true
enemies.frigate["jet"]["updateTime"] = 1
enemies.frigate["weapons"] = {
    img = love.graphics.newImage("libraries/Ennemies/Weapons/Nautolan Ship - Frigate - Weapons.png"),
    frame = 0,
    front = {
        x = 0,
        y = 0,
        mag = ammo.bullet,
        firerate = 0.1 --s/shot
    }
}
enemies.frigate["weapons"]["quads"] = spriteQuads(enemies.frigate["weapons"]["img"])
---------------------------------------
---------------------------------------
---------------------------------------
enemies.battlecruiser = {}
enemies.battlecruiser["active"] = false
enemies.battlecruiser["state"] = "track"
enemies.battlecruiser["img"] = love.graphics.newImage("libraries/Ennemies/Nautolan Ship - Battlecruiser - Base.png")
enemies.battlecruiser["ox"] = enemies.battlecruiser["img"]:getWidth() / 2
enemies.battlecruiser["oy"] = enemies.battlecruiser["img"]:getHeight() / 2 - 10
enemies.battlecruiser["rand"] = love.math.random(0, 2)
enemies.battlecruiser["x"] = love.math.random(0, windowDimensions.width)
if enemies.battlecruiser["rand"] <= 1 then
    enemies.battlecruiser["y"] = -100
elseif enemies.battlecruiser["rand"] > 1 then
    enemies.battlecruiser["y"] = windowDimensions.height + 100
end
enemies.battlecruiser["r"] = 0
enemies.battlecruiser["vx"] = 0
enemies.battlecruiser["vy"] = 0
enemies.battlecruiser["speed"] = 1.5
enemies.battlecruiser["rHitbox"] = 33
enemies.battlecruiser["jet"] = {}
enemies.battlecruiser["jet"]["img"] =
    love.graphics.newImage("libraries/Ennemies/Engine Effects/Nautolan Ship - Battlecruiser - Engine Effect.png")
enemies.battlecruiser["jet"]["frame"] = 0
enemies.battlecruiser["jet"]["quads"] = spriteQuads(enemies.battlecruiser["jet"]["img"])
enemies.battlecruiser["jet"]["time"] = 0
enemies.battlecruiser["jet"]["on"] = true
enemies.battlecruiser["jet"]["updateTime"] = 1
enemies.battlecruiser["weapons"] = {
    img = love.graphics.newImage("libraries/Ennemies/Weapons/Nautolan Ship - Battlecruiser - Weapons.png"),
    frame = 0,
    front = {
        x = math.cos(enemies.battlecruiser["r"]) * enemies.battlecruiser["x"],
        y = math.sin(enemies.battlecruiser["r"]) * (enemies.battlecruiser["y"] - enemies.battlecruiser["rHitbox"]),
        mag = ammo.rocket,
        firerate = 1 --s/shot
    },
    left = {
        x = 0,
        y = 0,
        mag = ammo.bullet,
        firerate = 0.1 --s/shot
    },
    right = {
        x = 0,
        y = 0,
        mag = ammo.bullet,
        firerate = 0.1 --s/shot
    }
}
enemies.battlecruiser["weapons"]["quads"] = spriteQuads(enemies.battlecruiser["weapons"]["img"])
---------------------------------------
---------------------------------------
---------------------------------------
-- enemies.dreadnought = {}
-- enemies.dreadnought["active"] = false
-- enemies.dreadnought["state"] = "track"
-- enemies.dreadnought["img"] = love.graphics.newImage("libraries/Ennemies/Nautolan Ship - Dreadnought - Base.png")
-- enemies.dreadnought["ox"] = enemies.dreadnought["img"]:getWidth() / 2
-- enemies.dreadnought["oy"] = enemies.dreadnought["img"]:getHeight() / 2
-- enemies.dreadnought["rand"] = math.floor(love.math.random(0, 2))
-- enemies.dreadnought["x"] = love.math.random(0, windowDimensions.width)
-- if enemies.dreadnought["rand"] <= 1 then
--     enemies.dreadnought["y"] = love.math.random(-100, windowDimensions.width + 100)
-- elseif enemies.dreadnought["rand"] > 1 then
--     enemies.dreadnought["y"] = love.math.random(-100, windowDimensions.width + 100)
-- end
-- enemies.dreadnought["r"] = 0
-- enemies.dreadnought["vx"] = 0
-- enemies.dreadnought["vy"] = 0
-- enemies.dreadnought["speed"] = 2
-- enemies.dreadnought["rHitbox"] = 40
-- enemies.dreadnought["jet"] = {}
-- enemies.dreadnought["jet"]["img"] =
--     love.graphics.newImage("libraries/Ennemies/Engine Effects/Nautolan Ship - Dreadnought - Engine Effect.png")
-- enemies.dreadnought["jet"]["frame"] = 0
-- enemies.dreadnought["jet"]["quads"] = spriteQuads(enemies.dreadnought["jet"]["img"])
-- enemies.dreadnought["jet"]["time"] = 0
-- enemies.dreadnought["jet"]["on"] = true
-- enemies.dreadnought["jet"]["updateTime"] = 1
-- enemies.dreadnought["armory"] = {}
---------------------------------------------------------------------------------------------------------------------
-----------------------------------------------|ENEMY SHOOTING|------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
SHOTSFIRED = {}

function enemies.createShot(pEnemies, dt)
    local shot = {}
    if pEnemies.state == "track" then
        if pEnemies == enemies.scout then
            shot = ammo.CreateSpinner(pEnemies)
        elseif pEnemies == enemies.frigate then
            shot = ammo.CreateBullet(pEnemies)
        elseif pEnemies == enemies.battlecruiser then
            shot.front = ammo.CreateRocket(pEnemies)
            shot.front["x"] = pEnemies["x"] + math.cos(pEnemies["r"])
            shot.front["y"] = pEnemies["y"] + math.sin(pEnemies["r"])
            shot.front["side"] = "front"

            shot.left = ammo.CreateBullet(pEnemies)
            shot.left["x"] = pEnemies["x"] + math.cos(pEnemies["r"] + math.rad(90)) * 20
            shot.left["y"] = pEnemies["y"] + math.sin(pEnemies["r"] + math.rad(90)) * 20
            shot.left["side"] = "left"

            shot.right = ammo.CreateBullet(pEnemies)
            shot.right["x"] = pEnemies["x"] + math.cos(pEnemies["r"] - math.rad(90)) * 20
            shot.right["y"] = pEnemies["y"] + math.sin(pEnemies["r"] - math.rad(90)) * 20
            shot.right["side"] = "right"
        end

        --------------------------------------------
        ----|TRIGGER SHOT FOR SCOUT AND FRIGATE|----
        --------------------------------------------
        if pEnemies == enemies.scout or pEnemies == enemies.frigate then
            if math.abs(pEnemies.vx) > 0 and math.abs(pEnemies.vy) > 0 then
                -- count firerate
                local firerate = RUNNING_TIME % pEnemies.weapons["front"]["firerate"]
                --print(tostring(firerate))
                if firerate >= pEnemies.weapons["front"]["firerate"] - dt then
                    firerate = 0
                    pEnemies.weapons["frame"] =
                        spriteUpdate(pEnemies.weapons["quads"], pEnemies.weapons["frame"], 1, dt)
                    table.insert(SHOTSFIRED, shot)
                    -- play shooting sounds
                    if pEnemies == enemies.scout then
                        love.audio.stop(SFX.spinner)
                        love.audio.play(SFX.spinner)
                    elseif pEnemies == enemies.frigate then
                        love.audio.stop(SFX.bullet)
                        love.audio.play(SFX.bullet)
                    end
                end
            end
        end

        ------------------------------------------
        -----|TRIGGER SHOT FOR BATTLECRUISER|-----
        ------------------------------------------
        if pEnemies == enemies.battlecruiser then
            if math.abs(pEnemies.vx) > 0 and math.abs(pEnemies.vy) > 0 then
                -- Firerate timer
                local frontFirerate = RUNNING_TIME % pEnemies.weapons["front"]["firerate"]
                local leftFirerate = RUNNING_TIME % pEnemies.weapons["left"]["firerate"]
                local rightFirerate = RUNNING_TIME % pEnemies.weapons["right"]["firerate"]
                -- Front weapon
                if frontFirerate >= pEnemies.weapons["front"]["firerate"] - dt then
                    frontFirerate = 0
                    pEnemies.weapons["frame"] =
                        spriteUpdate(pEnemies.weapons["quads"], pEnemies.weapons["frame"], 1, dt)
                    table.insert(SHOTSFIRED, shot.front)
                    love.audio.stop(SFX.rocket)
                    love.audio.play(SFX.rocket)
                end
                -- Left weapon
                if leftFirerate >= pEnemies.weapons["left"]["firerate"] - dt then
                    leftFirerate = 0
                    pEnemies.weapons["frame"] =
                        spriteUpdate(pEnemies.weapons["quads"], pEnemies.weapons["frame"], 1, dt)
                    table.insert(SHOTSFIRED, shot.left)
                    love.audio.stop(SFX.bullet)
                    love.audio.play(SFX.bullet)
                end
                -- Right weapon
                if rightFirerate >= pEnemies.weapons["right"]["firerate"] - dt then
                    rightFirerate = 0
                    pEnemies.weapons["frame"] =
                        spriteUpdate(pEnemies.weapons["quads"], pEnemies.weapons["frame"], 1, dt)
                    table.insert(SHOTSFIRED, shot.right)
                    love.audio.stop(SFX.bullet)
                    love.audio.play(SFX.bullet)
                end
            end
        end
        ------------------------------------------
        -------------|SHOT ANIMATION|-------------
        ------------------------------------------
        for _, v in ipairs(SHOTSFIRED) do
            v.frame = spriteUpdate(v.quads, v.frame, 1, dt)
        end
    elseif pEnemies.state == "evasion" and pEnemies.x > windowDimensions.width then
        -- Clean shots
        for k, _ in pairs(SHOTSFIRED) do
            SHOTSFIRED[k] = nil
        end
    end
end

function enemies.updateShot(pEnemies, dt)
    ---------------------------------------------
    -----|UPDATE SHOT FOR SCOUT AND FRIGATE|-----
    ---------------------------------------------
    if pEnemies == enemies.scout or pEnemies == enemies.frigate then
        for k, v in ipairs(SHOTSFIRED) do
            local freqDev = 165
            local force_x = math.cos(v.r) * (v.speed * dt)
            local force_y = math.sin(v.r) * (v.speed * dt)
            -- update speed
            v.vx = v.vx + force_x
            v.vy = v.vy + force_y
            -- move
            v.x = v.x + v.vx * freqDev * dt
            v.y = v.y + v.vy * freqDev * dt
            -- cap speed
            if math.abs(v.vx) > v.speed then
                if v.vx > 0 then
                    v.vx = v.speed
                else
                    v.vx = -v.speed
                end
            end
            if math.abs(v.vy) > v.speed then
                if v.vy > 0 then
                    v.vy = v.speed
                else
                    v.vy = -v.speed
                end
            end
            -- delete ammo out of sight
            if v.x > windowDimensions.width + 100 or v.x < -100 then
                table.remove(SHOTSFIRED, k)
            elseif v.y > windowDimensions.height + 100 or v.y < -100 then
                table.remove(SHOTSFIRED, k)
            end
            -- check collisions w/ player
            if collisions.ammoShip(SHOTSFIRED, v, dt) == true then
                love.audio.stop(SFX.hit)
                love.audio.play(SFX.hit)
                ship.hp = ship.hp - v.dmg
                table.remove(SHOTSFIRED, k)
            elseif collisions.ammoShield(SHOTSFIRED, v, dt) == true and shield.hp > 0 then
                shield.hp = shield.hp - v.dmg
                table.remove(SHOTSFIRED, k)
            end
        end
    end

    ---------------------------------------------
    -------|UPDATE SHOT FOR BATTLECRUISER|-------
    ---------------------------------------------
    if pEnemies == enemies.battlecruiser then
        for k, v in ipairs(SHOTSFIRED) do
            local freqDev = 165
            -- set starting force for each shot
            local force_x = 0
            local force_y = 0

            if v.side == "left" then -- left side
                force_x = math.cos(v.r + math.rad(30)) * (v.speed * dt)
                force_y = math.sin(v.r + math.rad(30)) * (v.speed * dt)
            elseif v.side == "right" then -- right side
                force_x = math.cos(v.r - math.rad(30)) * (v.speed * dt)
                force_y = math.sin(v.r - math.rad(30)) * (v.speed * dt)
            elseif v.side == "front" then -- front side
                v.r = ANGLE_ENEMY
                force_x = math.cos(v.r) * (v.speed * dt)
                force_y = math.sin(v.r) * (v.speed * dt)
            end
            -- update speed
            v.vx = v.vx + force_x
            v.vy = v.vy + force_y
            -- move
            v.x = v.x + v.vx * freqDev * dt
            v.y = v.y + v.vy * freqDev * dt

            -- cap speed
            if math.abs(v.vx) > v.speed then
                if v.vx > 0 then
                    v.vx = v.speed
                else
                    v.vx = -v.speed
                end
            end
            if math.abs(v.vy) > v.speed then
                if v.vy > 0 then
                    v.vy = v.speed
                else
                    v.vy = -v.speed
                end
            end

            -- delete ammo out of sight
            if v.x > windowDimensions.width + 100 or v.x < -100 then
                table.remove(SHOTSFIRED, k)
            elseif v.y > windowDimensions.height + 100 or v.y < -100 then
                table.remove(SHOTSFIRED, k)
            end

            -- check collisions w/ player
            if collisions.ammoShip(SHOTSFIRED, v, dt) == true then
                love.audio.stop(SFX.hit)
                love.audio.play(SFX.hit)
                ship.hp = ship.hp - v.dmg
                table.remove(SHOTSFIRED, k)
            elseif collisions.ammoShield(SHOTSFIRED, v, dt) == true then
                shield.hp = shield.hp - v.dmg
                table.remove(SHOTSFIRED, k)
            end
        end
    end
end
---------------------------------------------------------------------------------------------------------------------
-----------------------------------------------|ENEMY MOVING|--------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
function enemies.move(pEnemies, dt)
    ----------------------------------------
    --------------|MENU RESET|--------------
    ----------------------------------------
    if SCREEN == "menu" then
        enemies.scout["x"] = windowDimensions.width + 100
        if enemies.scout["rand"] == 1 then
            enemies.scout["y"] = -100
        elseif enemies.scout["rand"] == 2 then
            enemies.scout["y"] = windowDimensions.height + 100
        end
        enemies.scout["vx"] = 0
        enemies.scout["vy"] = 0
    end

    ----------------------------------------
    ----|QUAND L'ENNEMI TRAQUE LE JOUEUR|---
    ----------------------------------------
    if pEnemies.state == "track" then
        ANGLE_ENEMY = math.angle(pEnemies.x, pEnemies.y, ship.x, ship.y)
        pEnemies.r = ANGLE_ENEMY
        if pEnemies.r > math.rad(360) then
            pEnemies.r = 0
        end
        if pEnemies.r < math.rad(-360) then
            pEnemies.r = 0
        end

        if math.abs(ship.vx) > 0 and math.abs(ship.vy) > 0 then
            -- Mouvements avec vecteurs bidimensionnels
            local force_x = math.cos(pEnemies.r) * (pEnemies.speed * dt)
            local force_y = math.sin(pEnemies.r) * (pEnemies.speed * dt)
            -- update speed
            pEnemies.vx = pEnemies.vx + force_x
            pEnemies.vy = pEnemies.vy + force_y

            -- anim propulseurs
            pEnemies.jet["frame"] =
                spriteUpdate(pEnemies.jet["quads"], pEnemies.jet["frame"], pEnemies.jet["updateTime"], dt)
            pEnemies.jet["on"] = true
        else
            pEnemies.jet["on"] = false
        end

        -- move
        local freqDev = 165
        pEnemies.x = pEnemies.x + pEnemies.vx * freqDev * dt
        pEnemies.y = pEnemies.y + pEnemies.vy * freqDev * dt

        -- cap speed
        if math.abs(pEnemies.vx) > pEnemies.speed / 2 then
            if pEnemies.vx > 0 then
                pEnemies.vx = pEnemies.speed / 2
            else
                pEnemies.vx = -pEnemies.speed / 2
            end
        end
        if math.abs(pEnemies.vy) > pEnemies.speed / 2 then
            if pEnemies.vy > 0 then
                pEnemies.vy = pEnemies.speed / 2
            else
                pEnemies.vy = -pEnemies.speed / 2
            end
        end

        --changer de bords
        if pEnemies.x < -pEnemies.rHitbox then
            pEnemies.x = windowDimensions.width + pEnemies.rHitbox
        elseif pEnemies.x > windowDimensions.width + pEnemies.rHitbox then
            pEnemies.x = 0 - pEnemies.rHitbox
        end
        if pEnemies.y < -pEnemies.rHitbox then
            pEnemies.y = windowDimensions.height + pEnemies.rHitbox
        elseif pEnemies.y > windowDimensions.height + pEnemies.rHitbox then
            pEnemies.y = 0 - pEnemies.rHitbox
        end
    end

    ----------------------------------------
    ---------|QUAND L'ENNEMI FUIT|----------
    ----------------------------------------
    if pEnemies.state == "evasion" then
        ANGLE_ENEMY = math.angle(pEnemies.x, pEnemies.y, windowDimensions.width * 2, windowDimensions.height / 2)
        pEnemies.r = ANGLE_ENEMY
        if pEnemies.r > math.rad(360) then
            pEnemies.r = 0
        end
        if pEnemies.r < math.rad(-360) then
            pEnemies.r = 0
        end

        if math.abs(ship.vx) > 0 and math.abs(ship.vy) > 0 then
            -- Mouvements avec vecteurs bidimensionnels
            local force_x = math.cos(pEnemies.r) * (pEnemies.speed * dt)
            local force_y = math.sin(pEnemies.r) * (pEnemies.speed * dt)
            pEnemies.vx = pEnemies.vx + force_x * 2
            pEnemies.vy = pEnemies.vy + force_y * 2

            -- anim propulseurs
            pEnemies.jet["frame"] =
                spriteUpdate(pEnemies.jet["quads"], pEnemies.jet["frame"], pEnemies.jet["updateTime"], dt)
            pEnemies.jet["on"] = true
        else
            pEnemies.jet["on"] = false
        end

        -- actualisation de la pos
        local freqDev = 165
        pEnemies.x = pEnemies.x + pEnemies.vx * freqDev * dt
        pEnemies.y = pEnemies.y + pEnemies.vy * freqDev * dt

        -- cap speed
        if math.abs(pEnemies.vx) > pEnemies.speed then
            if pEnemies.vx > 0 then
                pEnemies.vx = pEnemies.speed
            else
                pEnemies.vx = -pEnemies.speed
            end
        end
        if math.abs(pEnemies.vy) > pEnemies.speed then
            if pEnemies.vy > 0 then
                pEnemies.vy = pEnemies.speed
            else
                pEnemies.vy = -pEnemies.speed
            end
        end
    end
end
---------------------------------------------------------------------------------------------------------------------
-----------------------------------------------|DRAWING ENEMY|-------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
function enemies.drawTir(pEnemies)
    for _, v in ipairs(SHOTSFIRED) do
        spriteDraw(v.img, v.quads, v.frame, v.x, v.y, v.r + math.rad(90), 1, 1, v.ox, v.oy)
        spriteDraw(
            pEnemies["weapons"]["img"],
            pEnemies["weapons"]["quads"],
            pEnemies["weapons"]["frame"],
            pEnemies.x,
            pEnemies.y,
            pEnemies.r + math.rad(90),
            1,
            1,
            pEnemies.ox,
            pEnemies.oy
        )
        --collisions.TestCol(v, dt)
    end
end

function enemies.drawEnemies(pEnemies)
    if pEnemies.jet["on"] == true then
        spriteDraw(
            pEnemies.jet["img"],
            pEnemies.jet["quads"],
            pEnemies.jet["frame"],
            pEnemies.x,
            pEnemies.y,
            pEnemies.r + math.rad(90),
            1,
            1,
            pEnemies.ox,
            pEnemies.oy
        )
    end
    love.graphics.draw(pEnemies.img, pEnemies.x, pEnemies.y, pEnemies.r + math.rad(90), 1, 1, pEnemies.ox, pEnemies.oy)
end
---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
return enemies
