class Captain < ActiveRecord::Base
  has_many :boats


  def self.sailors
    self.joins("inner join boats on boats.captain_id = captains.id inner join boat_classifications on boat_classifications.boat_id = boats.id inner join classifications on classifications.id = boat_classifications.classification_id where classifications.name = 'Sailboat'").uniq
  end

  def self.catamaran_operators
    self.joins("inner join boats on boats.captain_id = captains.id inner join boat_classifications on boat_classifications.boat_id = boats.id inner join classifications on classifications.id = boat_classifications.classification_id where classifications.name = 'Catamaran'").uniq

  end

  def self.motorboats
    self.joins("inner join boats on boats.captain_id = captains.id inner join boat_classifications on boat_classifications.boat_id = boats.id inner join classifications on classifications.id = boat_classifications.classification_id where classifications.name = 'Motorboat'").uniq

  end


  def self.non_sailors
    self.where.not(name: self.sailors_array)
  end

  def self.talented_seamen
    self.where(name: self.sailors_array).where(name: self.motorboats_array)
  end

  def self.sailors_array
    array = self.sailors
    sailors = array.collect {|s| s.name}
  end

  def self.motorboats_array
    array = self.motorboats
    motorboaters = array.collect {|m| m.name}
  end

end
