class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.limit(5)
  end

  def self.dinghy
    self.where('length <?', 20)
  end

  def self.ship
    self.where("length >=?", 20)
  end

  def self.last_three_alphabetically
    self.order('name DESC').limit(3)
  end

  def self.without_a_captain
    self.where("captain_id IS NULL")
  end

  def self.sailboats
    self.joins(:classifications).where(:classifications => {:name => "Sailboat"})
  end

  def self.with_three_classifications
    with_three = []
    self.all.each do |boat|
      if boat.classifications.count >= 3
        with_three << boat.id
      end
    end
    self.where(id: with_three)
  end

  def self.longest
    self.order("length DESC").first
  end
end
