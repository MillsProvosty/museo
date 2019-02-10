class Artist

  attr_reader :id,
              :name,
              :born,
              :died,
              :country

  def initialize(artist_hash)
    @id = artist_hash[:id]
    @name = artist_hash[:name]
    @born = artist_hash[:born]
    @died = artist_hash[:died]
    @country = artist_hash[:country]
  end
end
