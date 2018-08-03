class Captain < ActiveRecord::Base
  has_many :boats

  def Captain::catamaran_operators
    includes(boats: :classifications).where(classifications: { name: 'Catamaran' })
  end

  def Captain::sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def Captain::motorboat_operators
    includes(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end

  def Captain::talented_seafarers
    where(id: sailors.pluck(:id) & motorboat_operators.pluck(:id))
  end

  def Captain::non_sailors
    where.not(id: sailors.pluck(:id))
  end
end
