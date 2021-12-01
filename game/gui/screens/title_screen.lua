TitleScreen = BaseScreen:extend()

function TitleScreen:new()
    TitleScreen.super.new(self, {.3, .5, .3, 1.0}, nil)

    self.widgets = {
        Button("New Game",
        function()
          SCREEN_MAN:changeScreen("setup")
        end,
        540, 460, 200, 100),
        Button("Exit Game",
        function()
          love.event.push('quit')
        end,
        540, 580, 200, 100),
        Label("Battleship", 340, 180, 600, {1.0, 1.0, 1.0, 1.0}, "center", 50),
        Label("Online", 340, 280, 600, {1.0, 1.0, 1.0, 1.0}, "center", 50)
    }
    
end
