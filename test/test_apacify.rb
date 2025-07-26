require "test_helper"

class TestApacify < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Apacify::VERSION
  end

  def test_apa_examples
    assert_equal "Train Your Mind for Peak Performance: A Science-Based Approach for Achieving Your Goals",
      "train your mind for peak performance: a science-based approach for achieving your goals".apacify
    assert_equal "Turning Frowns (And Smiles) Upside Down: A Multilevel Examination of Surface Acting Positive and Negative Emotions on Well-Being",
      "turning frowns (and smiles) upside down: a multilevel examination of surface acting positive and negative emotions on well-being".apacify
  end

  def test_basic_title_case
    assert_equal "Over the Rainbow", "over the rainbow".apacify
    assert_equal "The Quick Brown Fox", "the quick brown fox".apacify
    assert_equal "A Simple Test", "a simple test".apacify
  end

  def test_first_and_last_words_capitalized
    assert_equal "The End of the World", "the end of the world".apacify
    assert_equal "A Study of Literature", "a study of literature".apacify
  end

  def test_minor_words_lowercase_in_middle
    assert_equal "The Art of War", "the art of war".apacify
    assert_equal "Gone With the Wind", "gone with the wind".apacify
    assert_equal "Love and Death", "love and death".apacify
  end

  def test_long_words_capitalized
    assert_equal "The Beautiful Mind", "the beautiful mind".apacify
    assert_equal "Understanding Psychology", "understanding psychology".apacify
  end

  def test_short_words_four_chars_or_more
    assert_equal "They Knew What They Wanted", "they knew what they wanted".apacify
    assert_equal "What Love Means", "what love means".apacify
  end

  def test_prepositions_and_conjunctions
    assert_equal "The Man With the Golden Gun", "the man with the golden gun".apacify
    assert_equal "Love in the Time of Cholera", "love in the time of cholera".apacify
    assert_equal "War and Peace", "war and peace".apacify
  end

  def test_articles_and_determiners
    assert_equal "The Great Gatsby", "the great gatsby".apacify
    assert_equal "An Honest Man", "an honest man".apacify
    assert_equal "A Tale of Two Cities", "a tale of two cities".apacify
  end

  def test_multiple_spaces_handled
    assert_equal "The  Quick   Brown    Fox", "the  quick   brown    fox".apacify
    assert_equal "Test  With  Multiple  Spaces", "test  with  multiple  spaces".apacify
  end

  def test_preserves_original_punctuation
    assert_equal "The Quick, Brown Fox!", "the quick, brown fox!".apacify
    assert_equal "Hello, World: A Story", "hello, world: a story".apacify
  end

  def test_empty_and_whitespace_strings
    assert_equal "", "".apacify
    assert_equal "", "   ".apacify
    assert_equal "Test", "  test  ".apacify
  end

  def test_contractions_and_apostrophes
    assert_equal "I'm the Man Who Loves You", "i'm the man who loves you".apacify
    assert_equal "I'll Be Seeing You", "i'll be seeing you".apacify
  end

  def test_foreign_phrases
    assert_equal "Pas de Deux", "pas de deux".apacify
  end

  def test_possessive_forms
    assert_equal "Beggar's Blanket", "beggar's blanket".apacify
    assert_equal "World's Fair", "world's fair".apacify
    assert_equal "Children's Book", "children's book".apacify
    assert_equal "James's House", "james's house".apacify
  end

  def test_punctuation_capitalization
    assert_equal "Title: The Subtitle", "title: the subtitle".apacify
    assert_equal "Title—The Subtitle", "title—the subtitle".apacify
    assert_equal "Title. The Next Part", "title. the next part".apacify
    assert_equal "Title! The Exclamation", "title! the exclamation".apacify
    assert_equal "Title? The Question", "title? the question".apacify
  end

  def test_multiple_punctuation_capitalization
    assert_equal "First: Second. Third! Fourth? The End", "first: second. third! fourth? the end".apacify
    assert_equal "Part One: The Beginning—The Story. What Happens? The Conclusion", "part one: the beginning—the story. what happens? the conclusion".apacify
  end

  def test_basic_hyphenated_words
    assert_equal "Mother-In-Law", "mother-in-law".apacify
    assert_equal "Twenty-One", "twenty-one".apacify
    assert_equal "Self-Esteem", "self-esteem".apacify
  end

  def skip_test_hyphenated_prefixes
    assert_equal "Anti-war Movement", "anti-war movement".apacify
    assert_equal "Co-author of the Book", "co-author of the book".apacify
    assert_equal "Ex-president Obama", "ex-president obama".apacify
    assert_equal "Non-fiction Literature", "non-fiction literature".apacify
    assert_equal "Pre-war Economy", "pre-war economy".apacify
    assert_equal "Pro-life Activists", "pro-life activists".apacify
    assert_equal "Re-Examine the Evidence", "re-examine the evidence".apacify
    assert_equal "Sub-Committee Meeting", "sub-committee meeting".apacify
    assert_equal "Super-Human Strength", "super-human strength".apacify
    assert_equal "Trans-Atlantic Flight", "trans-atlantic flight".apacify
    assert_equal "Ultra-Modern Design", "ultra-modern design".apacify
  end

  def skip_test_mid_and_semi_prefixes
    assert_equal "Mid-Century Modern", "mid-century modern".apacify
    assert_equal "Semi-automatic Weapon", "semi-automatic weapon".apacify
    assert_equal "Multi-cultural Society", "multi-cultural society".apacify
    assert_equal "Inter-personal Skills", "inter-personal skills".apacify
    assert_equal "Intra-company Transfer", "intra-company transfer".apacify
    assert_equal "Over-the-counter Medicine", "over-the-counter medicine".apacify
    assert_equal "Under-the-table Payment", "under-the-table payment".apacify
  end

  def test_hyphenated_words_first_position
    assert_equal "Well-Known Author", "well-known author".apacify
    assert_equal "Long-Term Investment", "long-term investment".apacify
  end

  def test_hyphenated_words_last_position
    assert_equal "Something Well-Done", "something well-done".apacify
    assert_equal "Results That Are Long-Term", "results that are long-term".apacify
  end

  def test_hyphenated_words_with_minor_words
    assert_equal "Up-To-Date Information", "up-to-date information".apacify
    assert_equal "State-Of-The-Art Technology", "state-of-the-art technology".apacify
    assert_equal "Day-To-Day Operations", "day-to-day operations".apacify
  end

  def test_hyphenated_with_punctuation
    assert_equal "Well-Respected, Long-Term Employee", "well-respected, long-term employee".apacify
    assert_equal "High-Quality: Top-Notch Service", "high-quality: top-notch service".apacify
  end

  def test_multiple_hyphens
    assert_equal "State-Of-The-Art-System", "state-of-the-art-system".apacify
    assert_equal "Up-To-The-Minute News", "up-to-the-minute news".apacify
  end
end
