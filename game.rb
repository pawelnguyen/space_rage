require 'gosu'

class Game < Gosu::Window
  def initialize
    super 1280, 800, false
    self.caption = "Hello game!"

    @background_image = Gosu::Image.new(self, "space.jpg", true)
    @background_color = Gosu::Color::WHITE
    @background_color.alpha = 100
  end

  def update

  end

  def draw
    @background_image.draw(0, 0, 0, 1, 1, @background_color)
  end
end

class Ship
  def initialize(window)
    
  end
end

game = Game.new
game.show