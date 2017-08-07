class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.limit(5)
  end

  def self.dinghy
    self.where("length < ?", 20)
  end

  def self.ship
    self.where("length > ?", 20)
  end

  def self.longest
        self.where("length = ?", self.maximum("length"))
  end

  def self.last_three_alphabetically

    self.order("name").reverse_order.limit(3)
  end

  def self.without_a_captain
    self.where("captain_id IS NULL")
  end

  def self.sailboats
    self.joins("inner join boat_classifications on boat_classifications.boat_id = boats.id inner join classifications on classifications.id = boat_classifications.classification_id where classifications.name = 'Sailboat'")
  end

  def self.with_three_classifications
    self.joins("inner join boat_classifications on boat_classifications.boat_id = boats.id inner join classifications on classifications.id = boat_classifications.classification_id group by boats.name having count(boat_classifications.classification_id) = 3")
  end

end
