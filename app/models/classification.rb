class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  has_many :captains, through: :boats

  def self.my_all
    self.all
  end

  def self.longest
    a = Boat.all.select(:id).order(length: "DESC").limit(1)
    b = self.all.select do |c|
      c.boats.ids.include?(a.ids[0])
    end
    c = Classification.where(id: b.map(&:id))
  end

end
