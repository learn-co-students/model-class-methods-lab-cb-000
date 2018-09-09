class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.catamarans
    cat = Classification.find_by(name: "Catamaran")
    self.all.select do |boat|
      boat.classifications.include?(cat)
    end
  end
end
