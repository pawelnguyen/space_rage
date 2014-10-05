require 'gosu'

class Game < Gosu::Window
  WIDTH = 1280
  HEIGHT = 800
  METEOR_CREATING_CHANCE = 0.1

  def initialize
    super WIDTH, HEIGHT, false
    self.caption = "Hello game!"

    @background_image = Gosu::Image.new(self, "space.jpg", true)
    @background_color = Gosu::Color::WHITE
    @background_color.alpha = 100

    @ship = Ship.new(self, WIDTH, HEIGHT)
    @meteors = []
  end

  def update
    @ship.move_left if left_button_down?
    @ship.move_right if right_button_down?
    create_meteors
    update_meteors
  end

  def draw
    @background_image.draw(0, 0, 0, 1, 1, @background_color)
    @ship.draw
    draw_meteors
  end

  private

  def left_button_down?
    button_down?(Gosu::KbLeft) || button_down?(Gosu::GpLeft)
  end

  def right_button_down?
    button_down?(Gosu::KbRight) || button_down?(Gosu::GpRight)
  end

  def create_meteors
    create_meteor if rand((1 / METEOR_CREATING_CHANCE) - 1) == 0
  end

  def create_meteor
    @meteors << Meteor.new(self, WIDTH, HEIGHT)
  end

  def update_meteors
    @meteors.each(&:move)
  end

  def draw_meteors
    @meteors.each(&:draw)
  end
end

class Ship
  SIZE_SCALE = 0.5
  MOVE_OFFSET = 5
  BOTTOM_OFFSET = 30

  def initialize(window, window_width, window_height)
    @ship_image = Gosu::Image.new(window, "ship.png", true)
    @window_width = window_width
    @window_height = window_height
    @x = @window_width / 2
    @y = @window_height - height / 2 - BOTTOM_OFFSET
  end

  def draw
    @ship_image.draw_rot(@x, @y, 2, 180, 0.5, 0.5, SIZE_SCALE, SIZE_SCALE)
  end

  #TODO: window constraints
  def move_left
    @x -= MOVE_OFFSET
  end

  def move_right
    @x += MOVE_OFFSET
  end

  private

  def width
    @ship_image.width * SIZE_SCALE
  end

  def height
    @ship_image.height * SIZE_SCALE
  end
end

class Meteor
  SIZE_SCALE = 0.2
  SPEED = 5

  def initialize(window, window_width, window_height)
    @window_width = window_width
    @window_height = window_height

    @meteor_image = Gosu::Image.new(window, "meteor.png", true)
    @x = rand(@window_width - width)
    @y = - height
  end

  def draw
    @meteor_image.draw(@x, @y, 1, SIZE_SCALE, SIZE_SCALE)
  end

  def move
    @y += SPEED
  end

  private

  def width
    @meteor_image.width * SIZE_SCALE
  end

  def height
    @meteor_image.height * SIZE_SCALE
  end
end

game = Game.new
game.show