# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Apacify is a Ruby gem that converts strings to APA-style title case. It extends `String` with `.apacify(ignore: [])`.

## Commands

```bash
rake              # Run tests + linter (default)
rake test         # Tests only (minitest)
rake standard     # Lint only (Standard/RuboCop)
ruby -Ilib test/test_apacify.rb                          # Run test file directly
ruby -Ilib test/test_apacify.rb -n test_method_name      # Single test
bin/console       # IRB with gem loaded
```

## Architecture

Entry point: `lib/apacify.rb` — loads `config/minor.yml`, defines `Apacify.titleize`, patches `String#apacify`.

Pipeline: **input string → Tokenizer → Token[] → Titleizer → output string**

- `Tokenizer` splits on word boundaries (spaces + punctuation), implements `Enumerable`
- `Token` represents a single unit; knows if it's a minor word, punctuation, first/last, Roman numeral, hyphenated
- `Titleizer` walks tokens and applies capitalization rules via `should_capitalize?`

## APA Title Case Rules

1. Always capitalize first word and words after sentence-ending punctuation (`:`, `.`, `!`, `?`, `—`)
2. Capitalize all major words (4+ letters always qualify)
3. Minor words (≤3 letters, listed in `config/minor.yml`) stay lowercase unless rule 1 applies
4. Hyphenated parts each get capitalized independently
5. `ignore:` parameter preserves original case (case-sensitive matching)
