local animations = {}

function spriteQuads(pImg)
    local sprite = {}
    local quads = {}
    sprite.img = pImg
    sprite.width = sprite.img:getWidth()
    sprite.height = sprite.img:getHeight()
    local colonnes = sprite.width / sprite.height
    local lignes = 1
    for i = 1, colonnes * lignes do
        local frame = i - 1
        local x = frame * sprite.height
        local y = math.floor(frame / colonnes) * sprite.height
        quads[i] = love.graphics.newQuad(x, y, sprite.height, sprite.height, sprite.width, sprite.height)
    end
    return quads
end

function spriteUpdate(pQuads, pFrame, pTimer, dt)
    local frame = (pFrame + #pQuads * (dt / pTimer))
    if frame > #pQuads then
        frame = 1
    end
    return frame
end

function spriteDraw(pImg, pQuads, pFrame, pX, pY, pR, pSx, pSy, pOx, pOy)
    local frame = math.floor(pFrame)
    for i = 1, frame do
        love.graphics.draw(pImg, pQuads[frame], pX, pY, pR, pSx, pSy, pOx, pOy)
    end
end
