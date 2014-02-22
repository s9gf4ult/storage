class StorageItem < ActiveRecord::Base
  attr_accessible :name, :cost, :count, :production_time

  belongs_to :issue

  validates :name, :presence => true
  validate :cost_is_positive
  validate :count_is_positive

  scope :name_like, lambda {|name|
    pattern = "%#{name}%"
    where("LOWER(#{table_name}.name) LIKE LOWER(?)", pattern)
  }

  def cost_is_positive
    if cost.present?
      if not cost > 0
        errors.add(:cost, "Must be positive")
      end
    end
  end

  def count_is_positive
    if count.present?
      if not count > 0
        errors.add(:count, "Must be positive")
      end
    end
  end
end
