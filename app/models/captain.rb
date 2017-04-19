class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: 'Catamaran'})

    # SELECT "captains"."*" , "boats"."*", "classifications"."*"
    # FROM "captains"
    # LEFT OUTER JOIN "boats"
    # ON "boats"."captain_id" = "captains"."id"
    # LEFT OUTER JOIN "boat_classifications"
    # ON "boat_classifications"."boat_id" = "boats"."id"
    # LEFT OUTER JOIN "classifications"
    # ON "classifications"."id" = "boat_classifications"."classification_id"
    # WHERE "classifications"."name" = 'Catamaran'
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboaters
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seamen
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
