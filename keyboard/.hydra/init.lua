hydra.alert("Hello this is hydra", 1.5)

-- show the menu
menu.show(function()
  local updatetitles = {[true] = "Install Update", [false] = "Check for Update..."}
  local updatefns = {[true] = updates.install, [false] = checkforupdates}
  local hasupdate = (updates.newversion ~= nil)

  return {
    {title = "Reload Config", fn = hydra.reload},
    {title = "Show Logs", fn = logger.show},
    {title = "-"},
    {title = "About", fn = hydra.showabout},
    {title = updatetitles[hasupdate], fn = updatefns[hasupdate]},
    {title = "Quit Hydra", fn = os.exit},
  }
end)

function checkforupdates()
  updates.check()
  settings.set("lastcheckedupdates", os.time())
end

-- check for updates every week
timer.new(timer.weeks(1), checkforupdates):start()

-- launch Hydra at login
autolaunch.set(true)

-- reload config automatically
pathwatcher.new(os.getenv("HOME") .. "/.hydra/", hydra.reload):start()

-- switch between app windows of the same screen
hotkey.bind({"ctrl"}, "F", function()
  local win = window.focusedwindow()
  local winApp = win:application()

  for _, otherwin in ipairs(win:otherwindows_samescreen()) do
    if otherwin:application() == winApp then
      otherwin:focus()
      break
    end
  end
end)

-- specific app switching
local appsTable = {}
local function focusApp(name)
  return function()
    local myapp = appsTable[name]
    if myapp == nil then
      local apps = application.runningapplications()
      for _, app in ipairs(apps) do
        if app:title() == name then
          appsTable[name] = app
          myapp = app
          break
        end
      end
    end
    if myapp then
      myapp:activate()
      local lastwin = myapp:allwindows()[1]
      if lastwin then
        lastwin:focus()
      end
    end
  end
end

local function each(funcs)
  return function()
    for _, fn in ipairs(funcs) do
      fn()
    end
  end
end

hotkey.bind({"alt"}, "W", focusApp("Google Chrome"))
hotkey.bind({"alt"}, "E", focusApp("Terminal"))
hotkey.bind({"alt"}, "R", focusApp("MacVim"))
hotkey.bind({"alt"}, "S", focusApp("Finder"))
hotkey.bind({"alt"}, "D", focusApp("HipChat"))
hotkey.bind({"alt"}, "T", focusApp("µTorrent"))
hotkey.bind({"alt"}, "G", each({
  focusApp("Clementine"),
  focusApp("Spotify"),
}))
hotkey.bind({"alt"}, "6", focusApp("Mumble"))
hotkey.bind({"alt"}, "7", focusApp("Skype"))
hotkey.bind({"alt"}, "8", focusApp("Steam"))
hotkey.bind({"alt"}, "9", focusApp("Messages"))
