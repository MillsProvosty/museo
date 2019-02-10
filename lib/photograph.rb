class Photograph

  attr_reader :id,
              :name,
              :artist_id,
              :year

  def initialize(photograph_attributes)
    @id = photograph_attributes[:id]
    @name = photograph_attributes[:name]
    @artist_id = photograph_attributes[:artist_id]
    @year = photograph_attributes[:year]
  end

end
