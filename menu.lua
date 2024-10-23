local buttons = {}

windowDimensions = {}
windowDimensions.width = love.graphics.getWidth()
windowDimensions.height = love.graphics.getHeight()

---------------------------------------------------------------------------------------------------------------------
-------------------------------------------------|BUTTONS PARAMETERS|------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
buttons.play = {}
buttons.options = {}
buttons.quit = {}
buttons.menu = {}
buttons.back = {}

buttons.genPlus = {}
buttons.genMinus = {}
buttons.sfxPlus = {}
buttons.sfxMinus = {}
buttons.musicPlus = {}
buttons.musicMinus = {}

buttons.img = {}
buttons.img["neutral"] = love.graphics.newImage("libraries/Menu/Button Normal.png")
buttons.img["hover"] = love.graphics.newImage("libraries/Menu/Button Hover.png")
buttons.img["click"] = love.graphics.newImage("libraries/Menu/Button Active.png")
buttons.width = buttons.img["neutral"]:getWidth()
buttons.height = buttons.img["neutral"]:getHeight()
buttons.scale = 2

buttons.play["check"] = false
buttons.play["x"] = windowDimensions.width / 2
buttons.play["y"] = 300

buttons.options["check"] = false
buttons.options["x"] = windowDimensions.width / 2
buttons.options["y"] = 400

buttons.quit["check"] = false
buttons.quit["x"] = windowDimensions.width / 2
buttons.quit["y"] = 500

buttons.menu["check"] = false
buttons.menu["x"] = windowDimensions.width * 0.15
buttons.menu["y"] = windowDimensions.height * 0.1

buttons.back["check"] = false
buttons.back["x"] = windowDimensions.width * 0.15
buttons.back["y"] = windowDimensions.height * 0.1

buttons.genPlus["check"] = false
buttons.genPlus["x"] = windowDimensions.width * 0.27
buttons.genPlus["y"] = windowDimensions.height * 0.85

buttons.genMinus["check"] = false
buttons.genMinus["x"] = windowDimensions.width * 0.14
buttons.genMinus["y"] = windowDimensions.height * 0.85

buttons.sfxPlus["check"] = false
buttons.sfxPlus["x"] = windowDimensions.width * 0.57
buttons.sfxPlus["y"] = windowDimensions.height * 0.85

buttons.sfxMinus["check"] = false
buttons.sfxMinus["x"] = windowDimensions.width * 0.44
buttons.sfxMinus["y"] = windowDimensions.height * 0.85

buttons.musicPlus["check"] = false
buttons.musicPlus["x"] = windowDimensions.width * 0.87
buttons.musicPlus["y"] = windowDimensions.height * 0.85

buttons.musicMinus["check"] = false
buttons.musicMinus["x"] = windowDimensions.width * 0.74
buttons.musicMinus["y"] = windowDimensions.height * 0.85

---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------|BUTTONS FUNCTIONS|------------------------------------------------
---------------------------------------------------------------------------------------------------------------------

function checkMouseButton(pButtonImg, pButtonScale, pButtonX, pButtonY)
    local mx, my = love.mouse.getPosition()
    local buttonCheck = {}
    buttonCheck.hover = false
    buttonCheck.click = false
    if
        mx > pButtonX - pButtonScale * pButtonImg:getWidth() / 2 and
            mx < pButtonX + pButtonScale * pButtonImg:getWidth() / 2
     then
        if
            my < pButtonY + pButtonScale * pButtonImg:getHeight() / 2 and
                my > pButtonY - pButtonScale * pButtonImg:getHeight() / 2
         then
            buttonCheck.hover = true
        else
            buttonCheck.hover = false
        end
    end
    if buttonCheck.hover == true and love.mouse.isDown(1) then
        buttonCheck.click = true
    else
        buttonCheck.click = false
    end
    return buttonCheck
end

function drawButton(pName, pImg, pX, pY, pScale)
    love.graphics.draw(pImg, pX, pY, 0, pScale, pScale, pImg:getWidth() / 2, pImg:getHeight() / 2)
    local font = love.graphics.newFont("libraries/Fonts/Robtronika-Regular.ttf", 20)
    local text = love.graphics.newText(font, pName)
    love.graphics.draw(text, pX, pY, 0, 1, 1, text:getWidth() / 2, text:getHeight() / 2)
end
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------|MENU|-------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
function menuUpdate()
    buttons.play["check"] =
        checkMouseButton(buttons.img["neutral"], buttons.scale, buttons.play["x"], buttons.play["y"])
    buttons.options["check"] =
        checkMouseButton(buttons.img["neutral"], buttons.scale, buttons.options["x"], buttons.options["y"])
    buttons.quit["check"] =
        checkMouseButton(buttons.img["neutral"], buttons.scale, buttons.quit["x"], buttons.quit["y"])
end

function menuDraw()
    local font = love.graphics.newFont("libraries/Fonts/Robtronika-Regular.ttf", 20)
    local score = love.graphics.newText(font, "HIGHSCORE : " .. tostring(math.ceil(HIGHSCORE * 100) / 100))
    local keys = love.graphics.newText(font, "MOVE SHIP : ZQSD\n \nMOVE SHIELD : MOUSE")
    love.graphics.draw(
        keys,
        windowDimensions.width * 0.5,
        windowDimensions.height * 0.85,
        0,
        1,
        1,
        keys:getWidth() / 2,
        keys:getHeight() / 2
    )
    love.graphics.draw(
        score,
        windowDimensions.width * 0.5,
        windowDimensions.height * 0.2,
        0,
        1,
        1,
        score:getWidth() / 2,
        score:getHeight() / 2
    )
    if buttons.play["check"]["hover"] == true then
        if buttons.play["check"]["click"] == true then
            drawButton("PLAY", buttons.img["click"], buttons.play["x"], buttons.play["y"], buttons.scale)
        else
            drawButton("PLAY", buttons.img["hover"], buttons.play["x"], buttons.play["y"], buttons.scale)
        end
    else
        drawButton("PLAY", buttons.img["neutral"], buttons.play["x"], buttons.play["y"], buttons.scale)
    end
    if buttons.options["check"]["hover"] == true then
        if buttons.options["check"]["click"] == true then
            drawButton("OPTIONS", buttons.img["click"], buttons.options["x"], buttons.options["y"], buttons.scale)
        else
            drawButton("OPTIONS", buttons.img["hover"], buttons.options["x"], buttons.options["y"], buttons.scale)
        end
    else
        drawButton("OPTIONS", buttons.img["neutral"], buttons.options["x"], buttons.options["y"], buttons.scale)
    end
    if buttons.quit["check"]["hover"] == true then
        if buttons.quit["check"]["click"] == true then
            drawButton("QUIT", buttons.img["click"], buttons.quit["x"], buttons.quit["y"], buttons.scale)
        else
            drawButton("QUIT", buttons.img["hover"], buttons.quit["x"], buttons.quit["y"], buttons.scale)
        end
    else
        drawButton("QUIT", buttons.img["neutral"], buttons.quit["x"], buttons.quit["y"], buttons.scale)
    end
end
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------|OPTIONS|----------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
function optionsUpdate()
    buttons.genPlus["check"] = checkMouseButton(buttons.img["neutral"], 1, buttons.genPlus["x"], buttons.genPlus["y"])
    buttons.genMinus["check"] =
        checkMouseButton(buttons.img["neutral"], 1, buttons.genMinus["x"], buttons.genMinus["y"])
    buttons.sfxPlus["check"] = checkMouseButton(buttons.img["neutral"], 1, buttons.sfxPlus["x"], buttons.sfxPlus["y"])
    buttons.sfxMinus["check"] =
        checkMouseButton(buttons.img["neutral"], 1, buttons.sfxMinus["x"], buttons.sfxMinus["y"])
    buttons.musicPlus["check"] =
        checkMouseButton(buttons.img["neutral"], 1, buttons.musicPlus["x"], buttons.musicPlus["y"])
    buttons.musicMinus["check"] =
        checkMouseButton(buttons.img["neutral"], 1, buttons.musicMinus["x"], buttons.musicMinus["y"])
    buttons.menu["check"] =
        checkMouseButton(buttons.img["neutral"], buttons.scale, buttons.menu["x"], buttons.menu["y"])

    if buttons.genPlus["check"]["click"] == true and MASTER_VOLUME <= 0.99 then
        MASTER_VOLUME = MASTER_VOLUME + 0.01
    elseif buttons.genMinus["check"]["click"] == true and MASTER_VOLUME >= 0.01 then
        MASTER_VOLUME = MASTER_VOLUME - 0.01
    elseif buttons.sfxPlus["check"]["click"] == true and SFX_VOLUME <= 0.99 then
        SFX_VOLUME = SFX_VOLUME + 0.01
    elseif buttons.sfxMinus["check"]["click"] == true and SFX_VOLUME >= 0.01 then
        SFX_VOLUME = SFX_VOLUME - 0.01
    elseif buttons.musicPlus["check"]["click"] == true and MUSIC_VOLUME <= 0.99 then
        MUSIC_VOLUME = MUSIC_VOLUME + 0.01
    elseif buttons.musicMinus["check"]["click"] == true and MUSIC_VOLUME >= 0.01 then
        MUSIC_VOLUME = MUSIC_VOLUME - 0.01
    elseif buttons.menu["check"]["click"] == true then
        SCREEN = "menu"
    end
end

function optionsDraw()
    local fontTitle = love.graphics.newFont("libraries/Fonts/Robtronika-Regular.ttf", 20)
    local font = love.graphics.newFont("libraries/Fonts/Robtronika-Regular.ttf", 12)
    local vol = love.graphics.newText(fontTitle, "VOLUME")
    local gen = love.graphics.newText(font, tostring("Master : " .. math.ceil(MASTER_VOLUME * 100) .. " %"))
    local sfx = love.graphics.newText(font, tostring("Effects : " .. math.ceil(SFX_VOLUME * 100) .. " %"))
    local music = love.graphics.newText(font, tostring("Music : " .. math.ceil(MUSIC_VOLUME * 100) .. " %"))
    local menu = love.graphics.newText(fontTitle, "MENU")
    ------------------------------------------
    -------------|DRAW MENU BUTTON|-----------
    ------------------------------------------
    if buttons.menu["check"]["hover"] == true then
        if buttons.menu["check"]["click"] == true then
            drawButton("menu", buttons.img["click"], buttons.menu["x"], buttons.menu["y"], buttons.scale)
        else
            drawButton("menu", buttons.img["hover"], buttons.menu["x"], buttons.menu["y"], buttons.scale)
        end
    else
        drawButton("menu", buttons.img["neutral"], buttons.menu["x"], buttons.menu["y"], buttons.scale)
    end
    ------------------------------------------
    ---------------|TITLE VOLUME|-------------
    ------------------------------------------
    love.graphics.draw(
        vol,
        windowDimensions.width * 0.5,
        windowDimensions.height * 0.2,
        0,
        1,
        1,
        vol:getWidth() / 2,
        vol:getHeight() / 2
    )
    -------------------------------------------
    --------|DRAW MASTER VOLUME BUTTONS|-------
    -------------------------------------------
    love.graphics.draw(
        gen,
        windowDimensions.width * 0.2,
        windowDimensions.height * 0.8,
        0,
        1,
        1,
        gen:getWidth() / 2,
        gen:getHeight() / 2
    )
    love.graphics.rectangle(
        "fill",
        windowDimensions.width * 0.2,
        windowDimensions.height * 0.7,
        10,
        -300 * MASTER_VOLUME
    )

    -- draw clicks
    if buttons.genPlus["check"]["hover"] == true then
        if buttons.genPlus["check"]["click"] == true then
            drawButton("+", buttons.img["click"], buttons.genPlus["x"], buttons.genPlus["y"], 1)
        else
            drawButton("+", buttons.img["hover"], buttons.genPlus["x"], buttons.genPlus["y"], 1)
        end
    else
        drawButton("+", buttons.img["neutral"], buttons.genPlus["x"], buttons.genPlus["y"], 1)
    end
    if buttons.genMinus["check"]["hover"] == true then
        if buttons.genMinus["check"]["click"] == true then
            drawButton("-", buttons.img["click"], buttons.genMinus["x"], buttons.genMinus["y"], 1)
        else
            drawButton("-", buttons.img["hover"], buttons.genMinus["x"], buttons.genMinus["y"], 1)
        end
    else
        drawButton("-", buttons.img["neutral"], buttons.genMinus["x"], buttons.genMinus["y"], 1)
    end
    ------------------------------------------
    -------------|DRAW SFX BUTTONS|-----------
    ------------------------------------------
    love.graphics.draw(
        sfx,
        windowDimensions.width * 0.5,
        windowDimensions.height * 0.8,
        0,
        1,
        1,
        sfx:getWidth() / 2,
        sfx:getHeight() / 2
    )
    love.graphics.rectangle("fill", windowDimensions.width * 0.5, windowDimensions.height * 0.7, 10, -300 * SFX_VOLUME)

    -- draw clicks
    if buttons.sfxPlus["check"]["hover"] == true then
        if buttons.sfxPlus["check"]["click"] == true then
            drawButton("+", buttons.img["click"], buttons.sfxPlus["x"], buttons.sfxPlus["y"], 1)
        else
            drawButton("+", buttons.img["hover"], buttons.sfxPlus["x"], buttons.sfxPlus["y"], 1)
        end
    else
        drawButton("+", buttons.img["neutral"], buttons.sfxPlus["x"], buttons.sfxPlus["y"], 1)
    end
    if buttons.sfxMinus["check"]["hover"] == true then
        if buttons.sfxMinus["check"]["click"] == true then
            drawButton("-", buttons.img["click"], buttons.sfxMinus["x"], buttons.sfxMinus["y"], 1)
        else
            drawButton("-", buttons.img["hover"], buttons.sfxMinus["x"], buttons.sfxMinus["y"], 1)
        end
    else
        drawButton("-", buttons.img["neutral"], buttons.sfxMinus["x"], buttons.sfxMinus["y"], 1)
    end
    ------------------------------------------
    ------------|DRAW MUSIC BUTTONS|----------
    ------------------------------------------
    love.graphics.draw(
        music,
        windowDimensions.width * 0.8,
        windowDimensions.height * 0.8,
        0,
        1,
        1,
        music:getWidth() / 2,
        music:getHeight() / 2
    )

    love.graphics.rectangle(
        "fill",
        windowDimensions.width * 0.8,
        windowDimensions.height * 0.7,
        10,
        -300 * MUSIC_VOLUME
    )

    -- draw clicks
    if buttons.musicPlus["check"]["hover"] == true then
        if buttons.musicPlus["check"]["click"] == true then
            drawButton("+", buttons.img["click"], buttons.musicPlus["x"], buttons.musicPlus["y"], 1)
        else
            drawButton("+", buttons.img["hover"], buttons.musicPlus["x"], buttons.musicPlus["y"], 1)
        end
    else
        drawButton("+", buttons.img["neutral"], buttons.musicPlus["x"], buttons.musicPlus["y"], 1)
    end
    if buttons.musicMinus["check"]["hover"] == true then
        if buttons.musicMinus["check"]["click"] == true then
            drawButton("-", buttons.img["click"], buttons.musicMinus["x"], buttons.musicMinus["y"], 1)
        else
            drawButton("-", buttons.img["hover"], buttons.musicMinus["x"], buttons.musicMinus["y"], 1)
        end
    else
        drawButton("-", buttons.img["neutral"], buttons.musicMinus["x"], buttons.musicMinus["y"], 1)
    end
end
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------|PAUSE|------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
function pauseUpdate()
    buttons.back["check"] =
        checkMouseButton(buttons.img["neutral"], buttons.scale, buttons.back["x"], buttons.back["y"])
    if buttons.back["check"]["click"] == true then
        SCREEN = "menu"
    end
end

function pauseDraw()
    local fontTitle = love.graphics.newFont("libraries/Fonts/Robtronika-Regular.ttf", 20)
    local font = love.graphics.newFont("libraries/Fonts/Robtronika-Regular.ttf", 12)
    local pause = love.graphics.newText(fontTitle, "PAUSE")
    local time = love.graphics.newText(fontTitle, tostring(math.ceil(RUNNING_TIME * 100) / 100))
    love.graphics.draw(
        pause,
        windowDimensions.width * 0.5,
        windowDimensions.height * 0.4,
        0,
        1,
        1,
        pause:getWidth() / 2,
        pause:getHeight() / 2
    )
    love.graphics.draw(
        time,
        windowDimensions.width * 0.5,
        windowDimensions.height * 0.5,
        0,
        1,
        1,
        time:getWidth() / 2,
        time:getHeight() / 2
    )
    if buttons.back["check"]["hover"] == true then
        if buttons.back["check"]["click"] == true then
            drawButton("menu", buttons.img["click"], buttons.back["x"], buttons.back["y"], buttons.scale)
        else
            drawButton("menu", buttons.img["hover"], buttons.back["x"], buttons.back["y"], buttons.scale)
        end
    else
        drawButton("menu", buttons.img["neutral"], buttons.back["x"], buttons.back["y"], buttons.scale)
    end
end
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------|GAMEOVER|------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
function scoreboardUpdate()
    buttons.back["check"] =
        checkMouseButton(buttons.img["neutral"], buttons.scale, buttons.back["x"], buttons.back["y"])
    if buttons.back["check"]["click"] == true then
        SCREEN = "menu"
    end
end

function scoreboardDraw()
    local fontTitle = love.graphics.newFont("libraries/Fonts/Robtronika-Regular.ttf", 20)
    local font = love.graphics.newFont("libraries/Fonts/Robtronika-Regular.ttf", 12)
    local gameover = love.graphics.newText(fontTitle, "YOU DIED")
    local win = love.graphics.newText(fontTitle, "YOU ESCAPED !!")
    local time = love.graphics.newText(fontTitle, tostring(math.ceil(RUNNING_TIME * 100) / 100))
    if RUNNING_TIME < 105 then
        love.graphics.draw(
            gameover,
            windowDimensions.width * 0.5,
            windowDimensions.height * 0.4,
            0,
            1,
            1,
            gameover:getWidth() / 2,
            gameover:getHeight() / 2
        )
    else
        love.graphics.draw(
            win,
            windowDimensions.width * 0.5,
            windowDimensions.height * 0.4,
            0,
            1,
            1,
            gameover:getWidth() / 2,
            gameover:getHeight() / 2
        )
    end
    love.graphics.draw(
        time,
        windowDimensions.width * 0.5,
        windowDimensions.height * 0.5,
        0,
        1,
        1,
        time:getWidth() / 2,
        time:getHeight() / 2
    )
    if buttons.back["check"]["hover"] == true then
        if buttons.back["check"]["click"] == true then
            drawButton("menu", buttons.img["click"], buttons.back["x"], buttons.back["y"], buttons.scale)
        else
            drawButton("menu", buttons.img["hover"], buttons.back["x"], buttons.back["y"], buttons.scale)
        end
    else
        drawButton("menu", buttons.img["neutral"], buttons.back["x"], buttons.back["y"], buttons.scale)
    end
end
return buttons
