class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
      limit(5)
  end

  def self.dinghy
      where("length <?", "20")
  end

  def self.ship
      where("length >=?", "20")
  end

  def self.last_three_alphabetically
      order(name: :desc).limit(3)
  end

  def self.without_a_captain
      where("captain_id is null")
  end

  def self.find_classifications(classification_name)
      joins(:classifications).where("classifications.name =?",  classification_name)
  end

  def self.longest
      order(length: :desc).first
  end

  def self.sailboats
      find_classifications("Sailboat")
  end

  def self.with_three_classifications
     boats = []
     Boat.all.collect do |boat|
         boats << boat.id if boat.classifications.count >= 3
     end

     where(id: boats)
  end
end
