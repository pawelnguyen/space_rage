class Meteor
  SIZE_SCALE = 0.2
  SPEED = 5

  def initialize(window, window_width, window_height)
    @window_width = window_width
    @window_height = window_height

    @meteor_image = Gosu::Image.new(window, "assets/meteor.png", true)
    @x = rand(@window_width - width)
    @y = - height
  end

  def draw
    @meteor_image.draw(@x, @y, 1, SIZE_SCALE, SIZE_SCALE)
  end

  def move
    @y += SPEED
  end

  def deletable?
    @y > @window_height
  end

  private

  def width
    @meteor_image.width * SIZE_SCALE
  end

  def height
    @meteor_image.height * SIZE_SCALE
  end
end