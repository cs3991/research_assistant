import 'package:open_alex_api/open_alex_api.dart';
import 'package:test/test.dart';

void main() {
  group('Work', () {
    group('fromJson', () {
      test('correctly decodes json', () {
        expect(
            Work.fromJson(<String, dynamic>{
              "id": "https://openalex.org/W2741809807",
              "doi": "https://doi.org/10.7717/peerj.4375",
              "title":
                  "\u00e9The state of OA: a large-scale analysis of the prevalence and impact of Open Access articles",
              "display_name":
                  "The state of OA: a large-scale analysis of the prevalence and impact of Open Access articles",
              "publication_year": 2018,
              "publication_date": "2018-02-13",
              "ids": {
                "openalex": "https://openalex.org/W2741809807",
                "doi": "https://doi.org/10.7717/peerj.4375",
                "mag": "2741809807",
                "pmid": "https://pubmed.ncbi.nlm.nih.gov/29456894",
                "pmcid": "https://www.ncbi.nlm.nih.gov/pmc/articles/5815332"
              },
              "host_venue": {
                "id": "https://openalex.org/V1983995261",
                "issn_l": "2167-8359",
                "issn": ["2167-8359"],
                "display_name": "PeerJ",
                "publisher": "PeerJ",
                "type": "publisher",
                "url": "https://doi.org/10.7717/peerj.4375",
                "is_oa": true,
                "version": "publishedVersion",
                "license": "cc-by"
              },
              "type": "journal-article",
              "open_access": {
                "is_oa": true,
                "oa_status": "gold",
                "oa_url": "https://peerj.com/articles/4375.pdf"
              },
              "authorships": [
                {
                  "author_position": "first",
                  "author": {
                    "id": "https://openalex.org/A1969205032",
                    "display_name": "Heather A. Piwowar",
                    "orcid": "https://orcid.org/0000-0003-1613-5981"
                  },
                  "institutions": [
                    {
                      "id": "https://openalex.org/I4200000001",
                      "display_name": "Our Research",
                      "ror": "https://ror.org/02nr0ka47",
                      "country_code": "CA",
                      "type": "nonprofit"
                    }
                  ],
                  "raw_affiliation_string": "Impactstory, Sanford, NC, USA"
                },
                {
                  "author_position": "middle",
                  "author": {
                    "id": "https://openalex.org/A2208157607",
                    "display_name": "Jason Priem",
                    "orcid": "https://orcid.org/0000-0001-6187-6610"
                  },
                  "institutions": [
                    {
                      "id": "https://openalex.org/I4200000001",
                      "display_name": "Our Research",
                      "ror": "https://ror.org/02nr0ka47",
                      "country_code": "CA",
                      "type": "nonprofit"
                    }
                  ],
                  "raw_affiliation_string": "Impactstory, Sanford, NC, USA"
                },
                {
                  "author_position": "middle",
                  "author": {
                    "id": "https://openalex.org/A291762745",
                    "display_name": "Vincent Larivi\u00e8re",
                    "orcid": "https://orcid.org/0000-0002-2733-0689"
                  },
                  "institutions": [
                    {
                      "id": "https://openalex.org/I70931966",
                      "display_name": "University of Montreal",
                      "ror": "https://ror.org/0161xgx34",
                      "country_code": "CA",
                      "type": "education"
                    },
                    {
                      "id": "https://openalex.org/I159129438",
                      "display_name": "University of Quebec at Montreal",
                      "ror": "https://ror.org/002rjbv21",
                      "country_code": "CA",
                      "type": "education"
                    }
                  ],
                  "raw_affiliation_string":
                      "\u00c9cole de biblioth\u00e9conomie et des sciences de l'information, Universit\u00e9 de Montr\u00e9al, Montr\u00e9al, QC, Canada."
                },
                {
                  "author_position": "middle",
                  "author": {
                    "id": "https://openalex.org/A2790141563",
                    "display_name": "Juan Pablo Alperin",
                    "orcid": "https://orcid.org/0000-0002-9344-7439"
                  },
                  "institutions": [
                    {
                      "id": "https://openalex.org/I18014758",
                      "display_name": "Simon Fraser University",
                      "ror": "https://ror.org/0213rcc28",
                      "country_code": "CA",
                      "type": "education"
                    },
                    {
                      "id": "https://openalex.org/I209863525",
                      "display_name": "Public Knowledge Project",
                      "ror": null,
                      "country_code": null,
                      "type": null
                    }
                  ],
                  "raw_affiliation_string":
                      "Canadian Institute for Studies in Publishing, Simon Fraser University, Vancouver, BC, Canada."
                },
                {
                  "author_position": "middle",
                  "author": {
                    "id": "https://openalex.org/A2738039797",
                    "display_name": "Lisa Matthias",
                    "orcid": "https://orcid.org/0000-0002-2612-2132"
                  },
                  "institutions": [
                    {
                      "id": "https://openalex.org/I18014758",
                      "display_name": "Simon Fraser University",
                      "ror": "https://ror.org/0213rcc28",
                      "country_code": "CA",
                      "type": "education"
                    }
                  ],
                  "raw_affiliation_string":
                      "Scholarly Communications Lab, Simon Fraser University, Vancouver, Canada."
                },
                {
                  "author_position": "middle",
                  "author": {
                    "id": "https://openalex.org/A2741312048",
                    "display_name": "Bree Norlander",
                    "orcid": "https://orcid.org/0000-0002-0431-4221"
                  },
                  "institutions": [
                    {
                      "id": "https://openalex.org/I201448701",
                      "display_name": "University of Washington",
                      "ror": "https://ror.org/00cvxb145",
                      "country_code": "US",
                      "type": "education"
                    }
                  ],
                  "raw_affiliation_string":
                      "Information School, University of Washington, Seattle, USA"
                },
                {
                  "author_position": "middle",
                  "author": {
                    "id": "https://openalex.org/A2741153153",
                    "display_name": "Ashley Farley",
                    "orcid": null
                  },
                  "institutions": [
                    {
                      "id": "https://openalex.org/I201448701",
                      "display_name": "University of Washington",
                      "ror": "https://ror.org/00cvxb145",
                      "country_code": "US",
                      "type": "education"
                    }
                  ],
                  "raw_affiliation_string":
                      "Information School, University of Washington, Seattle, USA"
                },
                {
                  "author_position": "middle",
                  "author": {
                    "id": "https://openalex.org/A2162292103",
                    "display_name": "Jevin D. West",
                    "orcid": "https://orcid.org/0000-0002-4118-0322"
                  },
                  "institutions": [
                    {
                      "id": "https://openalex.org/I201448701",
                      "display_name": "University of Washington",
                      "ror": "https://ror.org/00cvxb145",
                      "country_code": "US",
                      "type": "education"
                    }
                  ],
                  "raw_affiliation_string":
                      "[Information School, University of Washington, Seattle, USA]"
                },
                {
                  "author_position": "last",
                  "author": {
                    "id": "https://openalex.org/A2027010983",
                    "display_name": "Stefanie Haustein",
                    "orcid": "https://orcid.org/0000-0003-0157-1430"
                  },
                  "institutions": [
                    {
                      "id": "https://openalex.org/I159129438",
                      "display_name": "University of Quebec at Montreal",
                      "ror": "https://ror.org/002rjbv21",
                      "country_code": "CA",
                      "type": "education"
                    },
                    {
                      "id": "https://openalex.org/I153718931",
                      "display_name": "University of Ottawa",
                      "ror": "https://ror.org/03c4mmv16",
                      "country_code": "CA",
                      "type": "education"
                    }
                  ],
                  "raw_affiliation_string":
                      "Observatoire des Sciences et des Technologies (OST), Centre Interuniversitaire de Recherche sur la Science et la Technologie (CIRST),, Universit\u00e9 du Qu\u00e9bec \u00e0 Montr\u00e9al, Montr\u00e9al, QC, Canada"
                }
              ],
              "cited_by_count": 394,
              "biblio": {
                "volume": "6",
                "issue": null,
                "first_page": null,
                "last_page": null
              },
              "is_retracted": false,
              "is_paratext": false,
              "concepts": [
                {
                  "id": "https://openalex.org/C2778805511",
                  "wikidata": "https://www.wikidata.org/wiki/Q1713",
                  "display_name": "Citation",
                  "level": 2,
                  "score": "0.4473064"
                },
                {
                  "id": "https://openalex.org/C178315738",
                  "wikidata": "https://www.wikidata.org/wiki/Q603441",
                  "display_name": "Bibliometrics",
                  "level": 2,
                  "score": "0.44480205"
                },
                {
                  "id": "https://openalex.org/C2777462167",
                  "wikidata": "https://www.wikidata.org/wiki/Q7432048",
                  "display_name": "Scholarly communication",
                  "level": 3,
                  "score": "0.44104964"
                },
                {
                  "id": "https://openalex.org/C525823164",
                  "wikidata": "https://www.wikidata.org/wiki/Q472342",
                  "display_name": "Scientometrics",
                  "level": 2,
                  "score": "0.43013373"
                }
              ],
              "mesh": [],
              "alternate_host_venues": [
                {
                  "id": "https://openalex.org/V1983995261",
                  "display_name": "PeerJ",
                  "type": "journal",
                  "url": "https://peerj.com/articles/4375.pdf",
                  "is_oa": true,
                  "version": "publishedVersion",
                  "license": "cc-by"
                },
                {
                  "id": null,
                  "display_name": "Europe PMC",
                  "type": "repository",
                  "url": "http://europepmc.org/articles/pmc5815332?pdf=render",
                  "is_oa": true,
                  "version": "publishedVersion",
                  "license": "cc-by"
                },
                {
                  "id": null,
                  "display_name": "PMC",
                  "type": "repository",
                  "url": "https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5815332",
                  "is_oa": true,
                  "version": "publishedVersion",
                  "license": null
                },
                {
                  "id": null,
                  "display_name": null,
                  "type": "repository",
                  "url":
                      "https://digitalcommons.unl.edu/cgi/viewcontent.cgi?article=1143&context=scholcom",
                  "is_oa": true,
                  "version": "submittedVersion",
                  "license": "cc-by"
                },
                {
                  "id": null,
                  "display_name":
                      "Universit\u00e9 de Montr\u00e9al - Papyrus : Institutional Repository",
                  "type": "repository",
                  "url":
                      "https://papyrus.bib.umontreal.ca/xmlui/bitstream/1866/23242/1/peerj-06-4375.pdf",
                  "is_oa": true,
                  "version": "submittedVersion",
                  "license": "cc-by"
                },
                {
                  "id": null,
                  "display_name": "Simon Fraser University - Summit",
                  "type": "repository",
                  "url": "https://summit.sfu.ca/item/17691",
                  "is_oa": true,
                  "version": "submittedVersion",
                  "license": "cc-by"
                },
                {
                  "id": null,
                  "display_name": "Simon Fraser University - Summit",
                  "type": "repository",
                  "url":
                      "http://summit.sfu.ca/system/files/iritems1/17691/peerj-4375.pdf",
                  "is_oa": true,
                  "version": "submittedVersion",
                  "license": "cc-by"
                },
                {
                  "id": null,
                  "display_name": "Semantic Scholar",
                  "type": "repository",
                  "url":
                      "http://pdfs.semanticscholar.org/bca1/531b0562c6d72e0c283c1ccb97eb5cb02117.pdf",
                  "is_oa": true,
                  "version": "submittedVersion",
                  "license": null
                }
              ],
              "referenced_works": [
                "https://openalex.org/W1560783210",
                "https://openalex.org/W1724212071",
                "https://openalex.org/W1767272795",
                "https://openalex.org/W1917633107",
                "https://openalex.org/W1957687230",
                "https://openalex.org/W1989318653",
                "https://openalex.org/W2003844967",
                "https://openalex.org/W2016860460",
                "https://openalex.org/W2020807482",
                "https://openalex.org/W2029057325",
                "https://openalex.org/W2031754690",
                "https://openalex.org/W2048185449",
                "https://openalex.org/W2078310052",
                "https://openalex.org/W2089123513",
                "https://openalex.org/W2115339903",
                "https://openalex.org/W2140880926",
                "https://openalex.org/W2160597895",
                "https://openalex.org/W2231201268",
                "https://openalex.org/W2306268324",
                "https://openalex.org/W2322381034",
                "https://openalex.org/W2343014812",
                "https://openalex.org/W2345375849",
                "https://openalex.org/W2463568293",
                "https://openalex.org/W2511661767",
                "https://openalex.org/W2520991028",
                "https://openalex.org/W2563251083",
                "https://openalex.org/W2566143661",
                "https://openalex.org/W2587705861",
                "https://openalex.org/W2588027260",
                "https://openalex.org/W2753353163",
                "https://openalex.org/W2762597540",
                "https://openalex.org/W2785823074",
                "https://openalex.org/W2953072907",
                "https://openalex.org/W3121567788"
              ],
              "related_works": [
                "https://openalex.org/W1655306493",
                "https://openalex.org/W1970217003",
                "https://openalex.org/W1989318653",
                "https://openalex.org/W1996515099",
                "https://openalex.org/W2016860460",
                "https://openalex.org/W2023783748",
                "https://openalex.org/W2029057325",
                "https://openalex.org/W2048185449",
                "https://openalex.org/W2089123513",
                "https://openalex.org/W2089604928",
                "https://openalex.org/W2104772551",
                "https://openalex.org/W2140880926",
                "https://openalex.org/W2302501749",
                "https://openalex.org/W2322381034",
                "https://openalex.org/W2463568293",
                "https://openalex.org/W2520991028",
                "https://openalex.org/W2587705861",
                "https://openalex.org/W2783957468",
                "https://openalex.org/W2785823074",
                "https://openalex.org/W2962868865"
              ],
              "abstract_inverted_index": {
                "Despite": [0],
                "growing": [1],
                "interest": [2],
                "in": [3, 57, 73, 110, 122],
                "Open": [4, 201],
                "Access": [5],
                "(OA)": [6],
                "to": [7, 54, 252],
                "scholarly": [8, 105],
                "literature,": [9],
                "there": [10],
                "is": [11, 107, 116, 176],
                "an": [12, 34, 85, 185, 199, 231],
                "unmet": [13],
                "need": [14, 31],
                "for": [15, 42, 174, 219],
                "large-scale,": [16],
                "up-to-date,": [17],
                "and": [18, 24, 77, 112, 124, 144, 221, 237, 256],
                "reproducible": [19],
                "studies": [20],
                "assessing": [21],
                "the": [22, 104, 134, 145, 170, 195, 206, 213, 245],
                "prevalence": [23],
                "characteristics": [25],
                "of": [26, 51, 75, 83, 103, 137, 141, 163, 209],
                "OA.": [27, 168, 239],
                "We": [28, 46, 97, 203, 240],
                "address": [29],
                "this": [30, 114, 142],
                "using": [32, 95, 244],
                "oaDOI,": [33],
                "open": [35],
                "online": [36],
                "service": [37],
                "that": [38, 89, 99, 113, 147, 155],
                "determines": [39],
                "OA": [40, 56, 93, 108, 138, 159, 175, 210, 223, 254],
                "status": [41],
                "67": [43],
                "million": [44],
                "articles.": [45],
                "use": [47],
                "three": [48, 58],
                "samples,": [49],
                "each": [50],
                "100,000": [52],
                "articles,": [53, 152, 211],
                "investigate": [55],
                "populations:": [59],
                "(1)": [60],
                "all": [61],
                "journal": [62, 70],
                "articles": [63, 71, 79, 94, 164, 191, 224],
                "assigned": [64],
                "a": [65, 250],
                "Crossref": [66],
                "DOI,": [67],
                "(2)": [68],
                "recent": [69, 128],
                "indexed": [72],
                "Web": [74],
                "Science,": [76],
                "(3)": [78],
                "viewed": [80],
                "by": [81, 120, 235],
                "users": [82, 91, 157],
                "Unpaywall,": [84],
                "open-source": [86],
                "browser": [87],
                "extension": [88],
                "lets": [90],
                "find": [92, 154],
                "oaDOI.": [96],
                "estimate": [98],
                "at": [100],
                "least": [101],
                "28%": [102],
                "literature": [106],
                "(19M": [109],
                "total)": [111],
                "proportion": [115],
                "growing,": [117],
                "driven": [118, 233],
                "particularly": [119],
                "growth": [121],
                "Gold": [123],
                "Hybrid.": [125],
                "The": [126],
                "most": [127, 171],
                "year": [129],
                "analyzed": [130],
                "(2015)": [131],
                "also": [132, 204],
                "has": [133],
                "highest": [135],
                "percentage": [136],
                "(45%).": [139],
                "Because": [140],
                "growth,": [143],
                "fact": [146],
                "readers": [148],
                "disproportionately": [149],
                "access": [150],
                "newer": [151],
                "we": [153, 188],
                "Unpaywall": [156],
                "encounter": [158],
                "quite": [160],
                "frequently:": [161],
                "47%": [162],
                "they": [165],
                "view": [166],
                "are": [167],
                "Notably,": [169],
                "common": [172],
                "mechanism": [173],
                "not": [177],
                "Gold,": [178],
                "Green,": [179],
                "or": [180],
                "Hybrid": [181, 238],
                "OA,": [182],
                "but": [183],
                "rather": [184],
                "under-discussed": [186],
                "category": [187],
                "dub": [189],
                "Bronze:": [190],
                "made": [192],
                "free-to-read": [193],
                "on": [194],
                "publisher": [196],
                "website,": [197],
                "without": [198],
                "explicit": [200],
                "license.": [202],
                "examine": [205],
                "citation": [207, 216],
                "impact": [208],
                "corroborating": [212],
                "so-called": [214],
                "open-access": [215],
                "advantage:": [217],
                "accounting": [218],
                "age": [220],
                "discipline,": [222],
                "receive": [225],
                "18%": [226],
                "more": [227],
                "citations": [228],
                "than": [229],
                "average,": [230],
                "effect": [232],
                "primarily": [234],
                "Green": [236],
                "encourage": [241],
                "further": [242],
                "research": [243],
                "free": [246],
                "oaDOI": [247],
                "service,": [248],
                "as": [249],
                "way": [251],
                "inform": [253],
                "policy": [255],
                "practice.": [257]
              },
              "cited_by_api_url":
                  "https://api.openalex.org/works?filter=cites:W2741809807",
              "counts_by_year": [
                {"year": 2022, "cited_by_count": 13},
                {"year": 2021, "cited_by_count": 108},
                {"year": 2020, "cited_by_count": 126},
                {"year": 2019, "cited_by_count": 97},
                {"year": 2018, "cited_by_count": 47},
                {"year": 2017, "cited_by_count": 6}
              ],
              "updated_date": "2022-05-27",
              "created_date": "2017-08-08"
            }),
            isA<Work>()
                .having((e) => e.title, 'title',
                    'éThe state of OA: a large-scale analysis of the prevalence and impact of Open Access articles')
                .having(
                    (e) => e.citedByCountsByYear, 'cited by count by year', {
                  2022: 13,
                  2021: 108,
                  2020: 126,
                  2019: 97,
                  2018: 47,
                  2017: 6
                })
                .having((e) => e.citedByCount, 'cited by count', 394)
                .having(
                    (e) => e.type, 'type', isIn([WorkType.journalArticle])));
      });
    });
  });
}
