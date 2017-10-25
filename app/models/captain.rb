class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    self.joins(boats: :classifications).where(classifications: {name: "Sailboat"}).group("captains.name")
  end

  def self.talented_seamen
    a = self.joins(boats: :classifications).group("captains.name").select do |cap|
      cap.captain_classifications.include?("Sailboat") && cap.captain_classifications.include?("Motorboat")
    end
    b = Captain.where(id: a.map(&:id))
  end

  def self.non_sailors
    a = self.joins(boats: :classifications).group("captains.name").select do |cap|
      !(cap.captain_classifications.include?("Sailboat"))
    end
    b = Captain.where(id: a.map(&:id))
  end

  def captain_classifications
    arr = []
    self.boats.all.each do |boat|
      boat.classifications.all.each do |classification|
        arr << classification.name
      end
    end
    arr
  end

end
