require 'rubygems'
require 'pp'
require 'mocha'
require 'test/unit'
require 'song'
require 'playlist'

class SongTest < Test::Unit::TestCase

  def test_initialize_should_accept_a_hash_of_attributes
    song = Song.new(:artist => 'Rolling Stones', :title => 'Beast of Burden', :length => 435)
    assert_equal 'Rolling Stones', song.artist
    assert_equal 'Beast of Burden', song.title
    assert_equal 435, song.length
  end

  def test_length_in_minutes_returns_proper_time
    song = Song.new(:length => 60 * 5)
    assert_equal 5, song.length_in_minutes
  end

  def test_play!
    song = Song.new(:length => 60)
    assert song.play!
    assert song.playing?
  end

end



class PlaylistTest < Test::Unit::TestCase

  def test_should_allow_simple_instantiation
    assert p = Playlist.new('The Best Songs')
    assert_equal 'The Best Songs', p.name
  end

  def test_can_add_songs_to_songs_collection
    p = Playlist.new('test')
    assert_equal 0, p.songs.size
    p << Song.new(:artist => "Tool", :title => "46 and 2")
    assert p.songs.detect{ |song| song.title == "46 and 2" }
  end

  def test_should_allow_optional_instantiation_with_a_block
    scope_pop = nil
    Playlist.new('The Best songs') do |playlist|
      scope_pop = playlist
    end

    assert scope_pop.is_a?(Playlist)
  end

  def test_length_should_return_sum_of_song_lengths
    p = Playlist.new('tester')
    p << Song.new(:length => 100)
    p << Song.new(:length => 600)

    assert_equal 700, p.length
  end

  def test_length_in_minutes_should_return_proper_time
    p = Playlist.new('short')
    p << Song.new(:length => 600)

    assert_equal 10, p.length_in_minutes
  end

  def test_shuffle
    songs = Array.new(1000){ |n| Song.new(:title => "Song #{n}") }
    p = Playlist.new('shuffled')
    p.songs = songs.dup
    p.shuffle!
    assert songs != p.songs
    assert_equal songs.length, p.songs.length
  end
end