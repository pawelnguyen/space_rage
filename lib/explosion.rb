class Explosion
  TILES_AMOUNT = 40
  TIME_PER_TILE = 25

  attr_reader :window, :x, :y

  def initialize(window, x, y)
    @window, @x, @y = window, x, y
  end

  def draw
    explosion_image.draw_rot(x, y, 3, rotation, 0.5, 0.5, size_scale, size_scale) unless animation_finished?
  end

  def animation_finished?
    Gosu::milliseconds - start_time > TIME_PER_TILE * TILES_AMOUNT
  end

  alias_method :deletable?, :animation_finished?

  class << self
    def create_from(window, object)
      new(window, object.x, object.y)
    end
  end

  private

  def explosion_image
    explosion_animation[(Gosu::milliseconds - start_time) / TIME_PER_TILE % TILES_AMOUNT]
  end

  def explosion_animation
    @explosion_animation ||= Gosu::Image.load_tiles(window, "assets/explosion.png", 128, 128, false)
  end

  def start_time
    @start_time ||= Gosu::milliseconds
  end

  def rotation
    @rotation ||= random_rotation
  end

  def size_scale
    @size_scale ||= random_size_scale
  end

  def random_rotation
    rand(360)
  end

  def random_size_scale
    rand(40) / 100.0 + 0.8
  end
end
