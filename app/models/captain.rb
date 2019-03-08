class Captain < ActiveRecord::Base
  has_many :boats


  def self.catamaran_operators
    # binding.pry
    Captain.joins(boats: :classifications).where('classifications.name = ?', 'Catamaran')
  end

  def self.sailors
    Captain.joins(boats: :classifications).where('classifications.name = ?', 'Sailboat').uniq
  end

  def self.talented_seafarers
    motor_boats = Captain.joins(boats: :classifications).where('classifications.name = ?', 'Motorboat').uniq
    motor_boats & sailors
  end

  def self.non_sailors
    all - sailors
  end

end
