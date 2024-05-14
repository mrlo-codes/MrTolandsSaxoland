import "CoreLibs/graphics"
import "CoreLibs/object"
import "CoreLibs/sprites"


local gfx <const> = playdate.graphics
local sprite = gfx.sprite

class("Note").extends()

function Note:init(xspeed, yspeed)
    self.label = {
		x = 420,
		y = playdate.display.getHeight() / 2,
		xspeed = xspeed,
		yspeed = yspeed,
		width = 100,
		height = 100
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
    local label = self.label;


	label.x -= label.xspeed


end

function Note:draw()
    local label = self.label;
    gfx.drawRect(label.x, label.y, label.width, label.height)
end