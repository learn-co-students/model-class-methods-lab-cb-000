class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.longest
    order(length: :desc).first
  end

  def self.first_five
    limit(5)
  end

  def self.dinghy
    where("length < ?", 20)
  end

  def self.ship
    where("length >= ?", 20)
  end

  def self.last_three_alphabetically
    order(name: :desc).limit(3)
  end

  def self.without_a_captain
    where(captain: nil)
  end

  def self.sailboats
    joins(:classifications).where(classifications: {name: "Sailboat"})
  end

  def self.non_sailboats
    where.not('id IN (?)', self.sailboats.pluck(:id))
  end

  def self.with_three_classifications
    joins(:classifications).group('boats.id').having("COUNT(*) = 3").select("boats.*")
    # self.select { |boat| boat.classifications.count == 3 } Will return an array, not ActiveRecord association
  end
end
