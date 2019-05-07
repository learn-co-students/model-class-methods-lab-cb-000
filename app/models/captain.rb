class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: {boat_classifications: :classification}).where("classifications.name = 'Catamaran'").distinct
  end

  def self.sailors
    self.joins(boats: {boat_classifications: :classification}).where("classifications.name = 'Sailboat'").distinct
  end

  def self.talented_seafarers
    self.joins(boats: {boat_classifications: :classification}).where("classifications.name = 'Motorboat'").where(id: self.sailors).distinct
  end


  def self.non_sailors
    self.joins(boats: {boat_classifications: :classification}).where.not(id: self.sailors).distinct
  end

end
