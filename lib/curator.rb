require './lib/photograph'

class Curator

  attr_reader :artists,
              :photographs

  def initialize
    @artists = []
    @photographs = []
  end

  def add_photograph(photo_hash)
    photo = Photograph.new(photo_hash)
    @photographs << photo
  end

  def add_artist(artist_hash)
    artist = Artist.new(artist_hash)
    @artists << artist
  end

  def find_artist_by_id(artist_id)
    @artists.find do |artist_object|
      artist_object.id == artist_id
    end
  end

  def find_photograph_by_id(photograph_id)
    @photographs.find do |photograph_object|
      photograph_object.id == photograph_id
    end
  end

  def find_photographs_by_artist(artist_object)
    @photographs.find_all do |photograph_object|
      photograph_object.artist_id == artist_object.id
    end
  end

  def artists_with_multiple_photographs
    @artists.select do |artist_object|
      find_photographs_by_artist(artist_object).length > 1
    end
  end

  def photographs_taken_by_artist_from(country_name)
    artists_array = @artists.select do |artist_object|
       artist_object.country == country_name
    end

    artists_array.map do |artist|
      find_photographs_by_artist(artist)
    end.flatten
  end
end
