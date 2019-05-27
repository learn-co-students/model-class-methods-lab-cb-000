class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    Classification.all
  end

  def self.longest
    max = self.joins(boats: :boat_classifications).maximum("boats.length")
    self.joins(boats: :boat_classifications).where("boats.length = ?", max).uniq
  end
end
