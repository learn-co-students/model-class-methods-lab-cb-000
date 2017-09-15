class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, :through => :boats
  has_many :classifications, :through => :boat_classifications

  def self.catamaran_operators
    self.joins(:boats, :classifications).where("classifications.name = ?", "Catamaran").group("captains.id")
  end

  def self.sailors
    self.joins(:boats, :classifications).where("classifications.name = ?", "Sailboat").group("captains.id")
  end

  def self.talented_seamen
    self.joins(:boats, :classifications).where("classifications.name = 'Sailboat' OR classifications.name = 'Motorboat'").group("classifications.id")
  end

  def self.non_sailors
    self.select("captains.*").where.not(:id => Boat.sailboats.select("boats.*").map(&:captain_id).compact.uniq)
  end

end
