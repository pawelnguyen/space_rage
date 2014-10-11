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
    self.caption = "Space Rage"
  end

  def update
    ship.move_left if left_button_down?
    ship.move_right if right_button_down?
    update_asteroids
    update_collisions!
  end

  def draw
    background_image.draw(0, 0, 0, 1, 1, background_color)
    ship.draw
    draw_asteroids
    draw_explosions
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end

  private

  def background_image
    @background_image ||= Gosu::Image.new(self, "assets/space.jpg", true)
  end

  def background_color
    @background_color ||= Gosu::Color::WHITE.tap {|c| c.alpha = 100 }
  end

  def ship
    @ship ||= Ship.new(self, WIDTH, HEIGHT)
  end

  def asteroids
    @asteroids ||= []
  end

  def explosions
    @explosions ||= []
  end

  def left_button_down?
    button_down?(Gosu::KbLeft) || button_down?(Gosu::GpLeft)
  end

  def right_button_down?
    button_down?(Gosu::KbRight) || button_down?(Gosu::GpRight)
  end

  def create_asteroids
    create_asteroid if rand(99) < METEOR_CREATING_CHANCE * 100
  end

  def create_asteroid
    asteroids << Asteroid.new(self, WIDTH, HEIGHT)
  end

  def update_asteroids
    create_asteroids
    asteroids.each(&:move)
    remove_useless!(asteroids)
  end

  def draw_asteroids
    asteroids.each(&:draw)
  end

  def draw_explosions
    explosions.each(&:draw)
  end

  def update_collisions!
    asteroids.delete_if do |asteroid|
      if ship.collides_with?(asteroid)
        ship.hit!
        explosions << Explosion.create_from(self, asteroid)
      end
    end
    remove_useless!(explosions)
  end

  def remove_useless!(array)
    array.delete_if(&:deletable?)
  end
end

Game.new.show
