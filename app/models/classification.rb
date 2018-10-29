class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  
  def self.my_all
    all
  end
  
  def self.longest
    joins(:boats).order(length: :desc).limit(1)
  end
end
