class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    classification_id = Classification.find_by(name: "Catamaran").id
    boats = Boat.all.select do |boat|
      boat.classification_ids
    end
    # Boat.find_by(classifications: "")
  end

end
