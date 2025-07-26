# Apacify

A Ruby gem that converts strings to proper title case following APA (American Psychological Association) style guidelines. Apacify capitalizes strings while keeping minor words (articles, prepositions, conjunctions) lowercase, except when they appear at the beginning or end of the title, or after sentence-ending punctuation.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add apacify
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install apacify
```

## Usage

```ruby
require "apacify"

"train your mind for peak performance: a science-based approach for achieving your goals".apacify
# => "Train Your Mind for Peak Performance: A Science-Based Approach for Achieving Your Goals"
```

Minor words stay lowercase (unless at beginning/end):

```ruby
"the art of war".apacify
# => "The Art of War"
```

Words after punctuation are capitalized:

```ruby
"title: the subtitle".apacify
# => "Title: The Subtitle"
```

Hyphenated words are handled properly:

```ruby
"mother-in-law".apacify
# => "Mother-In-Law"
```

### Features

- Follows APA style title case rules
- Capitalizes first and last words regardless of length
- Keeps minor words lowercase in the middle
- Capitalizes words after sentence-ending punctuation
- Handles hyphenated words correctly
- Preserves original spacing and punctuation
- Words 4 letters or longer are always capitalized

## Comparison with Rails' `#titleize`

| Input              | Rails' `titleize`  | Apacify            |
|--------------------|--------------------|--------------------|
| `"the art of war"` | `"The Art Of War"` | `"The Art of War"` |
| `"love and death"` | `"Love And Death"` | `"Love and Death"` |
| `"mother-in-law"`  | `"Mother In Law"`  | `"Mother-In-Law"`  |

Rails' `titleize` capitalizes every word, while Apacify follows proper APA title case rules by keeping minor words lowercase and preserving hyphens.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/arzezak/apacify. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/arzezak/apacify/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Apacify project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/arzezak/apacify/blob/main/CODE_OF_CONDUCT.md).
