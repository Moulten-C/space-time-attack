-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

--love.graphics.setDefaultFilter("nearest", "nearest")
love.window.setTitle("Space Time Attack")
love.window.setMode(1000, 750, {resizable = false, vsync = true, minwidth = 400, minheight = 300})

local menu = require("menu")
local ship = require("ship")
local engine = require("engine")
local shield = require("shield")
local enemies = require("enemies")
local etoiles = require("etoiles")
local collisions = require("collisions")
--local bonus = require("bonus")            --non terminé
--local checkpoint = require("checkpoint")  --non terminé

windowDimensions = {}
windowDimensions.width = love.graphics.getWidth()
windowDimensions.height = love.graphics.getHeight()

SCREEN = "menu"
RUNNING_TIME = 0
HIGHSCORE = 0
SFX = {}
MUSIC = {}
MASTER_VOLUME = 0.5
MUSIC_VOLUME = 0.5
SFX_VOLUME = 0.2

local activeEnemy = {}

------------------------------------------------------------------------------------------------------------
function love.load()
    planet = {}
    planet.img = love.graphics.newImage("libraries/Backgrounds/Earth-Like planet.png")
    planet.frame = 0
    planet.quads = spriteQuads(planet.img)
    planet.time = 0

    SFX.hit = love.audio.newSource("libraries/Ennemies/BLLTRico_Metallic_11.wav", "static")
    SFX.rocket = love.audio.newSource("libraries/Ennemies/GUNArtl_Rocket Launcher Fire_02.wav", "static")
    SFX.beam = love.audio.newSource("libraries/Ennemies/LASRBeam_Plasma Loop_01.wav", "static")
    SFX.bullet = love.audio.newSource("libraries/Ennemies/LASRGun_Classic Blaster A Fire_03.wav", "static")
    SFX.spinner = love.audio.newSource("libraries/Ennemies/LASRGun_Particle Compressor Fire_01.wav", "static")

    MUSIC.OST1 = love.audio.newSource("libraries/OST/Gravity in Motion.mp3", "stream")
    MUSIC.OST2 = love.audio.newSource("libraries/OST/SOR Bosslike.mp3", "stream")
end
------------------------------------------------------------------------------------------------------------

------------------------------------------------------
---------------------|PAUSE KEY|----------------------
------------------------------------------------------
function love.keypressed(key)
    if SCREEN == "game" then
        if key == "escape" then
            SCREEN = "pause"
        end
    elseif SCREEN == "pause" then
        if key == "escape" then
            SCREEN = "game"
        end
    end
end
------------------------------------------------------------------------------------------------------------
function love.update(dt)
    fps = love.timer.getFPS()

    for _, v in pairs(SFX) do
        v:setVolume(MASTER_VOLUME * SFX_VOLUME)
    end
    for _, v in pairs(MUSIC) do
        v:setVolume(MASTER_VOLUME * MUSIC_VOLUME)
    end

    if SCREEN == "menu" or SCREEN == "options" then
        love.audio.stop(MUSIC["OST1"])
        love.audio.play(MUSIC["OST2"])
    elseif SCREEN == "game" then
        love.audio.stop(MUSIC["OST2"])
        love.audio.play(MUSIC["OST1"])
    end

    ------------------------------------------------------
    -----------------------|SCREEN|-----------------------
    ------------------------------------------------------
    if SCREEN == "menu" then
        menuUpdate()
        ------------------------------------------------------
        --------------------|RESET VALUES|--------------------
        ------------------------------------------------------
        RUNNING_TIME = 0
        ship.x = love.graphics.getWidth() / 2
        ship.y = love.graphics.getHeight() / 2
        ship.r = 0
        ship.vx = 0
        ship.vy = 0
        ship.hp = 100
        shield.hp = 100
        enemies.scout["vx"] = 0
        enemies.scout["vy"] = 0
        enemies.scout["rand"] = math.floor(love.math.random(0, 2))
        if enemies.scout["rand"] <= 1 then
            enemies.scout["y"] = -100
        elseif enemies.scout["rand"] > 1 then
            enemies.scout["y"] = windowDimensions.height + 100
        end
        for k, _ in pairs(SHOTSFIRED) do
            SHOTSFIRED[k] = nil
        end
        ------------------------------------------------------
        if menu.play["check"]["click"] == true then
            SCREEN = "game"
        end
        if menu.options["check"]["click"] == true then
            SCREEN = "options"
        end
        if menu.quit["check"]["click"] == true then
            love.event.quit()
        end
    end
    if ship.hp <= 0 then
        SCREEN = "scoreboard"
        ship.hp = 100
        shield.hp = 100
    end
    if SCREEN == "options" then
        optionsUpdate()
    elseif SCREEN == "pause" then
        pauseUpdate()
    elseif SCREEN == "scoreboard" then
        scoreboardUpdate()
        if RUNNING_TIME > HIGHSCORE then
            HIGHSCORE = RUNNING_TIME
        end
    end
    --print("SCREEN : " .. tostring(SCREEN))

    ------------------------------------------------------
    -----------------------|GAME|-------------------------
    ------------------------------------------------------
    if SCREEN == "game" then
        if math.abs(ship.vx) > 0 and math.abs(ship.vy) > 0 then
            RUNNING_TIME = RUNNING_TIME + dt
        end
        ------------------------------------------------------
        ------------|GESTION DE L'ETAT DE L'ENNEMI|-----------
        ------------------------------------------------------
        if RUNNING_TIME <= 30 then
            activeEnemy.state = "track"
            enemies.scout["active"] = true
            activeEnemy = enemies.scout
        elseif RUNNING_TIME > 30 and RUNNING_TIME <= 35 then
            activeEnemy.state = "evasion"
        elseif RUNNING_TIME > 35 and RUNNING_TIME <= 65 then
            if activeEnemy.x >= windowDimensions.width then
                activeEnemy.state = "track"
                enemies.frigate["active"] = true
                activeEnemy = enemies.frigate
            end
        elseif RUNNING_TIME > 65 and RUNNING_TIME <= 70 then
            activeEnemy.state = "evasion"
        elseif RUNNING_TIME > 70 and RUNNING_TIME <= 100 then
            if activeEnemy.x >= windowDimensions.width then
                enemies.battlecruiser["active"] = true
                activeEnemy = enemies.battlecruiser
            end
        elseif RUNNING_TIME > 100 and RUNNING_TIME <= 105 then
            activeEnemy.state = "evasion"
            if activeEnemy.x > windowDimensions.width then
                SCREEN = "menu"
            end
        elseif RUNNING_TIME > 105 then
            SCREEN = "scoreboard"
        -- elseif RUNNING_TIME > 105 and RUNNING_TIME <= 135 then
        --     if activeEnemy.x >= windowDimensions.width then
        --         enemies.dreadnought["active"] = true
        --         activeEnemy = enemies.dreadnought
        --     end
        end
        ------------------------------------------------------
        -----------------------|JOUEUR|-----------------------
        ------------------------------------------------------
        ship.move(dt)
        engine.power(dt)
        shield.move(dt)
        ------------------------------------------------------
        -----------------------|ENNEMI|-----------------------
        ------------------------------------------------------
        enemies.move(activeEnemy, dt)
        enemies.createShot(activeEnemy, dt)
        enemies.updateShot(activeEnemy, dt)
        ------------------------------------------------------
        ----------------|COLLISIONS VAISSEAUX|----------------
        ------------------------------------------------------
        collisions.shield(activeEnemy, dt)
        collisions.ship(activeEnemy, dt)
    ------------------------------------------------------
    -----------------------|BONUS|------------------------
    ------------------------------------------------------
    --AddBonus(dt)
    --bonus.update(activeBonus, dt)
    end
    ------------------------------------------------------
    ---------------------|BACKGROUND|---------------------
    ------------------------------------------------------
    etoiles.update(dt)
end
------------------------------------------------------------------------------------------------------------
function love.draw()
    ------------------------------------------------------
    ---------------------|BACKGROUND|---------------------
    ------------------------------------------------------
    --planet.frame = spriteUpdate(planet.quads, planet.frame, planet.time, dt)      -- debug
    --spriteDraw(planet.img, planet.quads, planet.frame, 100, 100, 1, 1, 1, 1, 1)   -- debug
    etoiles.draw()
    ------------------------------------------------------
    ----------------------|IN GAME|-----------------------
    ------------------------------------------------------
    if SCREEN == "game" then
        ------------------------------------------------------
        ---------------------|MONITORING|---------------------
        ------------------------------------------------------
        -- love.graphics.print("vx : " .. tostring(ship.vx), 0, 10)
        -- love.graphics.print("vy : " .. tostring(ship.vy), 0, 20)
        -- love.graphics.print("angle vaisseau : " .. tostring(ship.r), 0, 40)
        -- love.graphics.print("angle bouclier : " .. tostring(math.deg(shield.rt)), 0, 0)
        -- love.graphics.print("angle ennemi : " .. tostring(math.deg(activeEnemy.r) + 90), 0, 30)
        -- love.graphics.print("fps : " .. tostring(fps), 0, 80)
        -- love.graphics.print("mouse x,y : " .. tostring(love.mouse.getX() .. " " .. love.mouse.getY()), 0, 90)
        -- collisions.TestCol(activeEnemy, dt)

        ------------------------------------------------------
        -----------------------|JOUEUR|-----------------------
        ------------------------------------------------------
        engine.DrawEngine()
        ship.Draw()
        shield.Draw()
        ------------------------------------------------------
        -----------------------|ENNEMI|-----------------------
        ------------------------------------------------------
        enemies.drawEnemies(activeEnemy)
        enemies.drawTir(activeEnemy)
        ------------------------------------------------------
        -----------------------|BONUS|------------------------
        ------------------------------------------------------
        --bonus.draw()
        ------------------------------------------------------
        ---------------------|HEALTH BAR|---------------------
        ------------------------------------------------------
        love.graphics.setColor(255, 0, 0)
        love.graphics.rectangle("fill", 0, windowDimensions.height - 10, 1000, 5)
        if ship.hp > 0 then
            love.graphics.setColor(0, 255, 0)
            love.graphics.rectangle("fill", 0, windowDimensions.height - 10, ship.hp * 10, 5)
        end
        love.graphics.setColor(255, 255, 255)
        ------------------------------------------------------
        ---------------------|ENERGY BAR|---------------------
        ------------------------------------------------------
        love.graphics.setColor(255, 0, 0)
        love.graphics.rectangle("fill", 0, windowDimensions.height - 20, 1000, 5)
        if shield.hp > 0 then
            love.graphics.setColor(0, 0, 255)
            love.graphics.rectangle("fill", 0, windowDimensions.height - 20, shield.hp * 10, 5)
        end
        love.graphics.setColor(255, 255, 255)
        ------------------------------------------------------
        -----------------------|TIMER|------------------------
        ------------------------------------------------------
        local font = love.graphics.newFont("libraries/Fonts/Robtronika-Regular.ttf", 20)
        local text = love.graphics.newText(font, tostring(math.ceil(RUNNING_TIME * 100) / 100))
        love.graphics.draw(text, windowDimensions.width / 2, 20, 0, 1, 1, 50, 10)
    elseif SCREEN == "menu" then
        menuDraw()
    elseif SCREEN == "options" then
        optionsDraw()
    elseif SCREEN == "pause" then
        pauseDraw()
    elseif SCREEN == "scoreboard" then
        scoreboardDraw()
    end
end
