require 'RMagick'

class HealthBar
  HEIGHT = 6
  COLOR = "green"
  BACKGROUND_COLOR = "red"

  attr_reader :window, :initial_width, :percentage

  def initialize(window, initial_width = 100, percentage = 1)
    @window, @initial_width, @percentage = window, initial_width, percentage
  end

  def draw(x, y)
    image.draw_rot(left_corner(x), y, 5, 0, 0, 0.5)
    background_image.draw_rot(x, y, 4, 0, 0.5, 0.5)
  end

  def set_percentage(percentage)
    @percentage = percentage if percentage > 0
    @image = nil
    rmagick_image.resize!(width, HEIGHT)
  end

  private

  def image
    @image ||= Gosu::Image.new(window, rmagick_image)
  end

  def rmagick_image
    @rmagick_image ||= Magick::Image.new(width, HEIGHT) { self.background_color = COLOR }
  end

  def width
    percentage * initial_width
  end

  def left_corner(x)
    x - initial_width / 2
  end

  def background_image
    @background_image ||= Gosu::Image.new(window, background_rmagick_image)
  end

  def background_rmagick_image
    @background_rmagick_image ||= Magick::Image.new(width, HEIGHT) { self.background_color = BACKGROUND_COLOR }
  end
end
