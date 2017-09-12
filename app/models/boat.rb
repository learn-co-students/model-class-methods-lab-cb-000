class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications


  def self.first_five #will give the first five boats
      all.limit(5)
  end

  def self.dinghy #returns boats shorter than 20 feet
    all.where(length: (0..19))
  end

  def self.ship #returns boats longer than or equal to 20
    all.where("length > ?", 20)
  end

  def self.last_three_alphabetically #returns the last three boats returned when in alphabetical order
    all.order(name: :desc).limit(3)
  end

  def self.without_a_captain #returns boats without a caption -- have to look in captian model
    all.where(captain_id: nil)
  end

  def self.sailboats #returns boats that are sailboats
    joins(:classifications).where("classifications.name = 'Sailboat'")
  end

  def self.with_three_classifications #returns boats with three classifications
    joins(:classifications).group(:boat_id).having("COUNT(*) = 3")
  end

  def self.longest
    all.order(length: :desc).first
  end


end
