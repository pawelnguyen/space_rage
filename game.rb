require 'gosu'
require_relative 'ship'
require_relative 'meteor'

class Game < Gosu::Window
  WIDTH = 1280
  HEIGHT = 800
  METEOR_CREATING_CHANCE = 0.1

  def initialize
    super WIDTH, HEIGHT, false
    self.caption = "Hello game!"

    @background_image = Gosu::Image.new(self, "assets/space.jpg", true)
    @background_color = Gosu::Color::WHITE
    @background_color.alpha = 100

    @ship = Ship.new(self, WIDTH, HEIGHT)
    @meteors = []
  end

  def update
    @ship.move_left if left_button_down?
    @ship.move_right if right_button_down?
    update_meteors
  end

  def draw
    @background_image.draw(0, 0, 0, 1, 1, @background_color)
    @ship.draw
    draw_meteors
  end

  def button_down(id)
    close if id == Gosu::KbEscape
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
    create_meteors
    @meteors.each(&:move)
    destroy_meteors!
  end

  def draw_meteors
    @meteors.each(&:draw)
  end

  def destroy_meteors!
    @meteors.delete_if(&:deletable?)
  end
end

game = Game.new
game.show