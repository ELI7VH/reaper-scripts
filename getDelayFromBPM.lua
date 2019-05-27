-- Elijah Lucian's Tempo Delay Time Tool

function msg(m)
  return reaper.ShowConsoleMsg(tostring(m) .. "\n")
end

function GetBPM()
  return reaper.Master_GetTempo()
end

function GetDelayTimes(tempo)
  return 60000 / tempo
end

function UpdatePosition(x)
  y = 1.2
  gfx.x = (10)*y
  gfx.y = (10 + x)*y
end

local gui = {}

function init()

  gui.settings = {}
  gui.settings.font_size = 20
  gui.settings.docker_id = 0
  gfx.init("", 300, 400, gui.settings.docker_id)
  gfx.setfont(1,"monofur", gui.settings.font_size)
  gfx.clear = 3355443
  mainloop()
end

function mainloop()

  tempo = GetBPM()
  delay = GetDelayTimes(tempo)

  UpdatePosition(0)
  gfx.printf("Tempo: "..tempo.." BPM")
  UpdatePosition(20)
  gfx.printf("1/4 Note Delay: " .. math.floor(delay+0.5) .. " ms")
  UpdatePosition(40)
  gfx.printf("1/8 Note Delay: " .. math.floor(delay/2+0.5) .. " ms")
  UpdatePosition(60)
  gfx.printf("1/16 Note Delay: " .. math.floor(delay/4+0.5) .. " ms")
  UpdatePosition(80)
  gfx.printf("1/32 Note Delay: " .. math.floor(delay/8+0.5) .. " ms")
  UpdatePosition(100)
  gfx.printf("1/64 Note Delay: " .. math.floor(delay/16+0.5) .. " ms")

  gfx.update()

  if gfx.getchar() >= 0 then reaper.defer(mainloop) end
end

init()
