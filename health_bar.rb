require 'RMagick'

class HealthBar
  HEIGHT = 6
  COLOR = "green"

  attr_reader :window, :initial_width, :percentage

  def initialize(window, initial_width = 100, percentage = 1)
    @window, @initial_width, @percentage = window, initial_width, percentage
  end

  def draw(x, y)
    health_bar_image.draw_rot(x, y, 4, 0, 0.5, 0.5)
  end

  def set_percentage(percentage)
    @percentage = percentage if percentage > 0
    rmagick_image.resize!(width, HEIGHT)
  end

  private

  def health_bar_image
    Gosu::Image.new(window, rmagick_image)
  end

  def rmagick_image
    @rmagick_image ||= Magick::Image.new(width, HEIGHT) { self.background_color = COLOR }
  end

  def width
    percentage * initial_width
  end
end
