class Ship
  SIZE_SCALE = 0.5
  MOVE_OFFSET = 5
  BOTTOM_OFFSET = 30

  def initialize(window, window_width, window_height)
    @ship_image = Gosu::Image.new(window, "assets/ship.png", true)
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