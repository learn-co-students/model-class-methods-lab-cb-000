class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.all[0..4]
  end

  def self.dinghy
    where('length < 20')
  end

  def self.ship
    where('length >= 20')
  end

  def self.last_three_alphabetically
    order(name: :desc)[0..2]
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

  def self.sailboats
    joins(:classifications).where('classifications.name = ?', 'Sailboat')
  end

  def self.with_three_classifications

    count_hash = joins(:classifications).group(:name).count
    count_hash.map do |k, v|
      if v == 3
        Boat.find_by(name: k)
      end
    end.compact
  end


  private

  def table
    Boat.arel_table[:id].eq(1)
    Boat.joins(:boat_categories)
  end


end
