class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    #boat classification = catamaran
    includes(boats: [:classifications]).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    #return a boat with a classifications of a sailboat
    includes(boats: [:classifications]).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboaters
    includes(boats: [:classifications]).where(classifications: {name: "Motorboat"}).uniq
  end

  def self.talented_seamen
    #returns captains of motorboats and sailboats
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
  end

  def self.non_sailors
    #returns captains who are not sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end


end
