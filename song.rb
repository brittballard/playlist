class Song
  attr_reader :artist, :title, :length, :state
  
  def initialize(attributes)
    @artist = attributes[:artist]
    @title = attributes[:title]
    @length = attributes[:length]
  end
  
  def length_in_minutes
    @length / 60
  end
  
  def play!
    @state = :playing
  end
  
  def playing?
    @state == :playing 
  end
end