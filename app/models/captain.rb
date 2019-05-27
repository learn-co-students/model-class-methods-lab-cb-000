class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: {boat_classifications: :classification}).where("classifications.name = ?", "Catamaran")
  end

  def self.sailors
    self.joins(boats: {boat_classifications: :classification}).where("classifications.name = ?", "Sailboat").uniq
  end

  def self.talented_seamen
    motorboaters = self.joins(boats: {boat_classifications: :classification}).where("classifications.name = ?", "Motorboat").uniq.pluck("captains.id")
    sailors = self.sailors.pluck("captains.id")
    self.where(id: motorboaters & sailors)
  end

  def self.non_sailors
    self.where(id: Captain.all.pluck(:id).to_a - self.sailors.pluck("captains.id").to_a)
  end
end
