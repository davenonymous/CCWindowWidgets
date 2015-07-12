-- The way the class system works requires us to pollute the global namespace
-- with our classes, hence we need to use shell.run instead of os.loadAPI to
-- load our classes.
shell.run("/rom/apis/class")
shell.run("/rom/apis/classes/GUIx/Gui")
shell.run("/rom/apis/classes/GUIx/Widgets/WidgetDDL")
shell.run("/DemoGUI/DemoPage")
shell.run("/DemoGUI/DemoPageButton")
shell.run("/DemoGUI/DemoPageToggleButton")
shell.run("/DemoGUI/DemoPageScrollPanel")
shell.run("/DemoGUI/DemoPageList")
shell.run("/DemoGUI/DemoPageBar")
shell.run("/DemoGUI/DemoPageDDL")

-- Create a GUI by searching for an advanced monitor. If none is found, use
-- the computer/turtle display. The Gui is a WidgetPanel object, so to add
-- elements you can simply call the add method.
local gui = Gui:auto(true)
gui:setColors(colors.white, colors.black)

-- Create a simple Label for the drop down list
local demoLabel = WidgetText(gui, 1, 1, 5, 1):setText("Demo:")
gui:add(demoLabel)

-- Create a panel to draw the demo pages
local demoArea = WidgetPanel(gui, 1, 3, gui.w, gui.h-3)
gui:add(demoArea)

-- Create a drop down list to select page to be display
local demoSelect = WidgetDDL(gui, 7, 1, 20, 5)
demoSelect:setColors(colors.white, colors.black)
demoSelect:setChildColors(colors.white, colors.gray)
gui:add(demoSelect)

-- Specify the existing demo pages
local demoPages = {
	["Button"] = DemoPageButton(demoArea),
	["Toggle Button"] = DemoPageToggleButton(demoArea),
	["Scroll Panel"] = DemoPageScrollPanel(demoArea),
	["List"] = DemoPageList(demoArea),
	["Bar"] = DemoPageBar(demoArea),
	["Drop Down List"] = DemoPageDDL(demoArea),
}

-- Add the pages we know to the Drop down list
for name,page in pairs(demoPages) do
	demoSelect:addChoice(name)
end

-- At this point we have added the elements we want on the page,
-- but we have no interaction between them. It's time to add a
-- little bit of event handling.

-- When the selection of the DDL changed, adapt the draw area
-- accordingly
demoSelect:on("selection_changed", function(label)
	-- first clear it, so the old entries will be removed from
	-- the panel
	demoArea:clear()

	-- add the demopage to the panel
	demoArea:add(demoPages[label])

	-- and redraw the panel now holding the page
	demoArea:draw()
end)

-- Since the DDL overlaps the demoarea when it is expanded, 
-- we have to redraw the demo area when the DDL collapses
demoSelect:on("switching_mode", function(isSelecting)
	if(isSelecting == false) then
		demoArea:draw()
	end
end)

-- Trigger the first draw of our gui
gui:redraw()

-- Start with the first page
demoSelect:setSelected("List")

-- Event loop, let the gui process all events and handle
-- your own afterwards. For example you can have the program
-- exit when any key is being pressed.
while(true) do
	local event, p1 = gui:handleEvent(os.pullEvent())
	if(event == "key") then
		error()
	end
end