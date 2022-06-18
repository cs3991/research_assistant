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
                  isA<YearWork>()
                      .having((year) => year.year, 'year', 2020)
                      .having((year) => year.citedByCount, 'citedByCount', 126),
                  isA<YearWork>()
                      .having((year) => year.year, 'year', 2019)
                      .having((year) => year.citedByCount, 'citedByCount', 97),
                  isA<YearWork>()
                      .having((year) => year.year, 'year', 2018)
                      .having((year) => year.citedByCount, 'citedByCount', 47),
                  isA<YearWork>()
                      .having((year) => year.year, 'year', 2017)
                      .having((year) => year.citedByCount, 'citedByCount', 6),
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
                isA<YearAuthor>()
                    .having((year) => year.year, 'year', 2020)
                    .having((year) => year.worksCount, 'worksCount', 2)
                    .having((year) => year.citedByCount, 'citedByCount', 367),
                isA<YearAuthor>()
                    .having((year) => year.year, 'year', 2019)
                    .having((year) => year.worksCount, 'worksCount', 2)
                    .having((year) => year.citedByCount, 'citedByCount', 291),
                isA<YearAuthor>()
                    .having((year) => year.year, 'year', 2018)
                    .having((year) => year.worksCount, 'worksCount', 3)
                    .having((year) => year.citedByCount, 'citedByCount', 265),
                isA<YearAuthor>()
                    .having((year) => year.year, 'year', 2017)
                    .having((year) => year.worksCount, 'worksCount', 2)
                    .having((year) => year.citedByCount, 'citedByCount', 227),
                isA<YearAuthor>()
                    .having((year) => year.year, 'year', 2016)
                    .having((year) => year.worksCount, 'worksCount', 1)
                    .having((year) => year.citedByCount, 'citedByCount', 230),
                isA<YearAuthor>()
                    .having((year) => year.year, 'year', 2015)
                    .having((year) => year.worksCount, 'worksCount', 0)
                    .having((year) => year.citedByCount, 'citedByCount', 273),
                isA<YearAuthor>()
                    .having((year) => year.year, 'year', 2014)
                    .having((year) => year.worksCount, 'worksCount', 1)
                    .having((year) => year.citedByCount, 'citedByCount', 212),
                isA<YearAuthor>()
                    .having((year) => year.year, 'year', 2013)
                    .having((year) => year.worksCount, 'worksCount', 9)
                    .having((year) => year.citedByCount, 'citedByCount', 223),
                isA<YearAuthor>()
                    .having((year) => year.year, 'year', 2012)
                    .having((year) => year.worksCount, 'worksCount', 2)
                    .having((year) => year.citedByCount, 'citedByCount', 99),
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

      // example of json model of a Venue:
      // {
      //   "id": "https://openalex.org/V1983995261",
      //   "issn_l": "2167-8359",
      //   "issn": ["2167-8359"],
      //   "display_name": "PeerJ",
      //   "publisher": "PeerJ",
      //   "works_count": 21215,
      //   "cited_by_count": 153850,
      //   "is_oa": true,
      //   "is_in_doaj": true,
      //   "homepage_url": "http://www.peerj.com/",
      //   "ids": {
      //     "openalex": "https://openalex.org/V1983995261",
      //     "issn_l": "2167-8359",
      //     "mag": "1983995261",
      //     "issn": ["2167-8359"]
      //   },
      //   "counts_by_year": [
      //     {"year": 2022, "works_count": 883, "cited_by_count": 18439},
      //     {"year": 2021, "works_count": 4325, "cited_by_count": 46571},
      //     {"year": 2020, "works_count": 4364, "cited_by_count": 33225},
      //     {"year": 2019, "works_count": 3857, "cited_by_count": 22303},
      //     {"year": 2018, "works_count": 3081, "cited_by_count": 14254},
      //     {"year": 2017, "works_count": 1497, "cited_by_count": 9754},
      //     {"year": 2016, "works_count": 1522, "cited_by_count": 5424},
      //     {"year": 2015, "works_count": 942, "cited_by_count": 2603},
      //     {"year": 2014, "works_count": 492, "cited_by_count": 1050},
      //     {"year": 2013, "works_count": 238, "cited_by_count": 198},
      //     {"year": 2012, "works_count": 0, "cited_by_count": 9}
      //   ],
      //   "works_api_url": "https://api.openalex.org/works?filter=host_venue.id:V1983995261",
      //   "updated_date": "2022-06-18",
      //   "created_date": "2016-06-24"
      // }

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
                    isA<YearVenue>()
                        .having((yearVenue) => yearVenue.year, 'year', 2020)
                        .having((yearVenue) => yearVenue.worksCount,
                            'worksCount', 4364)
                        .having((yearVenue) => yearVenue.citedByCount,
                            'citedByCount', 33225),
                    isA<YearVenue>()
                        .having((yearVenue) => yearVenue.year, 'year', 2019)
                        .having((yearVenue) => yearVenue.worksCount,
                            'worksCount', 3857)
                        .having((yearVenue) => yearVenue.citedByCount,
                            'citedByCount', 22303),
                    isA<YearVenue>()
                        .having((yearVenue) => yearVenue.year, 'year', 2018)
                        .having((yearVenue) => yearVenue.worksCount,
                            'worksCount', 3081)
                        .having((yearVenue) => yearVenue.citedByCount,
                            'citedByCount', 14254),
                    isA<YearVenue>()
                        .having((yearVenue) => yearVenue.year, 'year', 2017)
                        .having((yearVenue) => yearVenue.worksCount,
                            'worksCount', 1497)
                        .having((yearVenue) => yearVenue.citedByCount,
                            'citedByCount', 9754),
                    isA<YearVenue>()
                        .having((yearVenue) => yearVenue.year, 'year', 2016)
                        .having((yearVenue) => yearVenue.worksCount,
                            'worksCount', 1522)
                        .having((yearVenue) => yearVenue.citedByCount,
                            'citedByCount', 5424),
                    isA<YearVenue>()
                        .having((yearVenue) => yearVenue.year, 'year', 2015)
                        .having((yearVenue) => yearVenue.worksCount,
                            'worksCount', 942)
                        .having((yearVenue) => yearVenue.citedByCount,
                            'citedByCount', 2603),
                    isA<YearVenue>()
                        .having((yearVenue) => yearVenue.year, 'year', 2014)
                        .having((yearVenue) => yearVenue.worksCount,
                            'worksCount', 492)
                        .having((yearVenue) => yearVenue.citedByCount,
                            'citedByCount', 1050),
                    isA<YearVenue>()
                        .having((yearVenue) => yearVenue.year, 'year', 2013)
                        .having((yearVenue) => yearVenue.worksCount,
                            'worksCount', 238)
                        .having((yearVenue) => yearVenue.citedByCount,
                            'citedByCount', 198),
                    isA<YearVenue>()
                        .having((yearVenue) => yearVenue.year, 'year', 2012)
                        .having((yearVenue) => yearVenue.worksCount,
                            'worksCount', 0)
                        .having((yearVenue) => yearVenue.citedByCount,
                            'citedByCount', 9),
                  ],
                ));
      });
    });
  });
}
