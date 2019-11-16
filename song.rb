# frozen_string_literal: true

# Class Song
# Holds all info for a single song
class Song
  @@plays = 0

  include Comparable

  def initialize(name, artist, duration)
    @name = name
    @artist = artist
    @duration = duration
    @plays = 0
  end

  def <=>(other)
    duration <=> other.duration
  end

  def play
    @plays += 1
    @@plays += 1
    "The song #{@name}: #{@plays} plays. Total #{@@plays} plays."
  end

  attr_reader :name, :artist, :duration
  attr_writer :duration

  # def duration=(new_duration)
  # @duration = new_duration
  # end
end

# Add the to_s functionality for displaying info about a Song
class Song
  def to_s
    "Song: #{@name}--#{@artist}(#{@duration})"
  end
end

# A KaraokeSong - Simply a Song with lyrics
class KaraokeSong < Song
  def initialize(name, artist, duration, lyrics)
    super(name, artist, duration)
    @lyrics = lyrics
  end

  attr_reader :lyrics

  def to_s
    super + " [#{@lyrics}]"
  end
end

# SongList - A collection of songs
class SongList
  def initialize
    @songs = []
  end

  def append(song)
    @songs.push(song)
    self
  end

  def delete_first
    @songs.shift
  end

  def delete_last
    @songs.pop
  end

  def [](index)
    @songs[index]
  end

  def with_title(title)
    @songs.find { |song| title == song.name }
  end
end

require 'test/unit'

# TestSongList - a testcase for SongList
class TestSongList < Test::Unit::TestCase
  def _setup
    @list = SongList.new

    @s1 = Song.new('title1', 'artist1', 1)
    @s2 = Song.new('title2', 'artist2', 2)
    @s3 = Song.new('title3', 'artist3', 3)
    @s4 = Song.new('title4', 'artist4', 4)

    @list.append(@s1).append(@s2).append(@s3).append(@s4)
  end

  def test_delete
    _setup
    assert_equal(@s1, @list[0])
    assert_equal(@s3, @list[2])
    assert_nil(@list[9])
    assert_equal(@s1, @list.delete_first)
    assert_equal(@s2, @list.delete_first)
    assert_equal(@s4, @list.delete_last)
    assert_equal(@s3, @list.delete_last)
    assert_nil(@list.delete_last)
  end

  def test_compare
    _setup
    assert_equal(@s1 <=> @s2, -1)
    assert(@s1 < @s2)
    assert(@s2 > @s1)
    assert(@s1 == @s1)
    assert(@s1 <= @s2)
  end
end
