class StorageItem < ActiveRecord::Base
  attr_accessible :name, :cost, :count, :production_time

  belongs_to :issue

  validates :issue_id, :presence => true
  validates :name, :presence => true
  validate :name_unique_for_project
  validate :cost_is_positive
  validate :count_is_positive

  scope :name_like, lambda {|name|
    pattern = "%#{name}%"
    where("LOWER(#{table_name}.name) LIKE LOWER(?)", pattern)
  }

  def name_unique_for_project
    project = issue.try(:project)
    if project
      if self.class.joins(:issue).where("issues.project_id" => project.id, "#{table_name}.name" => name).first
        errors.add(:name, 'Name must be unique')
      end
    end
  end

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
