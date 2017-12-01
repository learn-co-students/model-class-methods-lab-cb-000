class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all

  end

  def self.longest
    #returns classifications where boat is longest
    #boat.length
     # Boat.order(length: :desc).limit(1).classifications <- this doesn't work syntax
     # Can get classifications from Boat.first, but the query doesn't return a boat object, returns a relation.
     #Step 1: Get the right boat.  Step 2: get the classifications from that boat.
     #Boat.order(length: :desc).limit(1) returns the longest boat.
     #If this were easy, I would put the boat method in the boat class and call it from here.
# where("id NOT IN (?)", self.sailors.pluck(:id))
    # binding.pry
    # where("id IN (?)", Boat.longest.pluck(:id))
    Boat.longest.classifications
  end

end
