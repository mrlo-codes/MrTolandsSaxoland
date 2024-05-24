import "CoreLibs/sprites"
import "CoreLibs/graphics"
--import "CoreLibs/object"
import "Note/note"
import "Staff/staff"


local gfx <const> = playdate.graphics
local sprite = gfx.sprite
local screenWidth = playdate.display.getWidth()
local screenHeight = playdate.display.getHeight()

local font = gfx.font.new('font/Mini Sans 2X')
local text
local score = 0
local cursorY = 100
local speed = 25
local notes = {}
local collided = {}
local staff = Staff()
local frames = 0

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
	gfx.clear()
	staff:draw()
	gfx.drawCircleAtPoint(100, cursorY, 10)
	gfx.setColor(gfx.kColorWhite)
	gfx.fillCircleAtPoint(100, cursorY, 9)
	gfx.setColor(gfx.kColorBlack)
	if(math.random(0, 100) > 50 and frames % 30 == 0) then
		table.insert(notes, Note(speed, speed))
		print(notes[#notes]:status())
		print("There are ".. #notes.. " notes now.")
	end
	

	for i, n in ipairs(notes) do
		if(n~=nil) then
			if(n:getDeathFlag() ~= false) then
				if(n:getXSpeed() ~= speed) then
					n:changeSpeed(speed)
				end
			elseif (n:getX() <= 85) then
				print("Set to die")
				collided[i] = nil
				text = "MISSED!"
				score -= 10
			end
		end

		n:update()
		n:draw()
		
	end


end

local function checkCollisions()
	collided = {}

	for i, n in ipairs(notes) do
		if(n~=nil) then
			if(n:getXPos() <= 120) then
				if(math.abs(100 - n:getXPos()) < 20) then
					table.insert(collided, n)
				elseif (n:getXPos() <= 85) then
					n:setDeathFlag(true)
					table.insert(collided, n)
				end
			end
		end
	end
end

local function printCollisions()
	local result = "{"
	for i, n in ipairs(collided) do
		result = result.."Note #: "..i.." at ("..n:getXPos()..", "..n:getYPos().."), "
	end

	result = result.."}"
	print(result)

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
		playGame()
		playdate.drawFPS(0,0) -- FPS widget

		frames+=1
		gfx.drawText(text, 50, 40)
		gfx.drawText(score, 50, 60)
	end

end

function playdate.AButtonDown()	
	if gameState == kGameInitialState then
    	gameState = kGamePlayingState
		gfx.clear()
		text = "Align cursor and hit the A button!"
	elseif gameState == kGamePlayingState then
		text=""
		checkCollisions()
		--printTable(collided)
		printCollisions()
		if(collided ~= nil) then
			for i, n in ipairs(collided) do
				local diffY = math.abs((n:getYPos()+10) - cursorY)
				local diffX = math.abs(100 - (n:getXPos()))
				if(diffY < 5 and diffX < 5) then
					text = "Perfect!"
					score += 30
				elseif (diffY < 10 and diffX < 10) then
					text = "Good"
					score += 15
				elseif (diffY < 15 and diffX < 15) then
					text = "Poor"
					score += 5
				else 
					text = "Missed!"
					score -= 10
				end
				
				
			end
		end
			
	end

	buttonDown = true

end

function playdate.BButtonDown()
	if gameState == kGameInitialState then
		gameState = kGamePlayingState
    	gfx.clear()
	elseif gameState == kGamePlayingState then
		--[[for i, n in ipairs(notes) do
			print("current speed: "..speed.." object speed: "..n:getXSpeed())
		end]]--
		--checkCollisions()
		--printTable(collided)
		--printCollisions()

	end

	buttonDown = true

end

function playdate.downButtonDown()
	
	if gameState == kGamePlayingState and cursorY < 180 then
		cursorY+=10
	end
	buttonDown = true
end

function playdate.upButtonDown()
	if gameState == kGamePlayingState and cursorY > 100 then
		cursorY-=10
	end
	buttonDown = true
end

function playdate.leftButtonDown()
	if gameState == kGamePlayingState and speed < 50 then
		speed += 5
	end
	buttonDown = true
end

function playdate.rightButtonDown()
	if gameState == kGamePlayingState and speed > 5 then
		speed -= 5
	end
	buttonDown = true
end

function playdate.AButtonUp()
	buttonDown = false
end

function playdate.BButtonUp()
	buttonDown = false
end

function playdate.downButtonUp()
	buttonDown = false
end

function playdate.upButtonUp()
	buttonDown = false
end

function playdate.leftButtonUp()
	buttonDown = false
end

function playdate.rightButtonUp()
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