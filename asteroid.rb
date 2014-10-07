class Asteroid
  attr_reader :x, :y

  def initialize(window, window_width, window_height)
    @window_width = window_width
    @window_height = window_height

    @asteroid_image = Gosu::Image.new(window, "assets/asteroid.png", true)
    @speed = random_speed
    @rotation_speed = random_rotation
    @rotation = 0
    @rotation_direction = random_rotation_direction
    @size_scale = random_size_scale
    @x = rand(@window_width - width / 2) + width / 2
    @y = -height
  end

  def draw
    @asteroid_image.draw_rot(@x, @y, 2, @rotation, 0.5, 0.5, @size_scale, @size_scale)
  end

  def move
    @y += @speed
    @rotation += @rotation_speed * @rotation_direction
  end

  def deletable?
    @y - height / 2 > @window_height
  end

  def radius
    width / 2
  end

  private

  def width
    @asteroid_image.width * @size_scale
  end

  def height
    @asteroid_image.height * @size_scale
  end

  def random_speed
    rand(400) / 100.0 + 3
  end

  def random_rotation
    rand(200) / 100.0
  end

  def random_rotation_direction
    [-1, 1].sample
  end

  def random_size_scale
    0.2 + rand(10) / 100.0
  end
end