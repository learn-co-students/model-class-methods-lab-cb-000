class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def Boat::first_five
    limit(5)
  end

  def Boat::dinghy
    where("length <?", 20)
  end

  def Boat::ship
    where("length >=?", 20)
  end

  def Boat::last_three_alphabetically
    order(name: :desc).limit(3)
  end

  def Boat::without_a_captain
    where(captain_id: nil)
  end

  def Boat::sailboats
    includes(:classifications).where(classifications: { name: 'Sailboat' })
  end
  def Boat::with_three_classifications
    joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
  end

  def Boat::non_sailboats
    where.not(id: sailboats.pluck(:id))
  end

  def Boat::longest
    order(length: :desc).first
  end
end
