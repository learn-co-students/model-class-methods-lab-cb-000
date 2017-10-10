class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    by_classification 'Catamaran'
  end

  def self.sailors
    by_classification 'Sailboat'
  end

  def self.motorboaters
    by_classification 'Motorboat'
  end

  def self.talented_seamen
    with_classifications.
      where(classifications: {name: %w(Sailboat Motorboat)}).
      group('captains.name').
      having('count(DISTINCT classifications.name) >= 2')
  end

  def self.non_sailors
    where.not(name: sailors.select(:name))
  end

  def self.by_classification(classification)
    with_classifications.
      where(classifications: {name: classification}).
      distinct
  end

  def self.with_classifications
    joins(boats: { boat_classifications: :classification })
  end
end
