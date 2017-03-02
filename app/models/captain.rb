class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    join_capt_klass.where(klass[:name].eq("Catamaran"))
  end

  def self.sailors
    join_capt_klass.where(klass[:name].eq("Sailboat")).uniq
  end

  def self.motorboaters
    join_capt_klass.where(klass[:name].eq("Motorboat")).uniq
  end

  def self.talented_seamen
    where(id: sailors.pluck(:id) & motorboaters.pluck(:id))
  end

  def self.non_sailors
    where.not(id: sailors.pluck(:id))
  end

  private

    def self.table
      self.arel_table
    end

    def self.klass
      Classification.arel_table
    end

    def self.join_capt_klass
      self.joins(boats: :classifications)
    end

end
