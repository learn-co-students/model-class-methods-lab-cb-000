class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all
  end

  def self.longest
    with_boats.where(boats: {length: Boat.select('max(length)')})
  end



  def self.with_boats
    joins(:boats)
  end
end
