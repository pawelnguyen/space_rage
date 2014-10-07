require 'gosu'
require_relative 'ship'
require_relative 'asteroid'
require_relative 'explosion'

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
    @asteroids = []
    @explosion = Explosion.new(self, 400, 400)
  end

  def update
    ship.move_left if left_button_down?
    ship.move_right if right_button_down?
    update_asteroids
    detect_collisions
  end

  def draw
    @background_image.draw(0, 0, 0, 1, 1, @background_color)
    ship.draw
    draw_asteroids
    @explosion.draw
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

  def create_asteroids
    create_asteroid if rand((1 / METEOR_CREATING_CHANCE) - 1) == 0
  end

  def create_asteroid
    asteroids << Asteroid.new(self, WIDTH, HEIGHT)
  end

  def update_asteroids
    create_asteroids
    asteroids.each(&:move)
    destroy_asteroids!
  end

  def draw_asteroids
    asteroids.each(&:draw)
  end

  def destroy_asteroids!
    asteroids.delete_if(&:deletable?)
  end

  def detect_collisions
    ship.reset_collisions!
    asteroids.each do |asteroid|
      ship.check_collision(asteroid)
    end
  end

  def asteroids
    @asteroids
  end

  def ship
    @ship
  end
end

game = Game.new
game.show