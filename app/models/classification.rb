class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all
  end

  def self.longest
    max_length = Boat.maximum("length")
    joins(:boats).where("boats.length = ?", max_length)
  end
end
