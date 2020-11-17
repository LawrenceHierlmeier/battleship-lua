TitleScreen = BaseScreen:extend()

function TitleScreen:new()
    TitleScreen.super.new(self)

    self.widgets = {
        Button("New Game",
        function()
          SCREEN_MAN:changeScreen("setup")
        end,
        20, 20, 200, 100),
        Button("Load Game",
        function()
          local error = loadGame()
          if (error ~= nil) then
            self.widgets[4].visible = true
          else
            SCREEN_MAN:changeScreen("game")
          end
        end,
        20, 140, 200, 100),
        Button("Exit Game",
        function()
          love.event.push('quit')
        end,
        20, 260, 200, 100)
    }
    
end
