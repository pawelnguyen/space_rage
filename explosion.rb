class Explosion
  TILES_AMOUNT = 40
  TIME_PER_TILE = 25

  def initialize(window, x, y)
    @explosion_animation = Gosu::Image.load_tiles(window, "assets/explosion.png", 128, 128, false)
    @start_time = Gosu::milliseconds
    @x, @y = x, y
    @rotation = random_rotation
    @size_scale = random_size_scale
  end

  def draw
    image = @explosion_animation[(Gosu::milliseconds - @start_time) / TIME_PER_TILE % TILES_AMOUNT]
    image.draw_rot(@x, @y, 3, @rotation, 0.5, 0.5, size_scale, size_scale) unless animation_finished?
  end

  def animation_finished?
    Gosu::milliseconds - @start_time > TIME_PER_TILE * TILES_AMOUNT
  end

  alias_method :deletable?, :animation_finished?

  class << self
    def create_from(window, object)
      new(window, object.x, object.y)
    end
  end

  private

  def random_rotation
    rand(360)
  end

  def random_size_scale
    rand(40) / 100.0 + 0.8
  end

  def size_scale
    @size_scale
  end

end