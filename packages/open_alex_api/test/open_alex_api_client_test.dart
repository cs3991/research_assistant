import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:open_alex_api/open_alex_api.dart';
import 'package:test/test.dart';

import 'models/json_response.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('OpenAlexApiClient', () {
    late http.Client httpClient;
    late OpenAlexApiClient metaWorkApiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      metaWorkApiClient = OpenAlexApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(OpenAlexApiClient(), isNotNull);
      });
    });

    group('getWork', () {
      const workId = 'https://openalex.org/W2741809807';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await metaWorkApiClient.getWork(workId);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https(
              'api.openalex.org',
              'works/$workId',
            ),
          ),
        ).called(1);
      });

      test('throws WorkRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await metaWorkApiClient.getWork(workId),
          throwsA(isA<WorkRequestFailure>()),
        );
      });

      test('throws WorkNotFoundFailure on 404 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await metaWorkApiClient.getWork(workId),
          throwsA(isA<WorkNotFoundFailure>()),
        );
      });

      test('returns work on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(workJsonResponse);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await metaWorkApiClient.getWork(workId);
        expect(
          actual,
          isA<Work>()
              .having(
                (work) => work.id,
                'openAlexId',
                'https://openalex.org/W2741809807',
              )
              .having(
                (work) => work.title,
                'title',
                'éThe state of OA: a large-scale analysis of the prevalence and impact of Open Access articles',
              )
              .having(
                (work) => work.displayName,
                'displayName',
                'The state of OA: a large-scale analysis of the prevalence and impact of Open Access articles',
              )
              .having(
                (work) => work.publicationDate,
                'publicationDate',
                DateTime(2018, 2, 13),
              )
              .having(
                (work) => work.publicationYear,
                'publicationYear',
                2018,
              )
              .having(
                (work) => work.type,
                'type',
                WorkType.journalArticle,
              )
              .having(
                (work) => work.isOpenAccess,
                'isOpenAccess',
                true,
              )
              .having(
                (work) => work.openAccessStatus,
                'openAccessStatus',
                OpenAccessStatus.gold,
              )
              .having(
                (work) => work.openAccessUrl,
                'openAccessUrl',
                'https://peerj.com/articles/4375.pdf',
              )
              .having(
                (work) => work.citedByCount,
                'citedByCount',
                394,
              )
              .having(
                (work) => work.isRetracted,
                'isRetracted',
                false,
              )
              .having(
                (work) => work.isParatext,
                'isParatext',
                false,
              )
              .having(
                (work) => work.citedByApiUrl,
                'citedByApiUrl',
                'https://api.openalex.org/works?filter=cites:W2741809807',
              )
              .having(
                (work) => work.countsByYear,
                'citedByCountsByYear',
                [
                  isA<YearWork>()
                      .having((year) => year.year, 'year', 2022)
                      .having((year) => year.citedByCount, 'citedByCount', 13),
                  isA<YearWork>()
                      .having((year) => year.year, 'year', 2021)
                      .having((year) => year.citedByCount, 'citedByCount', 108),
                ],
              )
              .having(
                (work) => work.updatedDate,
                'updatedDate',
                DateTime(2022, 5, 27),
              )
              .having(
                (work) => work.createdDate,
                'createdDate',
                DateTime(2017, 8, 8),
              ),
        );
      });
    });
    group('getAuthor', () {
      const authorId = 'https://openalex.org/A1969205032';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await metaWorkApiClient.getAuthor(authorId);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https(
              'api.openalex.org',
              'authors/$authorId',
            ),
          ),
        ).called(1);
      });

      test('throws AuthorRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await metaWorkApiClient.getAuthor(authorId),
          throwsA(isA<AuthorRequestFailure>()),
        );
      });

      test('throws AuthorNotFoundFailure on 404 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await metaWorkApiClient.getAuthor(authorId),
          throwsA(isA<AuthorNotFoundFailure>()),
        );
      });

      test('returns author on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(authorJsonResponse);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await metaWorkApiClient.getAuthor(authorId);
        expect(
          actual,
          isA<Author>()
              .having(
                (author) => author.id,
                'openAlexId',
                'https://openalex.org/A1969205032',
              )
              .having(
                (author) => author.orcidId,
                'orcid',
                'https://orcid.org/0000-0003-1613-5981',
              )
              .having(
                (author) => author.displayName,
                'displayName',
                'Heather A. Piwowar',
              )
              .having(
                (author) => author.displayNameAlternatives,
                'displayNameAlternatives',
                [],
              )
              .having(
                (author) => author.worksCount,
                'worksCount',
                50,
              )
              .having(
                (author) => author.citedByCount,
                'citedByCount',
                2691,
              )
              .having(
                (author) => author.magId,
                'mag',
                '1969205032',
              )
              .having(
                (author) => author.twitterId,
                'twitter',
                'http://twitter.com/researchremix',
              )
              .having(
                (author) => author.scopusId,
                'scopus',
                'http://www.scopus.com/inward/authorDetails.url?authorID=25122628200&partnerID=MN8TOARS',
              )
              .having(
                (author) => author.worksApiUrl,
                'worksApiUrl',
                'https://api.openalex.org/works?filter=author.id:A1969205032',
              )
              .having(
                (author) => author.updatedDate,
                'updatedDate',
                DateTime(2022, 03, 09),
              )
              .having(
                (author) => author.createdDate,
                'createdDate',
                DateTime(2016, 06, 24),
              )
              .having((author) => author.countsByYear, 'citedByCountsByYear', [
                isA<YearAuthor>()
                    .having((year) => year.year, 'year', 2022)
                    .having((year) => year.worksCount, 'worksCount', 0)
                    .having((year) => year.citedByCount, 'citedByCount', 52),
                isA<YearAuthor>()
                    .having((year) => year.year, 'year', 2021)
                    .having((year) => year.worksCount, 'worksCount', 1)
                    .having((year) => year.citedByCount, 'citedByCount', 299),
              ]),
        );
      });
    });
    group('getVenue', () {
      const venueId = 'https://openalex.org/V1983995261';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await metaWorkApiClient.getVenue(venueId);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https(
              'api.openalex.org',
              'venues/$venueId',
            ),
          ),
        ).called(1);
      });

      test('throws VenueRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await metaWorkApiClient.getVenue(venueId),
          throwsA(isA<VenueRequestFailure>()),
        );
      });

      test('throws VenueNotFoundFailure on 404 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await metaWorkApiClient.getVenue(venueId),
          throwsA(isA<VenueNotFoundFailure>()),
        );
      });
      test('returns venue on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(venueJsonResponse);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await metaWorkApiClient.getVenue(venueId);
        expect(
            actual,
            isA<Venue>()
                .having(
                  (venue) => venue.id,
                  'openAlexId',
                  'https://openalex.org/V1983995261',
                )
                .having(
                  (venue) => venue.linkingIssn,
                  'linkingIssn',
                  '2167-8359',
                )
                .having(
                  (venue) => venue.issn,
                  'issn',
                  ['2167-8359'],
                )
                .having(
                  (venue) => venue.displayName,
                  'displayName',
                  'PeerJ',
                )
                .having(
                  (venue) => venue.publisher,
                  'publisher',
                  'PeerJ',
                )
                .having(
                  (venue) => venue.worksCount,
                  'worksCount',
                  21215,
                )
                .having(
                  (venue) => venue.citedByCount,
                  'citedByCount',
                  153850,
                )
                .having(
                  (venue) => venue.isOa,
                  'isOa',
                  true,
                )
                .having(
                  (venue) => venue.isInDoaj,
                  'isInDoaj',
                  true,
                )
                .having(
                  (venue) => venue.homepageUrl,
                  'homepageUrl',
                  'http://www.peerj.com/',
                )
                .having(
                  (venue) => venue.magId,
                  'magId',
                  '1983995261',
                )
                .having(
                  (venue) => venue.worksApiUrl,
                  'worksApiUrl',
                  'https://api.openalex.org/works?filter=host_venue.id:V1983995261',
                )
                .having(
                  (venue) => venue.updatedDate,
                  'updatedDate',
                  DateTime.parse('2022-06-18'),
                )
                .having(
                  (venue) => venue.createdDate,
                  'createdDate',
                  DateTime.parse('2016-06-24'),
                )
                .having(
                  (venue) => venue.countsByYear,
                  'countsByYear',
                  [
                    isA<YearVenue>()
                        .having((yearVenue) => yearVenue.year, 'year', 2022)
                        .having((yearVenue) => yearVenue.worksCount,
                            'worksCount', 883)
                        .having((yearVenue) => yearVenue.citedByCount,
                            'citedByCount', 18439),
                    isA<YearVenue>()
                        .having((yearVenue) => yearVenue.year, 'year', 2021)
                        .having((yearVenue) => yearVenue.worksCount,
                            'worksCount', 4325)
                        .having((yearVenue) => yearVenue.citedByCount,
                            'citedByCount', 46571),
                  ],
                ));
      });
    });
    group('getInstitution', () {
      const institutionId = 'https://openalex.org/I114027177';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await metaWorkApiClient.getInstitution(institutionId);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https(
              'api.openalex.org',
              'institutions/$institutionId',
            ),
          ),
        ).called(1);
      });

      test('throws InstitutionRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await metaWorkApiClient.getInstitution(institutionId),
          throwsA(isA<InstitutionRequestFailure>()),
        );
      });

      test('throws InstitutionNotFoundFailure on 404 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await metaWorkApiClient.getInstitution(institutionId),
          throwsA(isA<InstitutionNotFoundFailure>()),
        );
      });
      test('returns institution on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(institutionJsonResponse);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await metaWorkApiClient.getInstitution(institutionId);

        expect(
            actual,
            isA<Institution>()
                .having(
                  (institution) => institution.id,
                  'openAlexId',
                  'https://openalex.org/I114027177',
                )
                .having(
                  (institution) => institution.ror,
                  'ror',
                  'https://ror.org/0130frc33',
                )
                .having(
                  (institution) => institution.countryCode,
                  'countryCode',
                  'US',
                )
                .having(
                  (institution) => institution.type,
                  'type',
                  InstitutionType.Education,
                )
                .having(
                  (institution) => institution.homepageUrl,
                  'homepageUrl',
                  'http://www.unc.edu/',
                )
                .having(
                  (institution) => institution.imageUrl,
                  'imageUrl',
                  'https://upload.wikimedia.org/wikipedia/en/5/5c/University_of_North_Carolina_at_Chapel_Hill_seal.svg',
                )
                .having(
                  (institution) => institution.imageThumbnailUrl,
                  'imageThumbnailUrl',
                  'https://upload.wikimedia.org/wikipedia/en/thumb/5/5c/University_of_North_Carolina_at_Chapel_Hill_seal.svg/100px-University_of_North_Carolina_at_Chapel_Hill_seal.svg.png',
                )
                .having(
                  (institution) => institution.displayNameAcronyms,
                  'displayNameAcronyms',
                  ['UNC'],
                )
                .having(
                  (institution) => institution.displayNameAlternatives,
                  'displayNameAlternatives',
                  ['UNC-Chapel Hill'],
                )
                .having(
                  (institution) => institution.worksCount,
                  'worksCount',
                  200714,
                )
                .having(
                  (institution) => institution.citedByCount,
                  'citedByCount',
                  20698095,
                )
                .having(
                  (institution) => institution.magId,
                  'magId',
                  '114027177',
                )
                .having(
                  (institution) => institution.gridId,
                  'gridId',
                  'grid.10698.36',
                )
                .having(
                  (institution) => institution.wikipediaId,
                  'wikipediaId',
                  'https://en.wikipedia.org/wiki/University%20of%20North%20Carolina%20at%20Chapel%20Hill',
                )
                .having(
                  (institution) => institution.wikidataId,
                  'wikidataId',
                  'https://www.wikidata.org/wiki/Q192334',
                )
                .having(
                  (institution) => institution.geo,
                  'geo',
                  isA<Geo>()
                      .having(
                        (geo) => geo.city,
                        'city',
                        'Chapel Hill',
                      )
                      .having(
                        (geo) => geo.geonamesCityId,
                        'geonamesCityId',
                        '4460162',
                      )
                      .having(
                        (geo) => geo.region,
                        'region',
                        'North Carolina',
                      )
                      .having(
                        (geo) => geo.countryCode,
                        'countryCode',
                        'US',
                      )
                      .having(
                        (geo) => geo.country,
                        'country',
                        'United States',
                      )
                      .having(
                        (geo) => geo.latitude,
                        'latitude',
                        35.905163,
                      )
                      .having(
                        (geo) => geo.longitude,
                        'longitude',
                        -79.04694,
                      ),
                )
                .having(
                  (institution) => institution.countsByYear,
                  'countsByYear',
                  [
                    isA<YearInstitution>()
                        .having(
                          (countByYear) => countByYear.year,
                          'year',
                          2022,
                        )
                        .having(
                          (countByYear) => countByYear.worksCount,
                          'worksCount',
                          5518,
                        )
                        .having(
                          (countByYear) => countByYear.citedByCount,
                          'citedByCount',
                          771027,
                        ),
                    isA<YearInstitution>()
                        .having(
                          (countByYear) => countByYear.year,
                          'year',
                          2021,
                        )
                        .having(
                          (countByYear) => countByYear.worksCount,
                          'worksCount',
                          12787,
                        )
                        .having(
                          (countByYear) => countByYear.citedByCount,
                          'citedByCount',
                          2119577,
                        ),
                  ],
                )
                .having(
                  (institution) => institution.worksApiUrl,
                  'worksApiUrl',
                  'https://api.openalex.org/works?filter=institutions.id:I114027177',
                )
                .having(
                  (institution) => institution.updatedDate,
                  'updatedDate',
                  DateTime(2022, 06, 18),
                )
                .having(
                  (institution) => institution.createdDate,
                  'createdDate',
                  DateTime(2016, 06, 24),
                ));
      });
    });
  });
}
