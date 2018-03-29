class Captain < ActiveRecord::Base
  has_many :boats

  def self.find_by_boat_classification(classification_name)
    joins(boats: :classifications).where("classifications.name =?", classification_name)
  end

  def self.catamaran_operators
      find_by_boat_classification("Catamaran")
  end

  def self.sailors
      find_by_boat_classification("Sailboat").uniq
  end

  def self.talented_seafarers
      captains = find_by_boat_classification("Sailboat").uniq
      talented_captains = []

      captains.each do |captain|
          talented_captains << captain.id if Captain.find_by_boat_classification("Motorboat").include?(captain)
      end

      where(id: talented_captains)
  end

  def self.non_sailors
      where.not(id: self.sailors)
  end
end
