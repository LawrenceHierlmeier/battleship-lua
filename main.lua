function love.mousepressed(x, y, button, istouch, presses)
    SCREEN_MAN:mousepressed(x, y, button, istouch, presses)
end

function love.mousereleased(x, y, button, istouch, presses)
    SCREEN_MAN:mousereleased(x, y, button, istouch, presses)
end

function love.load()
    Object = require "libraries.classic.classic"
    Lume = require "libraries.lume.lume"
    
    require "game.gui.screens.base_screen"
    require "game.gui.screens.pause_screen"
    require "game.gui.screens.setup_screen"
    require "game.gui.screens.title_screen"
    require "game.gui.screens.placement_screen"
    require "game.gui.screens.screen_manager"
    require "game.gui.screens.play_screen"

    require "game.gui.widgets.button"
    require "game.gui.widgets.game_grid"
    require "game.gui.widgets.label"

    require "game.util.util"

    require "game.data.ships"

    GAME_INFO = require "game.data.game"
    SETTINGS = require "game.data.settings"
    require "game.data.ai"

    SCREEN_MAN = ScreenManager()

    love.graphics.setFont(love.graphics.newFont(20))
end

function love.update(dt)
    SCREEN_MAN.cur_screen:update(dt)
end

function love.draw()
    SCREEN_MAN.cur_screen:draw()
end