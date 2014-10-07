class Explosion
  TILES_AMOUNT = 40
  SIZE_SCALE = 1
  TIME_PER_TILE = 25

  def initialize(window, x, y)
    @explosion_animation = Gosu::Image.load_tiles(window, "assets/explosion.png", 128, 128, false)
    @start_time = Gosu::milliseconds
    @x, @y = x, y
  end

  def draw
    image = @explosion_animation[(Gosu::milliseconds - @start_time) / TIME_PER_TILE % TILES_AMOUNT]
    image.draw(@x, @y, 3, SIZE_SCALE, SIZE_SCALE) unless animation_finished?
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
end