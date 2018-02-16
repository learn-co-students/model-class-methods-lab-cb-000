class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: :classifications).where(:classifications => {:name => "Catamaran"}).uniq
  end

  def self.sailors
    self.joins(boats: :classifications).where(:classifications => {:name => "Sailboat"}).uniq
  end

  def self.motorboat_operators
    self.joins(boats: :classifications).where(:classifications => {:name => "Motorboat"}).uniq
  end

  def self.talented_seafarers
    talented_seafarers = self.sailors & self.motorboat_operators
    self.where(id: talented_seafarers)
  end

  def self.non_sailors
    self.where.not(id: self.sailors)
  end

end
