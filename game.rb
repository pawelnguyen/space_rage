require 'gosu'

require_relative 'lib/ship'
require_relative 'lib/asteroid'
require_relative 'lib/explosion'

class Game < Gosu::Window
  WIDTH = 1280
  HEIGHT = 800
  METEOR_CREATING_CHANCE = 0.1
  SHIPS_AMOUNT = 4
  SHIPS_STEERING = [
      {left: Gosu::KbLeft, right: Gosu::KbRight},
      {left: Gosu::KbQ, right: Gosu::KbW},
      {left: Gosu::KbV, right: Gosu::KbB},
      {left: Gosu::KbO, right: Gosu::KbP}
  ]

  def initialize
    super WIDTH, HEIGHT, false
    self.caption = "Space Rage"
  end

  def update
    update_ships
    update_asteroids
    update_collisions!
  end

  def draw
    background_image.draw(0, 0, 0, 1, 1, background_color)
    draw_ships
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

  def ships
    @ships ||= create_ships
  end

  def asteroids
    @asteroids ||= []
  end

  def explosions
    @explosions ||= []
  end

  def create_asteroids
    create_asteroid if rand(99) < METEOR_CREATING_CHANCE * 100
  end

  def create_asteroid
    asteroids << Asteroid.new(self, WIDTH, HEIGHT)
  end

  def create_ships
    SHIPS_AMOUNT.times.map { |i| Ship.new(self, WIDTH, HEIGHT, SHIPS_STEERING[i][:left], SHIPS_STEERING[i][:right]) }
  end

  def update_ships
    remove_deletable!(ships) # explode them?
    ships.each do |ship|
      ship.move_left if button_down?(ship.steering_left) && can_move_left?(ship)
      ship.move_right if button_down?(ship.steering_right) && can_move_right?(ship)
    end
  end

  def update_asteroids
    create_asteroids
    asteroids.each(&:move)
    remove_deletable!(asteroids)
  end

  def draw_asteroids
    asteroids.each(&:draw)
  end

  def draw_explosions
    explosions.each(&:draw)
  end

  def draw_ships
    ships.each(&:draw)
  end

  def update_collisions!
    asteroids.delete_if do |asteroid|
      colliding_ships = ships.select {|ship| ship.collides_with?(asteroid)}
      if colliding_ships.any?
        colliding_ships.each(&:hit!)
        explosions << Explosion.create_from(self, asteroid)
        true
      end
    end
    remove_deletable!(explosions)
  end

  def remove_deletable!(array)
    array.delete_if(&:deletable?)
  end

  def can_move_left?(ship)
    other_ships(ship).none? {|other_ship| ship.collides_with?(other_ship) && ship.x > other_ship.x } #TODO: dry
  end

  def can_move_right?(ship)
    other_ships(ship).none? {|other_ship| ship.collides_with?(other_ship) && ship.x < other_ship.x }
  end

  def other_ships(ship)
    ships - [ship]
  end
end

Game.new.show
