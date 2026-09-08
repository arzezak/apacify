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

Entry point: `lib/apacify.rb` — defines `Apacify.titleize`, patches `String#apacify`.

Pipeline: **input string → Titleizer splits on separators → Word capitalizes each word → output string**

- `Titleizer` strips the input, splits it into words and separators (whitespace + `PUNCTUATION`), tracks whether the next word starts a clause, and applies the `ignore:` list
- `Word` owns the word-level rules: `MINOR`, hyphenated `PREFIXES`, Roman numerals, all-caps preservation

## APA Title Case Rules

1. Always capitalize first word and words after sentence-ending punctuation (`:`, `.`, `!`, `?`, `—`)
2. Capitalize all major words (4+ letters always qualify)
3. Minor words (≤3 letters, listed in `Word::MINOR`) stay lowercase unless rule 1 applies
4. Hyphenated parts each get capitalized independently; parts after a known prefix stay lowercase unless already capitalized (Mid-century, Pre-Christian)
5. `ignore:` parameter preserves original case (case-sensitive matching, punctuation in the ignore word is stripped)
