# OpenAlex metadata contract

Audited 2026-11-12 for the application’s search and publication detail paths.

Reference dictionaries:
- https://help.openalex.org/data/works/attributes/
- https://help.openalex.org/data/authorships/
- https://help.openalex.org/data/locations/
- https://help.openalex.org/data/authors/

These dictionaries explicitly document several nulls (title, primary topic,
OA location, ORCID), but do not give an exhaustive non-null guarantee for every
nested field. For example, the recorded TMR response contains null author IDs.
We therefore accept missing/null metadata at the application boundary even
where the documentation lists only a scalar type. This is a compatibility
policy, not a claim that every such null is documented by OpenAlex.

## Fields actually decoded

`CatalogRepository.workFromJson` reads the same subset for search and detail.
All these fields and their parents may be absent or null:

| JSON field | Application behavior |
| --- | --- |
| `title`, `display_name` | First nonblank title/name, otherwise “Sans titre” |
| `authorships` | Empty list when absent; null entries skipped |
| `authorships[].author.display_name` | Raw author name, then “Auteur inconnu” |
| `authorships[].raw_author_name` | Optional fallback only |
| `primary_location.source.display_name` | Empty source label |
| `publication_date` | Nullable date; invalid date string stays unknown |
| `publication_year` | Nullable year; “Année inconnue” in search |
| `cited_by_count` | Nullable count; unknown is distinct from zero |
| `open_access.is_oa` | Nullable boolean; unknown is distinct from closed access |
| `ids.doi`, `doi` | Optional HTTP(S) DOI URL; bare DOIs get the DOI prefix |
| `best_oa_location.pdf_url`, `.landing_page_url`, `open_access.oa_url` | First valid HTTP(S) URL, otherwise null |
| `topics[].display_name`, `concepts[].display_name` | Known names only; legacy concepts used when topic names are empty |
| `counts_by_year[].cited_by_count` | Known counts only, including real zero; unknown entries are not replaced with zero |
| `abstract_inverted_index` | Empty abstract when absent; null position lists/elements and negative positions skipped |

No default date, year, count or boolean is invented. Empty lists mean no usable
entries, not proof that the external dataset is complete.

## Unused fields and full API models

The app uses `getWorkData`/`searchWorksData`, which retain the HTTP client’s
pagination checks, retries, authentication and error handling. They decode JSON
objects but do not instantiate the full nested OpenAlex models. Unused metadata
(e.g. author IDs, affiliations, source classifications, APCs, funding) cannot
fail the app’s metadata conversion. Used fields with incorrect types still raise
an error; malformed response envelopes are not converted into empty results.

The package’s existing `getWork`/`searchWorks` methods and full entity models
remain available and retain their existing, stricter contracts. They are not
used by the application’s search/detail paths. Future features using additional
fields must extend this table, mapper and tests before relying on those fields.

## Regression tests

`test/catalog_repository/nullability_test.dart` covers a metadata-poor record
through search and detail, raw-name fallbacks, unused metadata with changed
types, and the distinction between unknown values and known zero/false. It uses
representative null/missing fields rather than mutating every field in every
fixture. The recorded 25-result TMR response remains a separate regression.

Widget tests verify unknown values in publication details and zero-count graph
layout. Package tests verify raw transport responses and API compatibility.
All these tests run offline; additional article searches are not required.
