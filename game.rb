require 'gosu'

class Game < Gosu::Window
  WIDTH = 1280
  HEIGHT = 800

  def initialize
    super WIDTH, HEIGHT, false
    self.caption = "Hello game!"

    @background_image = Gosu::Image.new(self, "space.jpg", true)
    @background_color = Gosu::Color::WHITE
    @background_color.alpha = 100

    @ship = Ship.new(self, WIDTH, HEIGHT)
  end

  def update
    @ship.move_left if left_button_down?
    @ship.move_right if right_button_down?
  end

  def draw
    @background_image.draw(0, 0, 0, 1, 1, @background_color)
    @ship.draw
  end

  private

  def left_button_down?
    button_down?(Gosu::KbLeft) || button_down?(Gosu::GpLeft)
  end

  def right_button_down?
    button_down?(Gosu::KbRight) || button_down?(Gosu::GpRight)
  end
end

class Ship
  SIZE_SCALE = 0.5
  WIDTH = 256 * SIZE_SCALE
  HEIGHT = 256 * SIZE_SCALE
  MOVE_OFFSET = 5
  BOTTOM_OFFSET = 30

  def initialize(window, window_width, window_height)
    @ship = Gosu::Image.new(window, "ship.png", true)
    @window_width = window_width
    @window_height = window_height
    @x = @window_width / 2
    @y = @window_height - HEIGHT / 2 - BOTTOM_OFFSET
  end

  def draw
    @ship.draw_rot(@x, @y, 1, 180, 0.5, 0.5, SIZE_SCALE, SIZE_SCALE)
  end

  def move_left
    @x -= MOVE_OFFSET
  end

  def move_right
    @x += MOVE_OFFSET
  end

  private

end

game = Game.new
game.show