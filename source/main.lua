import "CoreLibs/sprites"
import "CoreLibs/graphics"


local gfx <const> = playdate.graphics
local spritelib = gfx.sprite
local screenWidth = playdate.display.getWidth()
local screenHeight = playdate.display.getHeight()

local font = gfx.font.new('font/Mini Sans 2X')
local text = 0

local sound = playdate.sound

-- ! game states

local kGameState = {initial, ready, playing, paused, over}
local currentState = kGameState.initial

local kGameInitialState, kGameGetReadyState, kGamePlayingState, kGamePausedState, kGameOverState = 0, 1, 2, 3, 4
local gameState = kGameInitialState


-- ! set up sprites
--[[
local titleSprite = spritelib.new()
titleSprite:setImage(gfx.image.new('images/Toland_G'))
titleSprite:moveTo(screenWidth / 2, screenHeight / 2)
titleSprite:addSprite()
]]--
local tolandTitleSprite = gfx.sprite.new(gfx.image.new('images/Toland_G_Smol'))
tolandTitleSprite:moveTo((screenWidth / 2) + 60, (screenHeight / 2) + 35)
tolandTitleSprite:add()

local titleSprite1 = gfx.sprite.new(gfx.image.new('images/title1'))
local titleSprite2 = gfx.sprite.new(gfx.image.new('images/title2'))
titleSprite1:moveTo(150, 50)
titleSprite2:moveTo(150, 80)
titleSprite1:setScale(0.25)
titleSprite2:setScale(0.25)
titleSprite1:add()
titleSprite2:add()




local function loadGame()
	playdate.display.setRefreshRate(50) -- Sets framerate to 50 fps
	-- reset the screen to white
	gfx.setBackgroundColor(gfx.kColorWhite)
	gfx.setColor(gfx.kColorWhite)
	gfx.fillRect(0, 0, screenWidth, screenHeight)
	gfx.setFont(font)
	

	--math.randomseed(playdate.getSecondsSinceEpoch()) -- seed for math.random
	
end


function playdate.update()
	if gameState == kGameInitialState then
		print("ready")
		
		spritelib.update()
	end

end

function playdate.AButtonDown()	
    gameState = kGameGetReadyState
	gfx.clear()
    text += 1
    gfx.drawText(text, 200, 100, font)
end

function playdate.BButtonDown()	
	gameState = kGameGetReadyState
    gfx.clear()
    text -= 1 
    gfx.drawText(text, 200, 100, font)
end

--[[
local function updateGame()
	dvd:update() -- DEMO
end

local function drawGame()
	gfx.clear() -- Clears the screen
	dvd:draw() -- DEMO
end

loadGame()

function playdate.update()
	updateGame()
	drawGame()
	playdate.drawFPS(0,0) -- FPS widget
end
]]--