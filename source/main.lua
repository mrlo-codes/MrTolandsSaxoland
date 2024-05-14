import "CoreLibs/sprites"
import "CoreLibs/graphics"
--import "CoreLibs/object"
import "Note/note"


local gfx <const> = playdate.graphics
local sprite = gfx.sprite
local screenWidth = playdate.display.getWidth()
local screenHeight = playdate.display.getHeight()

local font = gfx.font.new('font/Mini Sans 2X')
local text = 0

local sound = playdate.sound
local buttonDown = false

-- ! game states

local kGameState = {initial, ready, playing, paused, over}
local currentState = kGameState.initial

local kGameInitialState, kGamePlayingState, kGamePausedState, kGameOverState = 0, 1, 2, 3
local gameState = kGameInitialState


-- ! set up sprites
--[[
local titleSprite = spritelib.new()
titleSprite:setImage(gfx.image.new('images/Toland_G'))
titleSprite:moveTo(screenWidth / 2, screenHeight / 2)
titleSprite:addSprite()
]]--
local tolandTitleSprite = gfx.sprite.new(gfx.image.new('images/Toland_G_Smol'))
tolandTitleSprite:moveTo(-100, (screenHeight / 2) + 35) -- (screenWidth / 2) + 60, (screenHeight / 2) + 35
tolandTitleSprite:add()

local titleSprite1 = gfx.sprite.new(gfx.image.new('images/title1'))
local titleSprite2 = gfx.sprite.new(gfx.image.new('images/title2'))
local notes = {}
local frames = 0
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

local function playGame()
	if(math.random(0, 100) > 50 and frames % 30 == 0) then
		table.insert(notes, Note(10, 10))
		print("hi")
		--print(table.concat(notes, ", "))
	end

	for n in notes do
		n:update()
		n:draw()
	end


end


function playdate.update()
	if gameState == kGameInitialState then
		if tolandTitleSprite.x < (screenWidth / 2) + 60 then
			tolandTitleSprite:moveTo(tolandTitleSprite.x + 10, tolandTitleSprite.y)
			sprite.update()
		else
			gfx.drawText("Press A/B to Play!", 75, 200, font)
		end
	elseif (gameState == kGamePlayingState) then
		playdate.drawFPS(0,0) -- FPS widget
		playGame()
		frames+=1
	end

end

function playdate.AButtonDown()	
	if gameState == kGameInitialState then
    	gameState = kGamePlayingState
		gfx.clear()
    	text += 1
    	gfx.drawText(text, 200, 100, font)
	end

	buttonDown = true

end

function playdate.BButtonDown()	
	if gameState == kGameInitialState then
		gameState = kGamePlayingState
    	gfx.clear()
    	text -= 1 
    	gfx.drawText(text, 200, 100, font)
	end

	buttonDown = true

end

function playdate.AButtonUp()
	buttonDown = false
end

function playdate.BButtonUp()
	buttonDown = false
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