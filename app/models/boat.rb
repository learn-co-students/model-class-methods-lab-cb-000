class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.limit(5)
  end

  def self.longest
    # their solution:
    order('length DESC').first
    # Boat.where(length: Boat.maximum(:length)).first
  end

  def self.dinghy
    Boat.where("length < 20")
  end

  def self.ship
    Boat.where("length >= 20")
  end

  def self.last_three_alphabetically
    all.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

  def self.sailboats
    includes(:classifications).where(classifications: { name: 'Sailboat'})
  end

  def self.with_three_classifications
    # their solution: joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
    Boat.joins(:boat_classifications).group('boat_id').having('count(boat_id) = 3')
  end

end
