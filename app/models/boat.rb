class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.limit(5)
  end

  def self.last_three_alphabetically
    Boat.limit(3).order(:name).reverse_order
  end

  def self.dinghy
    where("length < 20")
  end

  def self.ship
    where("length > 20")
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

  def self.sailboats
    Boat.select('boats.name').joins(:boat_classifications, :classifications).find_by('classifications.name' => "sailboat")
  end

  def self.with_three_classifications
  end

end
