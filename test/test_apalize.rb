require "test_helper"

class TestApalize < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Apalize::VERSION
  end

  def test_apa_examples
    assert_equal "Train Your Mind for Peak Performance: A Science-Based Approach for Achieving Your Goals",
      "train your mind for peak performance: a science-based approach for achieving your goals".apalize
    assert_equal "Turning Frowns (And Smiles) Upside Down: A Multilevel Examination of Surface Acting Positive and Negative Emotions on Well-Being",
      "turning frowns (and smiles) upside down: a multilevel examination of surface acting positive and negative emotions on well-being".apalize
  end

  def test_basic_title_case
    assert_equal "Over the Rainbow", "over the rainbow".apalize
    assert_equal "The Quick Brown Fox", "the quick brown fox".apalize
    assert_equal "A Simple Test", "a simple test".apalize
  end

  def test_first_and_last_words_capitalized
    assert_equal "The End of the World", "the end of the world".apalize
    assert_equal "A Study of Literature", "a study of literature".apalize
  end

  def test_minor_words_lowercase_in_middle
    assert_equal "The Art of War", "the art of war".apalize
    assert_equal "Gone With the Wind", "gone with the wind".apalize
    assert_equal "Love and Death", "love and death".apalize
  end

  def test_long_words_capitalized
    assert_equal "The Beautiful Mind", "the beautiful mind".apalize
    assert_equal "Understanding Psychology", "understanding psychology".apalize
  end

  def test_short_words_four_chars_or_more
    assert_equal "They Knew What They Wanted", "they knew what they wanted".apalize
    assert_equal "What Love Means", "what love means".apalize
  end

  def test_prepositions_and_conjunctions
    assert_equal "The Man With the Golden Gun", "the man with the golden gun".apalize
    assert_equal "Love in the Time of Cholera", "love in the time of cholera".apalize
    assert_equal "War and Peace", "war and peace".apalize
  end

  def test_articles_and_determiners
    assert_equal "The Great Gatsby", "the great gatsby".apalize
    assert_equal "An Honest Man", "an honest man".apalize
    assert_equal "A Tale of Two Cities", "a tale of two cities".apalize
  end

  def test_multiple_spaces_handled
    assert_equal "The  Quick   Brown    Fox", "the  quick   brown    fox".apalize
    assert_equal "Test  With  Multiple  Spaces", "test  with  multiple  spaces".apalize
  end

  def test_preserves_original_punctuation
    assert_equal "The Quick, Brown Fox!", "the quick, brown fox!".apalize
    assert_equal "Hello, World: A Story", "hello, world: a story".apalize
  end

  def test_empty_and_whitespace_strings
    assert_equal "", "".apalize
    assert_equal "", "   ".apalize
    assert_equal "Test", "  test  ".apalize
  end

  def test_contractions_and_apostrophes
    assert_equal "I'm the Man Who Loves You", "i'm the man who loves you".apalize
    assert_equal "I'll Be Seeing You", "i'll be seeing you".apalize
  end

  def test_foreign_phrases
    assert_equal "Pas de Deux", "pas de deux".apalize
  end

  def test_possessive_forms
    assert_equal "Beggar's Blanket", "beggar's blanket".apalize
    assert_equal "World's Fair", "world's fair".apalize
    assert_equal "Children's Book", "children's book".apalize
    assert_equal "James's House", "james's house".apalize
  end

  def test_punctuation_capitalization
    assert_equal "Title: The Subtitle", "title: the subtitle".apalize
    assert_equal "Title—The Subtitle", "title—the subtitle".apalize
    assert_equal "Title. The Next Part", "title. the next part".apalize
    assert_equal "Title! The Exclamation", "title! the exclamation".apalize
    assert_equal "Title? The Question", "title? the question".apalize
  end

  def test_multiple_punctuation_capitalization
    assert_equal "First: Second. Third! Fourth? The End", "first: second. third! fourth? the end".apalize
    assert_equal "Part One: The Beginning—The Story. What Happens? The Conclusion", "part one: the beginning—the story. what happens? the conclusion".apalize
  end

  def test_basic_hyphenated_words
    assert_equal "Mother-In-Law", "mother-in-law".apalize
    assert_equal "Twenty-One", "twenty-one".apalize
    assert_equal "Self-Esteem", "self-esteem".apalize
  end

  def test_hyphenated_prefixes
    assert_equal "Anti-war Movement", "anti-war movement".apalize
    assert_equal "Co-author of the Book", "co-author of the book".apalize
    assert_equal "Ex-president Obama", "ex-president obama".apalize
    assert_equal "Non-fiction Literature", "non-fiction literature".apalize
    assert_equal "Pre-war Economy", "pre-war economy".apalize
    assert_equal "Pro-life Activists", "pro-life activists".apalize
    assert_equal "Re-Examine the Evidence", "re-examine the evidence".apalize
    assert_equal "Sub-Committee Meeting", "sub-committee meeting".apalize
    assert_equal "Super-Human Strength", "super-human strength".apalize
    assert_equal "Trans-Atlantic Flight", "trans-atlantic flight".apalize
    assert_equal "Ultra-Modern Design", "ultra-modern design".apalize
  end

  def test_mid_and_semi_prefixes
    assert_equal "Mid-Century Modern", "mid-century modern".apalize
    assert_equal "Semi-automatic Weapon", "semi-automatic weapon".apalize
    assert_equal "Multi-cultural Society", "multi-cultural society".apalize
    assert_equal "Inter-personal Skills", "inter-personal skills".apalize
    assert_equal "Intra-company Transfer", "intra-company transfer".apalize
    assert_equal "Over-the-counter Medicine", "over-the-counter medicine".apalize
    assert_equal "Under-the-table Payment", "under-the-table payment".apalize
  end

  def test_hyphenated_words_first_position
    assert_equal "Well-Known Author", "well-known author".apalize
    assert_equal "Long-Term Investment", "long-term investment".apalize
  end

  def test_hyphenated_words_last_position
    assert_equal "Something Well-Done", "something well-done".apalize
    assert_equal "Results That Are Long-Term", "results that are long-term".apalize
  end

  def test_hyphenated_words_with_minor_words
    assert_equal "Up-To-Date Information", "up-to-date information".apalize
    assert_equal "State-Of-The-Art Technology", "state-of-the-art technology".apalize
    assert_equal "Day-To-Day Operations", "day-to-day operations".apalize
  end

  def test_hyphenated_with_punctuation
    assert_equal "Well-Respected, Long-Term Employee", "well-respected, long-term employee".apalize
    assert_equal "High-Quality: Top-Notch Service", "high-quality: top-notch service".apalize
  end

  def test_multiple_hyphens
    assert_equal "State-Of-The-Art-System", "state-of-the-art-system".apalize
    assert_equal "Up-To-The-Minute News", "up-to-the-minute news".apalize
  end
end
