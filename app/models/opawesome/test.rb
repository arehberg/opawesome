class Opawesome::Test < ActiveRecord::Base
  attr_accessible :key, :name, :options_attributes

  has_many :options, class_name: Opawesome::TestOption

  accepts_nested_attributes_for :options, allow_destroy: true

  validates :key, presence: true, uniqueness: true

  def selection_count
    options.map(&:selection_count).reduce(:+)
  end

  def conversion_count
    options.map(&:conversion_count).reduce(:+)
  end

  def best_option
    best_option = options.first

    options.each do |option|
      if option.conversion_rate > best_option.conversion_rate
        best_option = option
      end
    end

    best_option
  end

  # TODO: Break this out in to an OptionSelector class so we can support different selection strategies
  def select_option
    # round robbin until each option has at least 20 conversions, which gives us a good base to start from
    options.shuffle.each do |option|
      return option if option.conversion_count < 20
    end

    # use the best performing option most of the time, but try others as well
    epsilon = 0.1
    random = Random.rand

    if random < epsilon
      options.sample
    else
      best_option
    end
  end
end
