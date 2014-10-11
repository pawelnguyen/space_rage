require_relative 'health_bar'

class Ship
  SIZE_SCALE = 0.5
  MOVE_OFFSET = 5
  BOTTOM_OFFSET = 30
  WIDTH = 146
  HIT_TIME_LENGTH = 250

  attr_reader :window, :window_height, :window_width

  def initialize(window, window_width, window_height)
    @window = window
    @window_width = window_width
    @window_height = window_height
  end

  def draw
    ship_image.draw_rot(x, y, 1, 180, 0.5, 0.5, SIZE_SCALE, SIZE_SCALE, color)
    health_bar.draw(x, y + health_bar_offset)
  end

  def move_left
    @x -= MOVE_OFFSET if within_window?(x - MOVE_OFFSET)
  end

  def move_right
    @x += MOVE_OFFSET if within_window?(x + MOVE_OFFSET)
  end

  def collides_with?(object)
    collides?(object.x, object.y, object.radius)
  end

  def collides?(x1, y1, r = 0)
    Gosu.distance(x1, y1, x, y) < r + radius
  end

  def radius
    width / 2 # simple for now
  end

  def hit!
    @hit_time = Gosu::milliseconds
  end

  def is_hit?
    @hit_time && (Gosu::milliseconds - @hit_time < HIT_TIME_LENGTH)
  end

  private

  def ship_image
    Gosu::Image.new(window, "assets/ship.png", true)
  end

  def x
    @x ||= window_width / 2
  end

  def y
    @y ||= window_height - height / 2 - BOTTOM_OFFSET
  end

  def health_bar
    @health_bar ||= HealthBar.new(window, width)
  end

  def width
    WIDTH * SIZE_SCALE
  end

  def height
    ship_image.height * SIZE_SCALE
  end

  def within_window?(x)
    x > width / 2 && x < window_width - width / 2
  end

  def color
    is_hit? ? Gosu::Color::RED : Gosu::Color::WHITE.tap{|c| c.alpha = 255}
  end

  def health_bar_offset
    height / 2 * 1.1
  end
end