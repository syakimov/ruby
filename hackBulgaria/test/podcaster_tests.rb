require 'minitest/autorun'

require_relative 'podcaster'

class SolutionTest < Minitest::Test
  def test_podcasts_have_names
    assert Podcast.new('The BikeShed')
  end

  def test_that_we_can_have_episodes
    episode = Episode.new('Sandi', '5 Rules', 40)
    assert_equal 'Sandi', episode.name
    assert_equal '5 Rules', episode.description

    assert_equal 40, episode.minutes
  end

  def test_that_we_can_add_episodes
    podcast = Podcast.new('The BikeShed')

    episode = Episode.new('Sandi', '5 Rules', 40)

    assert (podcast << episode)
  end

  def test_that_episodes_get_ids_after_adding_them_to_a_podcast
    podcast = Podcast.new('The BikeShed')

    rules = Episode.new('Sandi', '5 Rules', 40)

    haskell = Episode.new('Haskell', 'A quick talk about haskell', 30)

    assert !rules.id
    assert !haskell.id

    podcast << rules
    podcast << haskell

    assert_equal 1, rules.id
    assert_equal 2, haskell.id
  end

  def test_that_we_can_find_episodes
    cortex = Podcast.new('Cortex')

    episode1 = Episode.new('Productivity', 'The first episode of Cortex, where we talk about being self-employed.', 80)
    episode2 = Episode.new('TodoLists', 'Managing your day by todos', 68)
    episdoe3 = Episode.new('Schedule', 'We will talk about how to schedule your day', 73)

    cortex << episode1
    cortex << episode2
    cortex << episdoe3

    assert_array_match [episode1], cortex.find(name: 'productivity')
    assert_array_match [episode1, episode2], cortex.find(name: 'od')
    assert_array_match [episode2, episdoe3], cortex.find(description: ['your', 'day'])
    assert_array_match [episdoe3], cortex.find(description: ['We', 'will', 'talk'])
  end

  def test_that_we_can_check_podcast_info
    cortex = Podcast.new('Cortex')
    ep1 = Episode.new('Productivity', 'The first episode of Cortex, where we talk about being self-employed.', 80)
    ep2 = Episode.new('TodoLists', 'Managing your day by todos.', 68)
    ep3 = Episode.new('Calendars', 'Using calendars', 0)
    episodes = [ep1, ep2, ep3]

    episodes.each { |ep| cortex << ep }

    info = cortex.info.lines.map(&:chomp) #=>

    assert info.include?("Podcast: Cortex")
    assert info.include?("Total episodes: 3")
    assert info.include?("Total duration: 148")
    assert_equal 3, info.count('=' * 10)
    episodes.each do |episode|
      assert info.include? "Name: #{episode.name}"
      assert info.include? episode.description
      assert info.include? "Duration: #{episode.minutes} minutes"
    end
  end

  private

  def assert_array_match(expected, actual, msg = nil)
    assert same_elements?(expected, actual),
           msg || "Actual array: #{actual.inspect} does not match expected: #{expected.inspect}."
  end

  def same_elements?(expected, actual)
    missing = expected - actual
    extra =  actual - expected
    missing.empty? && extra.empty?
  end
end
