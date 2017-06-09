class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.limit(5)
  end

  def self.dinghy
    where("length < ?", 20)
  end

  def self.ship
    where("length >= ?", 20)
  end

  def self.last_three_alphabetically
    self.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    self.where("captain_id IS NULL")
  end

  def self.sailboats
    #uses the has_many relationship classifications, through: :boat_classifications
    includes(:classifications).where(classifications: {name: 'Sailboat'})

    #SELECT "boats"."*", "classifications"."*"
    #FROM "boats"
    #LEFT OUTER JOIN "boat_classifications"
    #ON "boat_classifications"."boat_id" = "boats"."id"
    #LEFT OUTER JOIN "classifications"
    #ON "classifications"."id" = "boat_classifications"."classification_id"
    #WHERE "classifications"."name" = ?  [["name", "Sailboat"]]
  end

  def self.with_three_classifications
    joins(:classifications).group('boats.id').having('COUNT(*) = 3').select('boats.*')

    # SELECT boats.*
    # FROM "boats"
    # INNER JOIN "boat_classifications"
    # ON "boat_classifications"."boat_id" = "boats"."id"
    # INNER JOIN "classifications"
    # ON "classifications"."id" = "boat_classifications"."classification_id"
    # GROUP BY boats.id
    # HAVING COUNT(*) = 3

  end

  def self.longest
    order('length DESC').first
  end

  def self.non_sailboats
    where('id NOT IN (?)', self.sailboats.pluck(:id))

    #self.sailboats.pluck(:id)
    # SELECT "boats"."id"
    # FROM "boats"
    # LEFT OUTER JOIN "boat_classifications"
    # ON "boat_classifications"."boat_id" = "boats"."id"
    # LEFT OUTER JOIN "classifications"
    # ON "classifications"."id" = "boat_classifications"."classification_id"
    # WHERE "classifications"."name" = ?  [["name", "Sailboat"]]
    # => [1, 2, 6, 8, 11, 12]

    # SELECT "boats".* 
    # FROM "boats"
    # WHERE (id NOT IN (1,2,6,8,11,12))


  end
end
