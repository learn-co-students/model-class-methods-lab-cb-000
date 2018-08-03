class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def Classification::my_all
    all
  end

  def Classification::longest
    Boat.longest.classifications
  end
end
