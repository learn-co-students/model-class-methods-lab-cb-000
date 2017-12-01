class Captain < ActiveRecord::Base
  has_many :boats


    def self.catamaran_operators
      #should return two captains
      # select captains where boats include an instance with classification catamaran
      includes(boats: :classifications).where(classifications: {name: "Catamaran"})
      #includes(obj: objs).where(objs: {name: str})
      # missed syntax for "boats: :classifications"

    end

    def self.sailors
      includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
    end

    def self.motorboaters
      includes(boats: :classifications).where(classifications: {name: "Motorboat"}).distinct
    end


    def self.talented_seamen
      # it "returns captains of motorboats and sailboats" do
      #   captains = ["Captain Cook", "Samuel Axe"]
      #   expect(Captain.talented_seamen.pluck(:name)).to eq(captains)
      # binding.pry
      where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
      #with an and query, can use the quotes to simulate SQL and then the two methods above.  Should have noticed the possibility to combine the methods above that is a FI pattern
    end

    def self.non_sailors
      where("id NOT IN (?)", self.sailors.pluck(:id))

    end

end
