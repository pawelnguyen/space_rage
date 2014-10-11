require 'RMagick'

class HealthBar
  HEIGHT = 6
  COLOR = "green"

  attr_reader :window, :width, :percentage

  def initialize(window, width = 100, percentage = 100)
    @window, @width, @percentage = window, width, percentage
  end

  def draw(x, y)
    health_bar_image.draw_rot(x, y, 4, 0, 0.5, 0.5)
  end

  private

  def health_bar_image
    Gosu::Image.new(window, rmagick_image)
  end

  def rmagick_image
    Magick::Image.new(percentage / 100 * width, HEIGHT) { self.background_color = COLOR }
  end
end
