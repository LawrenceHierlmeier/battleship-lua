SetupScreen = BaseScreen:extend()

function SetupScreen:new()
    SetupScreen.super.new(self, {.3, .5, .3, 1.0}, nil)

    self.widgets = {
        Button(
            "Back to Title",
            function()
                SCREEN_MAN:changeScreen("title")
            end,
            540, 548, 200, 50
        ),
        Button(
            "Gamemode: Player vs Computer",
            function()
                return
            end,
            440, 250, 400, 40
        ),
        Button(
            "Difficulty: Easy",
            function()
                return
            end,
            490, 200, 300, 40
        ),
        Button(
            "Start",
            function()
                GAME_INFO["isAiHardmode"] = self.hard_mode
                GAME_INFO["gamemode"] = self.gamemode
                SCREEN_MAN:changeScreen("placement")
            end,
            565, 350, 150, 40
        ),
        Button(
            ">",
            function()
                self:changeDiff(true)
            end,
            795, 200, 50, 40
        ),
        Button(
            "<",
            function()
                self:changeDiff(false)
            end,
            435, 200, 50, 40
        ),
        Button(
            ">",
            function()
                self:changeMode("ComputerComputer")
            end,
            845, 250, 50, 40
        ),
        Button(
            "<",
            function()
                self:changeMode("PlayerPlayer")
            end,
            385, 250, 50, 40
        ),
        Label("Game Settings",340, 100, 600, {1.0, 1.0, 1.0, 1.0}, "center", 50)
    }

    self.gamemode = "none"
    self.hard_mode = nil

    self:changeDiff(false)
    self:changeMode("PlayerComputer")
end

function SetupScreen:changeDiff(is_hard)
    self.hard_mode = is_hard
    if (self.hard_mode)
    then
        self.widgets[3].text = "Difficulty: Hard"
        self.widgets[5].enabled = false
        self.widgets[6].enabled = true
    else
        self.widgets[3].text = "Difficulty: Easy"
        self.widgets[5].enabled = true
        self.widgets[6].enabled = false
    end
end

function SetupScreen:changeMode(new_mode)
    self.gamemode = new_mode

    if (self.gamemode == "PlayerPlayer")
    then
        self.widgets[3].enabled = false
        self.widgets[5].enabled = false
        self.widgets[6].enabled = false
        self.widgets[8].enabled = false
        self.widgets[7].on_click = function() self:changeMode("PlayerComputer") end
        self.widgets[2].text = "Gamemode: Player vs Player"
    else
        self.widgets[3].enabled = true
        if self.hard_mode == true then
            self.widgets[6].enabled = true
        else
            self.widgets[5].enabled = true
        end
        if (self.gamemode == "PlayerComputer") then
            self.widgets[7].enabled = true
            self.widgets[8].enabled = true
            self.widgets[8].on_click = function() self:changeMode("PlayerPlayer") end
            self.widgets[7].on_click = function() self:changeMode("ComputerComputer") end
            self.widgets[2].text = "Gamemode: Player vs Computer"
        else
            self.widgets[7].enabled = false
            self.widgets[8].enabled = true
            self.widgets[8].on_click = function() self:changeMode("PlayerComputer") end
            self.widgets[2].text = "Gamemode: Computer vs Computer"
        end


    end
end