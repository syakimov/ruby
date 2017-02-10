
class Song
  attr_reader :name, :artist, :genre, :subgenre, :tags
  def initialize(name, artist, genre, subgenre, tags)
    @name = name
    @artist = artist
    @genre = genre
    @subgenre = subgenre
    @tags = tags
  end
end

class Collection
  def initialize(songs_as_string, artist_tags = {})
    @collection = []
    songs_as_string.each_line do |line|
      @collection << _song_factory(line, artist_tags)
    end
  end

  def _song_factory(params_as_string, artist_tags)
    name, artist, genre, tags = params_as_string.split('.').map(&:strip)
    genre, subgenre =  genre.include?(',') ? genre.split(', ') : genre
    tags = tags.nil? ? [] : tags.split(', ')
    [genre, subgenre].each { |el| tags << el.downcase unless el.nil? }
    tags |= artist_tags.fetch(artist, [])
    Song.new(name, artist, genre, subgenre, tags)
  end

  def find(criteria)
    @criteria = criteria
    filter_criteria = @criteria[:filter] || ->(_song) { return true }
    @collection.select do |song|
      name_criteria(song) && artist_criteria(song) &&
        filter_criteria.call(song) && tags_criteria(song)
    end
  end

  def artist_criteria(song)
    !@criteria[:artist] || song.artist == @criteria[:artist]
  end

  def name_criteria(song)
    !@criteria[:name] || song.name == @criteria[:name]
  end

  def tags_criteria(song)
    Array(@criteria[:tags]).each do |tag|
      return false if tag.end_with?('!') && song.tags.include?(tag.chop)
      return false if !tag.end_with?('!') && !song.tags.include?(tag)
    end
    true
  end
end
