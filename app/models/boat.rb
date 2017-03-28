class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

 def self.last_three_alphabetically
   self.order(name: :desc).limit(3)
 end

 def self.ship
   self.where(self.arel_table[:length].gteq(20))
 end

 def self.sailboats
   self.joins(:classifications).where(classifications: {name: "Sailboat"})
 end

 def self.with_three_classifications
   bc = BoatClassification.arel_table
   self.joins(:boat_classifications).group(:boat_id).having(
     bc[:classification_id].count.eq(3)
   )
 end

 def self.first_five
   self.limit(5)
 end

 def self.without_a_captain
   self.where(captain_id: nil)
 end

 def self.dinghy
   self.where(self.arel_table[:length].lteq(20))
 end
end
