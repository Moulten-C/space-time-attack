local collisions = {}
local ship = require("ship")
local shield = require("shield")

function math.dist(x1, y1, x2, y2)
    return ((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ^ 0.5
end

collide = {}
collide.ship = false
collide.shield = false
---------------------------------------------------------------------------------------------------------------------
----------------------------------------------|COLLISIONS BETWEEN SHIPS|---------------------------------------------
---------------------------------------------------------------------------------------------------------------------
function collisions.ship(pEntity, dt)
    local distCol = math.dist(ship.x, ship.y, pEntity.x, pEntity.y)
    local angleAttaque = math.angle(ship.x, ship.y, pEntity.x, pEntity.y)
    if distCol - pEntity.rHitbox <= ship.rHitbox then
        collide.ship = true
        love.audio.stop(SFX.hit)
        love.audio.play(SFX.hit)
    else
        collide.ship = false
    end
    if collide.ship == true then
        -- rebond de l'ennemi
        pEntity.vx = -0.8 * pEntity.vx
        pEntity.vy = -0.8 * pEntity.vy
        -- replacement de l'ennemi
        pEntity.x = pEntity.x + math.cos(angleAttaque) * (distCol - pEntity.rHitbox)
        pEntity.y = pEntity.y + math.sin(angleAttaque) * (distCol - pEntity.rHitbox)
        ship.hp = ship.hp - 20
    -- ship.vx = -0.5 * ship.vx
    -- ship.vy = -0.5 * ship.vy
    end
    if collide.ship == true and collide.shield == true then
        collide.ship = false
    end
end

function collisions.shield(pEntity, dt)
    local distCol = math.dist(ship.x, ship.y, pEntity.x, pEntity.y)
    local angleAttaque = math.angle(ship.x, ship.y, pEntity.x, pEntity.y)
    if shield.hp > 0 then
        if distCol - pEntity.rHitbox <= shield.rHitbox then
            if
                -- check si l'angle d'attaque de l'entité est dans le cône d'action du bouclier
                math.abs(angleAttaque) >= math.abs(shield.rt) - math.rad(45) and
                    math.abs(angleAttaque) <= math.abs(shield.rt) + math.rad(45)
             then
                collide.shield = true
            end
            if collide.ship == true and collide.shield == true then
                collide.ship = false
            end
            if collide.shield == true then
                -- rebond de l'ennemi
                pEntity.vx = -0.8 * pEntity.vx
                pEntity.vy = -0.8 * pEntity.vy
                -- replacement de l'ennemi
                pEntity.x = pEntity.x + math.cos(angleAttaque) * (distCol - pEntity.rHitbox)
                pEntity.y = pEntity.y + math.sin(angleAttaque) * (distCol - pEntity.rHitbox)

                shield.hp = shield.hp - 20
            end
        elseif distCol - pEntity.rHitbox > shield.rHitbox then
            collide.shield = false
        -- ship.vx = -0.5 * ship.vx
        -- ship.vy = -0.5 * ship.vy
        end
    end
    angleAttEnnemi = angleAttaque
end
---------------------------------------------------------------------------------------------------------------------
------------------------------------------------|COLLISIONS WITH SHOTS|----------------------------------------------
---------------------------------------------------------------------------------------------------------------------
function collisions.ammoShip(pListShots, pShot, dt)
    local distCol = math.dist(ship.x, ship.y, pShot.x, pShot.y)
    local angleAttaque = math.angle(ship.x, ship.y, pShot.x, pShot.y)
    if distCol - pShot.rHitbox <= ship.rHitbox then
        collide.ship = true
    else
        collide.ship = false
    end
    if collide.ship == true and collide.shield == true then
        collide.ship = false
    end
    return collide.ship
end

function collisions.ammoShield(pListShots, pShot, dt)
    local distCol = math.dist(ship.x, ship.y, pShot.x, pShot.y)
    local angleAttaque = math.angle(ship.x, ship.y, pShot.x, pShot.y)

    if distCol - pShot.rHitbox <= shield.rHitbox then
        if
            -- check si l'angle d'attaque de l'entité est dans le cône d'action du bouclier
            math.abs(angleAttaque) >= math.abs(shield.rt) - math.rad(45) and
                math.abs(angleAttaque) <= math.abs(shield.rt) + math.rad(45)
         then
            collide.shield = true
        end
        if collide.ship == true and collide.shield == true then
            collide.ship = false
        end
    elseif distCol - pShot.rHitbox > shield.rHitbox then
        collide.shield = false
    -- ship.vx = -0.5 * ship.vx
    -- ship.vy = -0.5 * ship.vy
    end

    angleAttEnnemi = angleAttaque
    return collide.shield
end

function collisions.TestCol(pEntity, dt)
    -- if collide.shield == true or collide.ship == true then
    --     love.graphics.setColor(1, 0, 0)
    --     love.graphics.circle("line", pEntity.x, pEntity.y, pEntity.rHitbox)
    -- else
    --     love.graphics.setColor(1, 1, 1)
    --     love.graphics.circle("line", pEntity.x, pEntity.y, pEntity.rHitbox)
    -- end
    -- if collide.shield == true then
    --     love.graphics.setColor(1, 0, 0)
    --     love.graphics.circle("line", ship.x, ship.y, shield.rHitbox)
    -- else
    --     love.graphics.setColor(1, 1, 1)
    --     love.graphics.circle("line", ship.x, ship.y, shield.rHitbox)
    -- end
    -- if collide.ship == true then
    --     love.graphics.setColor(1, 0, 0)
    --     love.graphics.circle("line", ship.x, ship.y, ship.rHitbox)
    -- else
    --     love.graphics.setColor(1, 1, 1)
    --     love.graphics.circle("line", ship.x, ship.y, ship.rHitbox)
    -- end
    love.graphics.print("Angle d'attaque ennemi : " .. tostring(math.deg(angleAttEnnemi)), 0, 70)
    love.graphics.print("collision ship: " .. tostring(collide.ship), 0, 60)
    love.graphics.print("collision shield: " .. tostring(collide.shield), 0, 50)
end

return collisions
