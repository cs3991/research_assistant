# Research Assistant

[![License: MIT][license_badge]][license_link]

An application to find and organize research papers

## Running the application

Use a recent stable Flutter SDK with Dart 3.9 or later. Verified with Flutter
3.47.7 / Dart 3.13.5 (also pinned in CI).

```sh
flutter pub get
flutter run -d chrome --target lib/main_development.dart
```

OpenAlex accepts requests without a key, with a smaller daily allowance shared
by IP address. For regular use, get a free personal key from
[OpenAlex settings](https://openalex.org/settings/api) and pass it at build time:

```sh
flutter run -d chrome --target lib/main_development.dart --dart-define=OPENALEX_API_KEY=YOUR_KEY
```

The client sends the key in the `Authorization: Bearer` header. A key bundled
in a frontend is visible to its users; use a backend if a shared key must stay
private. Do not commit a personal key.

## OpenAlex integration

The client in `packages/open_alex_api` uses the current `sources` endpoint,
`per_page` parameter, and Topics classification. It reads `funders` and `awards`,
plural author affiliations, nullable locations and institution identifiers,
and current source statistics/APC structures. Legacy work responses still
decode. `getVenue` remains an alias for `getSource`; callers should supply an
`S...` source ID rather than an obsolete `V...` venue ID.

Search pages start at 1, with 1–100 results per page and the API's 10,000-result
limit. Requests time out after 30 seconds and retry HTTP 429/5xx up to twice.

See the [OpenAlex quick reference](https://help.openalex.org/api/llm-quick-reference/)
and [migration notes](https://help.openalex.org/api/deprecations/).

## Verification

```sh
flutter test
cd packages/open_alex_api
flutter pub get
dart run build_runner build
flutter test
```

Unit tests use recorded API responses from November 12, 2026, and the original
legacy work fixture. No API key or live network access is needed for these tests.
For an optional live check, run from the project root:

```sh
dart run tool/openalex_smoke.dart
```

This checks search, pagination, detail loading, and conversion to the app's
publication model. It also accepts an `OPENALEX_API_KEY` environment variable.

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg

[license_link]: https://opensource.org/licenses/MIT
