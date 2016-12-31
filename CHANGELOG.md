# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## 0.1.1 - 2016-12-31
### Added
- Add `pretty_length`, `pretty_valid` and `pretty_eta` methods.
- Add `peers`, `peers_seeding` and `peers_leeching` methods.
- Add better documentation and comments.
- Add some specs for extensions.

### Changed
- Minimum ruby version is now `2.0`.
- Refactor `is_multi?` to `multi?` for best practice compliance.
- Refactor `is_valid_key?` to  for best practice compliance

### Removed
- Remove `finished?` method (overridden in extensions)

## 0.1.0 - 2016-12-28
- Initial fork and basic additions.
