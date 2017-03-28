class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, through: :boats
  has_many :classifications, through: :boats

  @@classification = Classification.arel_table
  @@boat_classification = BoatClassification.arel_table

  def self.non_sailors
    sailor_ids = Captain.sailors.pluck(:id)
    Captain.where(Captain.arel_table[:id].not_in(sailor_ids))
  end

  def self.catamaran_operators
    self.joins(:classifications).where(@@classification[:name].eq("Catamaran")).distinct
  end

  def self.sailors
    self.joins(:classifications).where(@@classification[:name].eq("Sailboat")).distinct
  end

  def self.talented_seamen
    self.joins(:classifications).where(@@classification[:name].in(["Sailboat", "Motorboat"])).group(@@boat_classification[:classification_id]).having("count(*) >= 2")
  end

end
