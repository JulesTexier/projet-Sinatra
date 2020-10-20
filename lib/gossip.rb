require 'pry'
require 'csv'

class Gossip
  attr_accessor :author, :content
    
  #j'initialise mes variables
    def initialize(author, content)
        @author = author
        @content = content
    end

    #permet d'enregistrer un nouveau gossip
    def save
        CSV.open("db/gossip.csv", "ab") do |csv|
          csv << [@author, @content]
        end
    end

    #permet d'afficher tous les  Gossip
    def self.all
        all_gossips = []
        CSV.read("db/gossip.csv").each do |csv_line|
            all_gossips << Gossip.new(csv_line[0], csv_line[1])
        end
        return all_gossips
    end

    #permet d'enregistrer un nouveau gossip
    def self.find(id)
        index_gossip = Gossip.all 
        return index_gossip[id.to_i - 1]        
    end

    #permet de mettre à jour un gossip avec une variable supp (id)
    def self.update(id,author,content)
      gossips = []
  
      CSV.read("db/gossip.csv").each_with_index do |row, index|
        if id.to_i == (index + 1) 
          gossips << [author, content]
        else
          gossips << [row[0], row[1]]
        end
      end
  
      CSV.open("db/gossip.csv", "w") do |csv| 
        gossips.each do |row|
          csv << row
        end
      end
    end     
end

