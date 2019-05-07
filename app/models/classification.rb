class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    longest_boat_id = self.joins(boat_classifications: :boat).order("boats.length desc").select("boats.id").pluck("boats.id").first
    self.joins(:boat_classifications).where("boat_classifications.boat_id = ?", longest_boat_id)
  end
end
