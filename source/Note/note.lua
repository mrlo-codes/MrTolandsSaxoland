import "CoreLibs/graphics"
import "CoreLibs/object"
import "CoreLibs/sprites"


local gfx <const> = playdate.graphics
local sprite = gfx.sprite

class("Note").extends()

function Note:init(xspeed, yspeed)
    self.label = {
		x = 420,
		y = 90 + (math.random(0, 8) * 10),
		xspeed = xspeed,
		yspeed = yspeed,
		width = 20,
		height = 20
	}
end
--[[
function dvd:swapColors()
	if (gfx.getBackgroundColor() == gfx.kColorWhite) then
		gfx.setBackgroundColor(gfx.kColorBlack)
		gfx.setImageDrawMode("inverted")
	else
		gfx.setBackgroundColor(gfx.kColorWhite)
		gfx.setImageDrawMode("copy")
	end
end
]]--

function Note:update()
    local label = self.label


	label.x -= label.xspeed


end

function Note:status()
	local label = self.label
	return ("X: "..label.x.. " Y: ".. label.y)

end

function Note:draw()
    local label = self.label
	gfx.setLineWidth(2)
    gfx.fillRect(label.x, label.y, label.width, label.height)
end

function Note:changeSpeed(newXSpeed, newYSpeed)
	local label = self.label
	label.xspeed = newXSpeed
	label.yspeed = newYSpeed
end

function Note:changeX(newX)
	local label = self.label
	label.x = newX
end

function Note:getXSpeed()
	local label = self.label
	return label.xspeed
end

function Note:getXPos()
	local label = self.label
	return label.x
end

function Note:getYPos()
	local label = self.label
	return label.y
end

function Note:getYSpeed()
	local label = self.label
	return label.yspeed
end