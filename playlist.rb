class Playlist
  attr_reader :name
  attr_accessor :songs
  
  def initialize(name)
    @name = name
    @songs = []
    
    yield(self) if block_given?
  end
  
  def <<(song)
    @songs << song
  end
  
  def length
    songs.inject(0) do |length, song|
      length += song.length
    end
  end
  
  def length_in_minutes
    length / 60
  end
  
  def shuffle!
    @songs.shuffle!
  end
end