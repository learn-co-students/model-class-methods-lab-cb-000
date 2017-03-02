class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    all.limit(5)
  end

  def self.dinghy
    where(table[:length].lt(20))
  end

  def self.ship
    where(table[:length].gteq(20))
  end

  def self.last_three_alphabetically
    order(table[:name].desc).limit(3)
  end

  def self.without_a_captain
    where(table[:captain_id].eq(nil))
  end

  def self.sailboats
    #joins(:classifications).where(classifications: {name: "Sailboat"})
    classification = Classification.arel_table
    joins(:classifications).where(classification[:name].eq("Sailboat"))
  end

  def self.with_three_classifications
    #Boat.joins(:classifications).where(c[:size].gt(3))
    joins(:classifications).group(table[:name]).having(table[:name].count.gteq(3))
  end

  def self.longest_by_far
    order(table[:length].desc).first
  end    

  def self.table
    self.arel_table
  end

end
