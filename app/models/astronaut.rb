class Astronaut < ApplicationRecord
  validates_presence_of :name, :age, :job

  has_many :astronaut_missions
  has_many :missions, through: :astronaut_missions

  def self.avg_age
    Astronaut
    .average(:age)
  end

  def all_missions_sorted
    self
    .missions
    .pluck(:title)
    .sort
  end

  def total_time_in_space
    self
    .missions
    .sum(:time_in_space)
  end
end
