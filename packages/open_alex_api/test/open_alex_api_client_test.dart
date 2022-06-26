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

      // example of a valid json response:
      // {
      //   "id": "https://openalex.org/W2741809807",
      //   "doi": "https://doi.org/10.7717/peerj.4375",
      //   "title":
      //       "\u00e9The state of OA: a large-scale analysis of the prevalence and impact of Open Access articles",
      //   "display_name":
      //       "The state of OA: a large-scale analysis of the prevalence and impact of Open Access articles",
      //   "publication_year": 2018,
      //   "publication_date": "2018-02-13",
      //   "ids": {
      //     "openalex": "https://openalex.org/W2741809807",
      //     "doi": "https://doi.org/10.7717/peerj.4375",
      //     "mag": "2741809807",
      //     "pmid": "https://pubmed.ncbi.nlm.nih.gov/29456894",
      //     "pmcid": "https://www.ncbi.nlm.nih.gov/pmc/articles/5815332"
      //   },
      //   "host_venue": {
      //     "id": "https://openalex.org/V1983995261",
      //     "issn_l": "2167-8359",
      //     "issn": ["2167-8359"],
      //     "display_name": "PeerJ",
      //     "publisher": "PeerJ",
      //     "type": "publisher",
      //     "url": "https://doi.org/10.7717/peerj.4375",
      //     "is_oa": true,
      //     "version": "publishedVersion",
      //     "license": "cc-by"
      //   },
      //   "type": "journal-article",
      //   "open_access": {
      //     "is_oa": true,
      //     "oa_status": "gold",
      //     "oa_url": "https://peerj.com/articles/4375.pdf"
      //   },
      //   "authorships": [
      //     {
      //       "author_position": "first",
      //       "author": {
      //         "id": "https://openalex.org/A1969205032",
      //         "display_name": "Heather A. Piwowar",
      //         "orcid": "https://orcid.org/0000-0003-1613-5981"
      //       },
      //       "institutions": [
      //         {
      //           "id": "https://openalex.org/I4200000001",
      //           "display_name": "Our Research",
      //           "ror": "https://ror.org/02nr0ka47",
      //           "country_code": "CA",
      //           "type": "nonprofit"
      //         }
      //       ],
      //       "raw_affiliation_string": "Impactstory, Sanford, NC, USA"
      //     },
      //     {
      //       "author_position": "middle",
      //       "author": {
      //         "id": "https://openalex.org/A2208157607",
      //         "display_name": "Jason Priem",
      //         "orcid": "https://orcid.org/0000-0001-6187-6610"
      //       },
      //       "institutions": [
      //         {
      //           "id": "https://openalex.org/I4200000001",
      //           "display_name": "Our Research",
      //           "ror": "https://ror.org/02nr0ka47",
      //           "country_code": "CA",
      //           "type": "nonprofit"
      //         }
      //       ],
      //       "raw_affiliation_string": "Impactstory, Sanford, NC, USA"
      //     },
      //     {
      //       "author_position": "middle",
      //       "author": {
      //         "id": "https://openalex.org/A291762745",
      //         "display_name": "Vincent Larivi\u00e8re",
      //         "orcid": "https://orcid.org/0000-0002-2733-0689"
      //       },
      //       "institutions": [
      //         {
      //           "id": "https://openalex.org/I70931966",
      //           "display_name": "University of Montreal",
      //           "ror": "https://ror.org/0161xgx34",
      //           "country_code": "CA",
      //           "type": "education"
      //         },
      //         {
      //           "id": "https://openalex.org/I159129438",
      //           "display_name": "University of Quebec at Montreal",
      //           "ror": "https://ror.org/002rjbv21",
      //           "country_code": "CA",
      //           "type": "education"
      //         }
      //       ],
      //       "raw_affiliation_string":
      //           "\u00c9cole de biblioth\u00e9conomie et des sciences de l'information, Universit\u00e9 de Montr\u00e9al, Montr\u00e9al, QC, Canada."
      //     },
      //     {
      //       "author_position": "middle",
      //       "author": {
      //         "id": "https://openalex.org/A2790141563",
      //         "display_name": "Juan Pablo Alperin",
      //         "orcid": "https://orcid.org/0000-0002-9344-7439"
      //       },
      //       "institutions": [
      //         {
      //           "id": "https://openalex.org/I18014758",
      //           "display_name": "Simon Fraser University",
      //           "ror": "https://ror.org/0213rcc28",
      //           "country_code": "CA",
      //           "type": "education"
      //         },
      //         {
      //           "id": "https://openalex.org/I209863525",
      //           "display_name": "Public Knowledge Project",
      //           "ror": null,
      //           "country_code": null,
      //           "type": null
      //         }
      //       ],
      //       "raw_affiliation_string":
      //           "Canadian Institute for Studies in Publishing, Simon Fraser University, Vancouver, BC, Canada."
      //     },
      //     {
      //       "author_position": "middle",
      //       "author": {
      //         "id": "https://openalex.org/A2738039797",
      //         "display_name": "Lisa Matthias",
      //         "orcid": "https://orcid.org/0000-0002-2612-2132"
      //       },
      //       "institutions": [
      //         {
      //           "id": "https://openalex.org/I18014758",
      //           "display_name": "Simon Fraser University",
      //           "ror": "https://ror.org/0213rcc28",
      //           "country_code": "CA",
      //           "type": "education"
      //         }
      //       ],
      //       "raw_affiliation_string":
      //           "Scholarly Communications Lab, Simon Fraser University, Vancouver, Canada."
      //     },
      //     {
      //       "author_position": "middle",
      //       "author": {
      //         "id": "https://openalex.org/A2741312048",
      //         "display_name": "Bree Norlander",
      //         "orcid": "https://orcid.org/0000-0002-0431-4221"
      //       },
      //       "institutions": [
      //         {
      //           "id": "https://openalex.org/I201448701",
      //           "display_name": "University of Washington",
      //           "ror": "https://ror.org/00cvxb145",
      //           "country_code": "US",
      //           "type": "education"
      //         }
      //       ],
      //       "raw_affiliation_string":
      //           "Information School, University of Washington, Seattle, USA"
      //     },
      //     {
      //       "author_position": "middle",
      //       "author": {
      //         "id": "https://openalex.org/A2741153153",
      //         "display_name": "Ashley Farley",
      //         "orcid": null
      //       },
      //       "institutions": [
      //         {
      //           "id": "https://openalex.org/I201448701",
      //           "display_name": "University of Washington",
      //           "ror": "https://ror.org/00cvxb145",
      //           "country_code": "US",
      //           "type": "education"
      //         }
      //       ],
      //       "raw_affiliation_string":
      //           "Information School, University of Washington, Seattle, USA"
      //     },
      //     {
      //       "author_position": "middle",
      //       "author": {
      //         "id": "https://openalex.org/A2162292103",
      //         "display_name": "Jevin D. West",
      //         "orcid": "https://orcid.org/0000-0002-4118-0322"
      //       },
      //       "institutions": [
      //         {
      //           "id": "https://openalex.org/I201448701",
      //           "display_name": "University of Washington",
      //           "ror": "https://ror.org/00cvxb145",
      //           "country_code": "US",
      //           "type": "education"
      //         }
      //       ],
      //       "raw_affiliation_string":
      //           "[Information School, University of Washington, Seattle, USA]"
      //     },
      //     {
      //       "author_position": "last",
      //       "author": {
      //         "id": "https://openalex.org/A2027010983",
      //         "display_name": "Stefanie Haustein",
      //         "orcid": "https://orcid.org/0000-0003-0157-1430"
      //       },
      //       "institutions": [
      //         {
      //           "id": "https://openalex.org/I159129438",
      //           "display_name": "University of Quebec at Montreal",
      //           "ror": "https://ror.org/002rjbv21",
      //           "country_code": "CA",
      //           "type": "education"
      //         },
      //         {
      //           "id": "https://openalex.org/I153718931",
      //           "display_name": "University of Ottawa",
      //           "ror": "https://ror.org/03c4mmv16",
      //           "country_code": "CA",
      //           "type": "education"
      //         }
      //       ],
      //       "raw_affiliation_string":
      //           "Observatoire des Sciences et des Technologies (OST), Centre Interuniversitaire de Recherche sur la Science et la Technologie (CIRST),, Universit\u00e9 du Qu\u00e9bec \u00e0 Montr\u00e9al, Montr\u00e9al, QC, Canada"
      //     }
      //   ],
      //   "cited_by_count": 394,
      //   "biblio": {
      //     "volume": "6",
      //     "issue": null,
      //     "first_page": null,
      //     "last_page": null
      //   },
      //   "is_retracted": false,
      //   "is_paratext": false,
      //   "concepts": [
      //     {
      //       "id": "https://openalex.org/C2778805511",
      //       "wikidata": "https://www.wikidata.org/wiki/Q1713",
      //       "display_name": "Citation",
      //       "level": 2,
      //       "score": "0.4473064"
      //     },
      //     {
      //       "id": "https://openalex.org/C178315738",
      //       "wikidata": "https://www.wikidata.org/wiki/Q603441",
      //       "display_name": "Bibliometrics",
      //       "level": 2,
      //       "score": "0.44480205"
      //     }
      //   ],
      //   "mesh": [],
      //   "alternate_host_venues": [
      //     {
      //       "id": "https://openalex.org/V1983995261",
      //       "display_name": "PeerJ",
      //       "type": "journal",
      //       "url": "https://peerj.com/articles/4375.pdf",
      //       "is_oa": true,
      //       "version": "publishedVersion",
      //       "license": "cc-by"
      //     },
      //     {
      //       "id": null,
      //       "display_name": "Europe PMC",
      //       "type": "repository",
      //       "url": "http://europepmc.org/articles/pmc5815332?pdf=render",
      //       "is_oa": true,
      //       "version": "publishedVersion",
      //       "license": "cc-by"
      //     }
      //   ],
      //   "referenced_works": [
      //     "https://openalex.org/W1560783210",
      //     "https://openalex.org/W1724212071"
      //   ],
      //   "related_works": [
      //     "https://openalex.org/W1655306493",
      //     "https://openalex.org/W1970217003"
      //   ],
      //   "abstract_inverted_index": {
      //     "Despite": [0],
      //     "growing": [1],
      //     "interest": [2],
      //     "in": [3, 57, 73, 110, 122],
      //     "Open": [4, 201],
      //     "Access": [5],
      //     "(OA)": [6],
      //     "to": [7, 54, 252],
      //     "scholarly": [8, 105],
      //     "literature,": [9],
      //     "there": [10],
      //     "is": [11, 107, 116, 176],
      //     "an": [12, 34, 85, 185, 199, 231],
      //     "unmet": [13],
      //     "need": [14, 31],
      //     "for": [15, 42, 174, 219],
      //     "large-scale,": [16],
      //     "up-to-date,": [17],
      //     "and": [18, 24, 77, 112, 124, 144, 221, 237, 256],
      //     "reproducible": [19],
      //     "studies": [20],
      //     "assessing": [21],
      //     "the": [22, 104, 134, 145, 170, 195, 206, 213, 245],
      //     "prevalence": [23],
      //     "characteristics": [25],
      //     "of": [26, 51, 75, 83, 103, 137, 141, 163, 209],
      //     "OA.": [27, 168, 239],
      //     "We": [28, 46, 97, 203, 240],
      //     "address": [29],
      //     "this": [30, 114, 142],
      //     "using": [32, 95, 244],
      //     "oaDOI,": [33],
      //     "open": [35],
      //     "online": [36],
      //     "service": [37],
      //     "that": [38, 89, 99, 113, 147, 155],
      //     "determines": [39],
      //     "OA": [40, 56, 93, 108, 138, 159, 175, 210, 223, 254],
      //     "status": [41],
      //     "67": [43],
      //     "million": [44],
      //     "articles.": [45],
      //     "use": [47],
      //     "three": [48, 58],
      //     "samples,": [49],
      //     "each": [50],
      //     "100,000": [52],
      //     "articles,": [53, 152, 211],
      //     "investigate": [55],
      //     "populations:": [59],
      //     "(1)": [60],
      //     "all": [61],
      //     "journal": [62, 70],
      //     "articles": [63, 71, 79, 94, 164, 191, 224],
      //     "assigned": [64],
      //     "a": [65, 250],
      //     "Crossref": [66],
      //     "DOI,": [67],
      //     "(2)": [68],
      //     "recent": [69, 128],
      //     "indexed": [72],
      //     "Web": [74],
      //     "Science,": [76],
      //     "(3)": [78],
      //     "viewed": [80],
      //     "by": [81, 120, 235],
      //     "users": [82, 91, 157],
      //     "Unpaywall,": [84],
      //     "open-source": [86],
      //     "browser": [87],
      //     "extension": [88],
      //     "lets": [90],
      //     "find": [92, 154],
      //     "oaDOI.": [96],
      //     "estimate": [98],
      //     "at": [100],
      //     "least": [101],
      //     "28%": [102],
      //     "literature": [106],
      //     "(19M": [109],
      //     "total)": [111],
      //     "proportion": [115],
      //     "growing,": [117],
      //     "driven": [118, 233],
      //     "particularly": [119],
      //     "growth": [121],
      //     "Gold": [123],
      //     "Hybrid.": [125],
      //     "The": [126],
      //     "most": [127, 171],
      //     "year": [129],
      //     "analyzed": [130],
      //     "(2015)": [131],
      //     "also": [132, 204],
      //     "has": [133],
      //     "highest": [135],
      //     "percentage": [136],
      //     "(45%).": [139],
      //     "Because": [140],
      //     "growth,": [143],
      //     "fact": [146],
      //     "readers": [148],
      //     "disproportionately": [149],
      //     "access": [150],
      //     "newer": [151],
      //     "we": [153, 188],
      //     "Unpaywall": [156],
      //     "encounter": [158],
      //     "quite": [160],
      //     "frequently:": [161],
      //     "47%": [162],
      //     "they": [165],
      //     "view": [166],
      //     "are": [167],
      //     "Notably,": [169],
      //     "common": [172],
      //     "mechanism": [173],
      //     "not": [177],
      //     "Gold,": [178],
      //     "Green,": [179],
      //     "or": [180],
      //     "Hybrid": [181, 238],
      //     "OA,": [182],
      //     "but": [183],
      //     "rather": [184],
      //     "under-discussed": [186],
      //     "category": [187],
      //     "dub": [189],
      //     "Bronze:": [190],
      //     "made": [192],
      //     "free-to-read": [193],
      //     "on": [194],
      //     "publisher": [196],
      //     "website,": [197],
      //     "without": [198],
      //     "explicit": [200],
      //     "license.": [202],
      //     "examine": [205],
      //     "citation": [207, 216],
      //     "impact": [208],
      //     "corroborating": [212],
      //     "so-called": [214],
      //     "open-access": [215],
      //     "advantage:": [217],
      //     "accounting": [218],
      //     "age": [220],
      //     "discipline,": [222],
      //     "receive": [225],
      //     "18%": [226],
      //     "more": [227],
      //     "citations": [228],
      //     "than": [229],
      //     "average,": [230],
      //     "effect": [232],
      //     "primarily": [234],
      //     "Green": [236],
      //     "encourage": [241],
      //     "further": [242],
      //     "research": [243],
      //     "free": [246],
      //     "oaDOI": [247],
      //     "service,": [248],
      //     "as": [249],
      //     "way": [251],
      //     "inform": [253],
      //     "policy": [255],
      //     "practice.": [257]
      //   },
      //   "cited_by_api_url": "https://api.openalex.org/works?filter=cites:W2741809807",
      //   "counts_by_year": [
      //     {"year": 2022, "cited_by_count": 13},
      //     {"year": 2021, "cited_by_count": 108}
      //   ],
      //   "updated_date": "2022-05-27",
      //   "created_date": "2017-08-08"
      // }

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
              )
              .having((work) => work.biblio, 'biblio', {
                "volume": "6",
                "issue": null,
                "first_page": null,
                "last_page": null
              })
              .having(
                (work) => work.authorships,
                'authors',
                [
                  isA<Authorship>()
                      .having(
                        (authorship) => authorship.authorPosition,
                        'position',
                        AuthorshipPosition.First,
                      )
                      .having(
                        (authorship) => authorship.author,
                        'author',
                        isA<AuthorDehydrated>()
                            .having(
                              (author) => author.id,
                              'id',
                              'https://openalex.org/A1969205032',
                            )
                            .having(
                              (author) => author.displayName,
                              'name',
                              'Heather A. Piwowar',
                            )
                            .having(
                              (author) => author.orcid,
                              'orcid',
                              'https://orcid.org/0000-0003-1613-5981',
                            ),
                      )
                      .having(
                        (authorship) => authorship.institutions,
                        'institution',
                        [isA<InstitutionDehydrated>()
                            .having(
                              (institution) => institution.id,
                              'id',
                              'https://openalex.org/I4200000001',
                            )
                            .having(
                              (institution) => institution.displayName,
                              'name',
                              'Our Research',
                            )
                            .having(
                              (institution) => institution.type,
                              'type',
                              InstitutionType.Nonprofit,
                            )
                            .having(
                              (institution) => institution.countryCode,
                              'country',
                              'CA',
                            )
                            .having(
                              (institution) => institution.ror,
                              'ror',
                              'https://ror.org/02nr0ka47',
                            )],
                      )
                      .having(
                          (author) => author.rawAffiliationString,
                          'rawAffiliationString',
                          'Impactstory, Sanford, NC, USA'),
                  isA<Authorship>()
                      .having(
                        (authorship) => authorship.authorPosition,
                        'position',
                        AuthorshipPosition.Middle,
                      )
                      .having(
                        (authorship) => authorship.author,
                        'author',
                        isA<AuthorDehydrated>()
                            .having(
                              (author) => author.id,
                              'id',
                              'https://openalex.org/A2208157607',
                            )
                            .having(
                              (author) => author.displayName,
                              'name',
                              'Jason Priem',
                            )
                            .having(
                              (author) => author.orcid,
                              'orcid',
                              'https://orcid.org/0000-0001-6187-6610',
                            ),
                      )
                      .having(
                    (authorship) => authorship.institutions,
                    'institution',
                    [
                      isA<InstitutionDehydrated>()
                          .having(
                            (institution) => institution.id,
                            'id',
                            'https://openalex.org/I4200000001',
                          )
                          .having(
                            (institution) => institution.displayName,
                            'name',
                            'Our Research',
                          )
                          .having(
                            (institution) => institution.type,
                            'type',
                            InstitutionType.Nonprofit,
                          )
                          .having(
                            (institution) => institution.countryCode,
                            'country',
                            'CA',
                          )
                          .having(
                            (institution) => institution.ror,
                            'ror',
                            'https://ror.org/02nr0ka47',
                          )
                    ],
                  ).having(
                    (p0) => p0.rawAffiliationString,
                    'rawAffiliationString',
                    'Impactstory, Sanford, NC, USA',
                  ),
                ],
              ) // todo: add more tests
          ,
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
                (author) => author.orcid,
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
                  (author) => author.lastKnownInstitution,
                  'lastKnownInstitution',
                  isA<InstitutionDehydrated>()
                      .having(
                        (institution) => institution.id,
                        'id',
                        'https://openalex.org/I4200000001',
                      )
                      .having(
                        (institution) => institution.ror,
                        'ror',
                        'https://ror.org/02nr0ka47',
                      )
                      .having(
                        (institution) => institution.displayName,
                        'displayName',
                        'Our Research',
                      )
                      .having(
                        (institution) => institution.countryCode,
                        'countryCode',
                        'CA',
                      )
                      .having(
                        (institution) => institution.type,
                        'type',
                        InstitutionType.Nonprofit,
                      ))
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
                isA<Year>()
                    .having((year) => year.year, 'year', 2022)
                    .having((year) => year.worksCount, 'worksCount', 0)
                    .having((year) => year.citedByCount, 'citedByCount', 52),
                isA<Year>()
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
                    isA<Year>()
                        .having((yearVenue) => yearVenue.year, 'year', 2022)
                        .having((yearVenue) => yearVenue.worksCount,
                            'worksCount', 883)
                        .having((yearVenue) => yearVenue.citedByCount,
                            'citedByCount', 18439),
                    isA<Year>()
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
                  (institution) => institution.international,
                  'international',
                  isA<International>().having(
                    (international) => international.displayName,
                    'displayName',
                    {
                      "ar":
                          "\u062c\u0627\u0645\u0639\u0629 \u0646\u0648\u0631\u062b \u0643\u0627\u0631\u0648\u0644\u064a\u0646\u0627 \u0641\u064a \u062a\u0634\u0627\u0628\u0644 \u0647\u064a\u0644",
                      "arz":
                          "\u062c\u0627\u0645\u0639\u0629 \u0646\u0648\u0631\u062b \u0643\u0627\u0631\u0648\u0644\u0627\u064a\u0646\u0627 \u0641\u0649 \u062a\u0634\u0627\u0628\u0644 \u0647\u064a\u0644"
                    },
                  ),
                )
                .having(
                  (institution) => institution.associatedInstitutions,
                  'associatedInstitutions',
                  [
                    isA<InstitutionDehydrated>()
                        .having(
                          (institution) => institution.displayName,
                          'displayName',
                          'Carolina Institute for NanoMedicine',
                        )
                        .having(
                          (institution) => institution.id,
                          'openAlexId',
                          'https://openalex.org/I4210157879',
                        )
                        .having(
                          (institution) => institution.ror,
                          'ror',
                          'https://ror.org/04q5n7269',
                        )
                        .having(
                          (institution) => institution.countryCode,
                          'countryCode',
                          'US',
                        )
                        .having(
                          (institution) => institution.type,
                          'type',
                          InstitutionType.Facility,
                        ),
                  ],
                )
                .having(
                  (institution) => institution.countsByYear,
                  'countsByYear',
                  [
                    isA<Year>()
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
                    isA<Year>()
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
    group('getConcept', () {
      const conceptId = 'https://openalex.org/C2778407487';
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await metaWorkApiClient.getConcept(conceptId);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https(
              'api.openalex.org',
              'concepts/$conceptId',
            ),
          ),
        ).called(1);
      });

      test('throws ConceptRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await metaWorkApiClient.getConcept(conceptId),
          throwsA(isA<ConceptRequestFailure>()),
        );
      });

      test('throws ConceptNotFoundFailure on 404 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await metaWorkApiClient.getConcept(conceptId),
          throwsA(isA<ConceptNotFoundFailure>()),
        );
      });
      test('returns concept on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(conceptJsonResponse);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await metaWorkApiClient.getConcept(conceptId);
        expect(
            actual,
            isA<Concept>()
                .having(
                  (concept) => concept.id,
                  'id',
                  'https://openalex.org/C2778407487',
                )
                .having(
                  (concept) => concept.wikidata,
                  'wikidata',
                  'https://www.wikidata.org/wiki/Q14565201',
                )
                // .having(
                //   (concept) => concept.displayName,
                //   'display_name',
                //   'Altmetrics',
                // )
                .having(
                  (concept) => concept.level,
                  'level',
                  2,
                )
                // .having(
                //   (concept) => concept.description,
                //   'description',
                //   'study of alternative metrics for analyzing and informing scholarship',
                // )
                .having(
                  (concept) => concept.worksCount,
                  'works_count',
                  3481,
                )
                .having(
                  (concept) => concept.citedByCount,
                  'cited_by_count',
                  19968,
                )
                .having(
                  (concept) => concept.magId,
                  'magId',
                  '2778407487',
                )
                .having(
                  (concept) => concept.wikipediaId,
                  'wikipediaId',
                  'https://en.wikipedia.org/wiki/Altmetrics',
                )
                .having(
                  (concept) => concept.imageUrl,
                  'imageUrl',
                  'https://upload.wikimedia.org/wikipedia/commons/f/f1/Altmetrics.svg',
                )
                .having(
                  (concept) => concept.imageThumbnailUrl,
                  'imageThumbnailUrl',
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f1/Altmetrics.svg/100px-Altmetrics.svg.png',
                )
                .having(
                  (concept) => concept.international,
                  'international',
                  isA<InternationalWithDescription>().having(
                    (international) => international.displayName,
                    'displayName',
                    {
                      'ca': 'Altmetrics',
                      'cs': 'altmetrika',
                    },
                  ).having(
                    (concept) => concept.description,
                    'description',
                    {
                      'ca': 'mètriques alternatives',
                      'en':
                          'study of alternative metrics for analyzing and informing scholarship',
                    },
                  ),
                )
                .having(
                  (concept) => concept.ancestors,
                  'ancestors',
                  [
                    isA<ConceptDehydrated>()
                        .having(
                          (concept) => concept.id,
                          'id',
                          'https://openalex.org/C2522767166',
                        )
                        .having(
                          (concept) => concept.displayName,
                          'displayName',
                          'Data science',
                        )
                        .having(
                          (concept) => concept.level,
                          'level',
                          1,
                        )
                        .having(
                          (concept) => concept.wikidata,
                          'wikidata',
                          'https://www.wikidata.org/wiki/Q2374463',
                        ),
                    isA<ConceptDehydrated>()
                        .having(
                          (concept) => concept.id,
                          'id',
                          'https://openalex.org/C161191863',
                        )
                        .having(
                          (concept) => concept.displayName,
                          'displayName',
                          'Library science',
                        )
                        .having(
                          (concept) => concept.level,
                          'level',
                          1,
                        )
                        .having(
                          (concept) => concept.wikidata,
                          'wikidata',
                          'https://www.wikidata.org/wiki/Q199655',
                        ),
                  ],
                )
                .having(
                  (concept) => concept.relatedConcepts,
                  'relatedConcepts',
                  [
                    isA<ConceptDehydrated>()
                        .having(
                          (concept) => concept.id,
                          'id',
                          'https://openalex.org/C2778793908',
                        )
                        .having(
                          (concept) => concept.displayName,
                          'displayName',
                          'Citation impact',
                        )
                        .having(
                          (concept) => concept.level,
                          'level',
                          3,
                        )
                        .having(
                          (concept) => concept.wikidata,
                          'wikidata',
                          null,
                        ),
                  ],
                )
                .having(
                  (concept) => concept.countsByYear,
                  'countsByYear',
                  [
                    isA<Year>()
                        .having(
                          (yearConcept) => yearConcept.year,
                          'year',
                          2022,
                        )
                        .having(
                          (yearConcept) => yearConcept.worksCount,
                          'works_count',
                          83,
                        )
                        .having(
                          (yearConcept) => yearConcept.citedByCount,
                          'cited_by_count',
                          1143,
                        ),
                    isA<Year>()
                        .having(
                          (yearConcept) => yearConcept.year,
                          'year',
                          2021,
                        )
                        .having(
                          (yearConcept) => yearConcept.worksCount,
                          'works_count',
                          204,
                        )
                        .having(
                          (yearConcept) => yearConcept.citedByCount,
                          'cited_by_count',
                          3395,
                        ),
                  ],
                )
                .having(
                  (concept) => concept.worksApiUrl,
                  'works_api_url',
                  'https://api.openalex.org/works?filter=concepts.id:C2778407487',
                )
                .having(
                  (concept) => concept.updatedDate,
                  'updated_date',
                  DateTime(2022, 6, 19),
                )
                .having(
                  (concept) => concept.createdDate,
                  'created_date',
                  DateTime(2018, 1, 5),
                ));
      });
    });
  });
}
