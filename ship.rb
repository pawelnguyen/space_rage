class Ship
  SIZE_SCALE = 0.5
  MOVE_OFFSET = 5
  BOTTOM_OFFSET = 30
  WIDTH = 146

  def initialize(window, window_width, window_height)
    @ship_image = Gosu::Image.new(window, "assets/ship.png", true)
    @window_width = window_width
    @window_height = window_height
    @x = @window_width / 2
    @y = @window_height - height / 2 - BOTTOM_OFFSET
  end

  def draw
    @ship_image.draw_rot(@x, @y, 1, 180, 0.5, 0.5, SIZE_SCALE, SIZE_SCALE)
  end

  def move_left
    @x -= MOVE_OFFSET if within_window?(@x - MOVE_OFFSET)
  end

  def move_right
    @x += MOVE_OFFSET if within_window?(@x + MOVE_OFFSET)
  end

  def collides_with?(object)
    collides?(object.x, object.y, object.radius)
  end

  def collides?(x1, y1, r = 0)
    Gosu.distance(x1, y1, @x, @y) < r + radius
  end

  def radius
    width / 2 # simple for now
  end

  private

  def width
    WIDTH * SIZE_SCALE
  end

  def height
    @ship_image.height * SIZE_SCALE
  end

  def within_window?(x)
    x > width / 2 && x < @window_width - width / 2
  end
end