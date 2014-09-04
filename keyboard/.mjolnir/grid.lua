-- grid.lua v2014.07.05

local window = require "mjolnir.window"
local alert = require "mjolnir.alert"
local grid = {}

grid.MARGINX = 0
grid.MARGINY = 0
grid.GRIDHEIGHT = 4
grid.GRIDWIDTH = 4

local function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function grid.get(win)
  local winframe = win:frame()
  local screenrect = win:screen():frame()
  local thirdscreenwidth = screenrect.w / grid.GRIDWIDTH
  local halfscreenheight = screenrect.h / grid.GRIDHEIGHT
  return {
    x = round((winframe.x - screenrect.x) / thirdscreenwidth),
    y = round((winframe.y - screenrect.y) / halfscreenheight),
    w = math.max(1, round(winframe.w / thirdscreenwidth)),
    h = math.max(1, round(winframe.h / halfscreenheight)),
  }
end

function grid.set(win, f, screen)
  local screenrect = screen:frame()
  local thirdscreenwidth = screenrect.w / grid.GRIDWIDTH
  local halfscreenheight = screenrect.h / grid.GRIDHEIGHT
  local newframe = {
    x = (f.x * thirdscreenwidth) + screenrect.x,
    y = (f.y * halfscreenheight) + screenrect.y,
    w = f.w * thirdscreenwidth,
    h = f.h * halfscreenheight,
  }

  newframe.x = newframe.x + grid.MARGINX
  newframe.y = newframe.y + grid.MARGINY
  newframe.w = newframe.w - (grid.MARGINX * 2)
  newframe.h = newframe.h - (grid.MARGINY * 2)

  win:setframe(newframe)
end

function grid.snap(win)
  if win:isstandard() then
    grid.set(win, grid.get(win), win:screen())
  end
end

function grid.adjustheight(by)
  grid.GRIDHEIGHT = math.max(1, grid.GRIDHEIGHT + by)
  alert.show("grid is now " .. tostring(grid.GRIDHEIGHT) .. " tiles high", 1)
end

function grid.adjustwidth(by)
  grid.GRIDWIDTH = math.max(1, grid.GRIDWIDTH + by)
  alert.show("grid is now " .. tostring(grid.GRIDWIDTH) .. " tiles wide", 1)
end

function grid.adjust_focused_window(fn)
  local win = window.focusedwindow()
  local f = grid.get(win)
  fn(f)
  grid.set(win, f, win:screen())
end

function grid.maximize_window()
  local win = window.focusedwindow()
  local f = {x = 0, y = 0, w = grid.GRIDWIDTH, h = grid.GRIDHEIGHT}
  grid.set(win, f, win:screen())
end

function grid.pushwindow_nextscreen()
  local win = window.focusedwindow()
  grid.set(win, grid.get(win), win:screen():next())
end

function grid.pushwindow_prevscreen()
  local win = window.focusedwindow()
  grid.set(win, grid.get(win), win:screen():previous())
end

function grid.pushwindow_left()
  grid.adjust_focused_window(function(f) f.x = math.max(f.x - 1, 0) end)
end

function grid.pushwindow_right()
  grid.adjust_focused_window(function(f) f.x = math.min(f.x + 1, grid.GRIDWIDTH - f.w) end)
end

function grid.resizewindow_wider()
  grid.adjust_focused_window(function(f) f.w = math.min(f.w + 1, grid.GRIDWIDTH - f.x) end)
end

function grid.resizewindow_thinner()
  grid.adjust_focused_window(function(f) f.w = math.max(f.w - 1, 1) end)
end

function grid.pushwindow_down()
  grid.adjust_focused_window(function(f) f.y = math.min(f.y + 1, grid.GRIDHEIGHT - f.h) end)
end

function grid.pushwindow_up()
  grid.adjust_focused_window(function(f) f.y = math.max(f.y - 1, 0) end)
end

function grid.resizewindow_shorter()
  grid.adjust_focused_window(function(f) f.y = 0; f.h = math.max(f.h - 1, 1) end)
end

function grid.resizewindow_taller()
  grid.adjust_focused_window(function(f) f.y = 0; f.h = math.min(f.h + 1, grid.GRIDHEIGHT - f.y) end)
end

return grid
