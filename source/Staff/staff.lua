import "CoreLibs/graphics"
import "CoreLibs/object"
import "CoreLibs/sprites"


local gfx <const> = playdate.graphics
local sprite = gfx.sprite

class("Staff").extends()

function Staff:init()
    self.label = {
		x = 100,
		y = 100,
		xspeed = 100,
		yspeed = 100,	
		width = 10,
		height = 80
	}
end

function Staff:update()
    local label = self.label;


	label.x -= label.xspeed


end

function Staff:status()
	return ("X: ".. label.x.. " Y: ".. label.y)

end

function Staff:draw()
    local label = self.label;
	gfx.setLineWidth(4)
    gfx.drawLine(label.x, label.y, label.x, label.y + label.height)
	gfx.setLineWidth(2)
	gfx.drawLine(label.x, label.y, playdate.display.getWidth(), label.y)
	gfx.drawLine(label.x, label.y + 20, playdate.display.getWidth(), label.y + 20)
	gfx.drawLine(label.x, label.y + 40, playdate.display.getWidth(), label.y + 40)
	gfx.drawLine(label.x, label.y + 60, playdate.display.getWidth(), label.y + 60)
	gfx.drawLine(label.x, label.y + 80, playdate.display.getWidth(), label.y + 80)
	
end