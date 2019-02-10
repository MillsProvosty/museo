require 'minitest/autorun'
require 'minitest/pride'
require './lib/curator'
require './lib/photograph'
require './lib/artist'
require 'pry'

class CuratorTest < Minitest::Test

  def setup
    @curator = Curator.new
    @photo_1 = {
                id: "1",
                name: "Rue Mouffetard, Paris (Boy with Bottles)",
                artist_id: "1",
                year: "1954"
              }
    @photo_2 = {
                id: "2",
                name: "Moonrise, Hernandez",
                artist_id: "2",
                year: "1941"
              }
    @photo_3 = {
                id: "3",
                name: "Identical Twins, Roselle, New Jersey",
                artist_id: "3",
                year: "1967"
              }
    @photo_4 = {
                id: "4",
                name: "Child with Toy Hand Grenade in Central Park",
                artist_id: "3",
                year: "1962"
              }
    @artist_1 = {
                id: "1",
                name: "Henri Cartier-Bresson",
                born: "1908",
                died: "2004",
                country: "France"
                }
    @artist_2 = {
                id: "2",
                name: "Ansel Adams",
                born: "1902",
                died: "1984",
                country: "United States"
                }
    @artist_3 = {
                id: "3",
                name: "Diane Arbus",
                born: "1923",
                died: "1971",
                country: "United States"
                }
  end

  def test_it_exists
    assert_instance_of Curator, @curator
  end

  def test_curator_starts_with_default_empty_artists
    assert_equal [], @curator.artists
  end

  def test_curator_starts_with_default_empty_photographs
    assert_equal [], @curator.photographs
  end

  def test_curator_can_create_new_instance_of_Photograph
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    @curator.photographs.each do |photograph_object|
      assert_instance_of Photograph, photograph_object
    end
    assert_equal 2, @curator.photographs.count
  end

  def test_first_element_in_photographs_array
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    assert_instance_of Photograph, @curator.photographs.first
  end

  def test_can_access_first_photo_name
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)", @curator.photographs.first.name
  end

  def test_curator_can_create_new_instance_of_Artist
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)

    @curator.artists.each do |artist_object|
      assert_instance_of Artist, artist_object
    end
    assert_equal 2, @curator.artists.count
  end

  def test_first_element_in_artists_array
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)

    assert_instance_of Artist, @curator.artists.first
  end

  def test_can_access_first_artist_name
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)

    assert_equal "Henri Cartier-Bresson", @curator.artists.first.name
  end

  def test_can_find_artist_by_id
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    found_artist = @curator.find_artist_by_id("1").name

    assert_instance_of Artist, @curator.find_artist_by_id("1")
    assert_equal "Henri Cartier-Bresson", found_artist
  end

  def test_can_find_photograph_by_id
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    found_photograph = @curator.find_photograph_by_id("2").name

    assert_instance_of Photograph, @curator.find_photograph_by_id("2")
    assert_equal "Moonrise, Hernandez", found_photograph
  end

  def test_can_find_photographs_by_artist
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)

    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)

    diane_arbus = @curator.find_artist_by_id("3")
    expected = @curator.find_photographs_by_artist(diane_arbus)
    # binding.pry

    assert_equal expected, @curator.find_photographs_by_artist(diane_arbus)
    assert_equal 2, expected.length
  end

  def test_can_find_artist_object_with_multiple_photographs

    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)

    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)

    diane_arbus = @curator.find_artist_by_id("3")

    assert_equal [diane_arbus], @curator.artists_with_multiple_photographs
    assert_equal 1, @curator.artists_with_multiple_photographs.length
    assert_equal diane_arbus, @curator.artists_with_multiple_photographs.first
  end

  def test_photographs_taken_by_artist_from_a_particular_country
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)

    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)

    diane_arbus = @curator.find_artist_by_id("3")
    ansel_adams = @curator.find_artist_by_id("2")

    photos_by_diane_arbus = @curator.find_photographs_by_artist(diane_arbus)
    photos_by_ansel_adams = @curator.find_photographs_by_artist(ansel_adams)

    photos_objects = photos_by_ansel_adams.concat(photos_by_diane_arbus)

    assert_equal photos_objects, @curator.photographs_taken_by_artist_from("United States")
    assert_equal [], @curator.photographs_taken_by_artist_from("Argentina")
  end

end
