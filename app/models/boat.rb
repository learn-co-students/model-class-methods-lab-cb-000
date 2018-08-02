class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def Boat::first_five
    # first five boats
    where(id: (1..5))
  end

  def Boat::dinghy
    # boats shorter than 20 feet
    where("length <?", 20)
  end

  def Boat::ship
    # boats 20 feet or longer
    where("length >=?", 20)
  end

  def Boat::last_three_alphabetically
    # last three boats in alphabetical order
  end

  def Boat::without_a_captian
    where(captain_id: nil)
  end

  def Boat::sailboats
    # all boats that are sailboats
  end

  def Boat::with_three_classifications
    # boats with three classifications
  end
end
