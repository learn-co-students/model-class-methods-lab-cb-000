class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, through: :boats
  has_many :classifications, through: :boat_classifications

  def self.catamaran_operators
    Captain
      .joins(:boats)
      .joins(:boat_classifications)
      .joins(:classifications)
      .where("classifications.name = 'Catamaran'")
      .uniq
  end

  def self.sailors
    self
      .select("captains.*, COUNT(classifications.id) AS tally")
      .joins(:boats, :boat_classifications, :classifications)
      .where("classifications.name = 'Sailboat'")
      .group("captains.id")
  end

  def self.motorboaters
    self
      .select("captains.*")
      .joins(:boats, :boat_classifications, :classifications)
      .where("classifications.name = 'Motorboat'")
      .group("captains.id")
  end

  def self.talented_seafarers
    # SELECT captains.name, sailboat.tally AS sailboat_count, motorboat.tally AS motorboat_tally FROM captains
    # INNER JOIN (
    #   SELECT captains.id AS captain_id, COUNT(classifications.name) AS tally FROM captains
    #   JOIN boats ON boats.captain_id = captains.id
    #   JOIN boat_classifications ON boat_classifications.boat_id = boats.id
    #   JOIN classifications ON boat_classifications.classification_id = classifications.id
    #   WHERE classifications.name = 'Motorboat'
    #   GROUP BY captains.name
    # ) AS sailboat ON sailboat.captain_id = captains.id
    # INNER JOIN (
    #   SELECT captains.id AS captain_id, COUNT(classifications.name) AS tally FROM captains
    #   JOIN boats ON boats.captain_id = captains.id
    #   JOIN boat_classifications ON boat_classifications.boat_id = boats.id
    #   JOIN classifications ON boat_classifications.classification_id = classifications.id
    #   WHERE classifications.name = 'Sailboat'
    #   GROUP BY captains.name
    # ) AS motorboat ON motorboat.captain_id = captains.id

    sailors_sql = <<-SAILORS_SQL
      INNER JOIN (
        #{self.sailors.to_sql}
      ) AS sailboat ON sailboat.id = captains.id
    SAILORS_SQL

    motorboaters_sql = <<-MOTORBOATERS_SQL
      INNER JOIN (
        #{self.motorboaters.to_sql}
      ) AS motorboat ON motorboat.id = captains.id
    MOTORBOATERS_SQL

    self
      .select("captains.*")
      .joins(sailors_sql)
      .joins(motorboaters_sql)

  end

  def self.non_sailors
    # LEFT JOIN (
    #   SELECT captains.id, COUNT(classifications.id) AS tally FROM captains
    #   JOIN boats ON boats.captain_id = captains.id
    #   JOIN boat_classifications ON boat_classifications.boat_id = boats.id
    #   JOIN classifications ON boat_classifications.classification_id = classifications.id
    #   WHERE classifications.name = 'Sailboat'
    #   GROUP BY captains.id
    # ) AS sailboat ON sailboat.id = captains.id
    # WHERE sailboat.tally IS NULL;
    sql = <<-SQL
      LEFT JOIN (
        #{self.sailors.to_sql}
      ) AS sailboat ON sailboat.id = captains.id
    SQL

    self
      .select("captains.*")
      .joins(sql)
      .where("sailboat.tally IS NULL")
  end
end

# sailboat = 2
# motorboat = 5
# SELECT captains.name, COUNT(classifications.id) AS 