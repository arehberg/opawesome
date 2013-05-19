class Opawesome::TestOption < ActiveRecord::Base
  attr_accessible :test_id, :value, :conversion_count, :selection_count

  belongs_to :test, class_name: Opawesome::Test

  def conversion_rate
    (selection_count == 0 or conversion_count == 0) ? 0 : (conversion_count.to_f / selection_count.to_f * 100.0)
  end

  def select!
    self.selection_count += 1
    save!
  end

  def convert!
    self.conversion_count += 1
    save!
  end
end
