class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: :classifications).where(classifications: {name: "Catamaran"}).distinct
  end

  def self.sailors
    self.joins(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.motorboaters
    self.joins(boats: :classifications).where(classifications: {name: "Motorboat"}).distinct
  end

  def self.talented_seafarers
    motorboaters = self.motorboaters.pluck(:id)
    sailors = self.sailors.pluck(:id)
    self.where(id: [motorboaters & sailors])
  end

  def self.non_sailors
    self.where.not(id: self.sailors.pluck(:id))
  end

end
