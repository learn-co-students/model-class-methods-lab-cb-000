class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.select("classifications.*")
  end

  def self.longest
    self
      .select("classifications.*")
      .joins(:boat_classifications, :boats)
      .where("boats.length = ?", Boat.maximum(:length))
      .uniq
  end
end
