class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    with_classifications.
      where(classifications: {name: 'Catamaran'}).
      distinct
  end

  def self.sailors
    with_classifications.
      where(classifications: {name: 'Sailboat'}).
      distinct
  end

  def self.talented_seamen
    # with_classifications.
    #   where(classifications: {name: %w(Sailboat Motorboat)}).
    #   group('captains.name').
    #   having('count(DISTINCT classifications.name) >= 2')
    where(id:, sailors.select(:id), id: motorboaters.select(:id))
  end

  def self.non_sailors
    where.not(name: sailors.select(:name))
  end

  def self.with_classifications
    joins(boats: { boat_classifications: :classification })
  end
end
