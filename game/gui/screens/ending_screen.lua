EndingScreen = BaseScreen:extend()

function EndingScreen:new(color, bg_image)
    EndingScreen.super.new(self, {.3, .5, .3, 1.0}, nil)

    self.widgets = {
        Label("Congrats", 0,200,1280,{1.0, 1.0, 1.0, 1.0}, "center", 20),
        Button(
            "New Game",
            function()
                SCREEN_MAN:changeScreen("setup")
            end,
            540, 275, 200, 100
        )
    }
end

function EndingScreen:update()
    if GAME_INFO["gamemode"] == "PlayerComputer" then
        if GAME_INFO["playerTwo"]["health"] == 0 then
            if GAME_INFO["isAiHardmode"] == false then
                self.widgets[1].text = "Congrats on beating the Easy AI. Try your hand against the harder AI next!"
            else
                self.widgets[1].text = "Congrats on beating the Hard AI. You are truly a battleship champion!"
            end
        else
            self.widgets[1].text = "Tough Luck. You definitely can win next time!"
        end
    end
end