const workJsonResponse = '''{
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
    }
  ],
  "referenced_works": [
    "https://openalex.org/W1560783210",
    "https://openalex.org/W1724212071"
  ],
  "related_works": [
    "https://openalex.org/W1655306493",
    "https://openalex.org/W1970217003"
  ],
  "abstract_inverted_index": {
    "Despite": [0],
    "growing": [1],
    "interest": [2],
    "in": [3, 57, 73, 110, 122]
  },
  "cited_by_api_url": "https://api.openalex.org/works?filter=cites:W2741809807",
  "counts_by_year": [
    {"year": 2022, "cited_by_count": 13},
    {"year": 2021, "cited_by_count": 108}
  ],
  "updated_date": "2022-05-27",
  "created_date": "2017-08-08"
}''';

const authorJsonResponse = '''{
  "id": "https://openalex.org/A1969205032",
  "orcid": "https://orcid.org/0000-0003-1613-5981",
  "display_name": "Heather A. Piwowar",
  "display_name_alternatives": [],
  "works_count": 50,
  "cited_by_count": 2691,
  "ids": {
    "openalex": "https://openalex.org/A1969205032",
    "orcid": "https://orcid.org/0000-0003-1613-5981",
    "mag": "1969205032",
    "twitter": "http://twitter.com/researchremix",
    "scopus":
        "http://www.scopus.com/inward/authorDetails.url?authorID=25122628200&partnerID=MN8TOARS"
  },
  "last_known_institution": {
    "id": "https://openalex.org/I4200000001",
    "ror": "https://ror.org/02nr0ka47",
    "display_name": "Our Research",
    "country_code": "CA",
    "type": "nonprofit"
  },
  "counts_by_year": [
    {"year": 2022, "works_count": 0, "cited_by_count": 52},
    {"year": 2021, "works_count": 1, "cited_by_count": 299}
  ],
  "works_api_url":
      "https://api.openalex.org/works?filter=author.id:A1969205032",
  "updated_date": "2022-03-09",
  "created_date": "2016-06-24"
}''';

const String venueJsonResponse = '''{
  "id": "https://openalex.org/V1983995261",
  "issn_l": "2167-8359",
  "issn": ["2167-8359"],
  "display_name": "PeerJ",
  "publisher": "PeerJ",
  "works_count": 21215,
  "cited_by_count": 153850,
  "is_oa": true,
  "is_in_doaj": true,
  "homepage_url": "http://www.peerj.com/",
  "ids": {
    "openalex": "https://openalex.org/V1983995261",
    "issn_l": "2167-8359",
    "mag": "1983995261",
    "issn": ["2167-8359"]
  },
  "counts_by_year": [
    {"year": 2022, "works_count": 883, "cited_by_count": 18439},
    {"year": 2021, "works_count": 4325, "cited_by_count": 46571}
  ],
  "works_api_url": "https://api.openalex.org/works?filter=host_venue.id:V1983995261",
  "updated_date": "2022-06-18",
  "created_date": "2016-06-24"
}''';

const String institutionJsonResponse = '''{
  "id": "https://openalex.org/I114027177",
  "ror": "https://ror.org/0130frc33",
  "display_name": "University of North Carolina at Chapel Hill",
  "country_code": "US",
  "type": "education",
  "homepage_url": "http://www.unc.edu/",
  "image_url": "https://upload.wikimedia.org/wikipedia/en/5/5c/University_of_North_Carolina_at_Chapel_Hill_seal.svg",
  "image_thumbnail_url": "https://upload.wikimedia.org/wikipedia/en/thumb/5/5c/University_of_North_Carolina_at_Chapel_Hill_seal.svg/100px-University_of_North_Carolina_at_Chapel_Hill_seal.svg.png",
  "display_name_acronyms": ["UNC"],
  "display_name_alternatives": ["UNC-Chapel Hill"],
  "works_count": 200714,
  "cited_by_count": 20698095,
  "ids": {
    "openalex": "https://openalex.org/I114027177",
    "ror": "https://ror.org/0130frc33",
    "mag": "114027177",
    "grid": "grid.10698.36",
    "wikipedia": "https://en.wikipedia.org/wiki/University%20of%20North%20Carolina%20at%20Chapel%20Hill",
    "wikidata": "https://www.wikidata.org/wiki/Q192334"
  },
  "geo": {
    "city": "Chapel Hill",
    "geonames_city_id": "4460162",
    "region": "North Carolina",
    "country_code": "US",
    "country": "United States",
    "latitude": 35.905163,
    "longitude": -79.04694
  },
  "international": {
    "display_name": {
      "ar": "\u062c\u0627\u0645\u0639\u0629 \u0646\u0648\u0631\u062b \u0643\u0627\u0631\u0648\u0644\u064a\u0646\u0627 \u0641\u064a \u062a\u0634\u0627\u0628\u0644 \u0647\u064a\u0644",
      "arz": "\u062c\u0627\u0645\u0639\u0629 \u0646\u0648\u0631\u062b \u0643\u0627\u0631\u0648\u0644\u0627\u064a\u0646\u0627 \u0641\u0649 \u062a\u0634\u0627\u0628\u0644 \u0647\u064a\u0644"
    }
  },
  "associated_institutions": [
    {
      "id": "https://openalex.org/I4210157879",
      "ror": "https://ror.org/04q5n7269",
      "display_name": "Carolina Institute for NanoMedicine",
      "country_code": "US",
      "type": "facility",
      "relationship": "child"
    }
  ],
  "counts_by_year": [
    {"year": 2022, "works_count": 5518, "cited_by_count": 771027},
    {"year": 2021, "works_count": 12787, "cited_by_count": 2119577}
  ],
  "works_api_url": "https://api.openalex.org/works?filter=institutions.id:I114027177",
  "updated_date": "2022-06-18",
  "created_date": "2016-06-24"
}''';

const String conceptJsonResponse = '''{
  "id": "https://openalex.org/C2778407487",
  "wikidata": "https://www.wikidata.org/wiki/Q14565201",
  "display_name": "Altmetrics",
  "level": 2,
  "description": "study of alternative metrics for analyzing and informing scholarship",
  "works_count": 3481,
  "cited_by_count": 19968,
  "ids": {
    "openalex": "https://openalex.org/C2778407487",
    "wikidata": "https://www.wikidata.org/wiki/Q14565201",
    "mag": "2778407487",
    "wikipedia": "https://en.wikipedia.org/wiki/Altmetrics"
  },
  "image_url": "https://upload.wikimedia.org/wikipedia/commons/f/f1/Altmetrics.svg",
  "image_thumbnail_url": "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f1/Altmetrics.svg/100px-Altmetrics.svg.png",
  "international": {
    "display_name": {
      "ca": "Altmetrics",
      "cs": "altmetrika"
    },
    "description": {
      "ca": "m\u00e8triques alternatives",
      "en": "study of alternative metrics for analyzing and informing scholarship"
    }
  },
  "ancestors": [
    {
      "id": "https://openalex.org/C2522767166",
      "wikidata": "https://www.wikidata.org/wiki/Q2374463",
      "display_name": "Data science",
      "level": 1
    },
    {
      "id": "https://openalex.org/C161191863",
      "wikidata": "https://www.wikidata.org/wiki/Q199655",
      "display_name": "Library science",
      "level": 1
    }
  ],
  "related_concepts": [
    {
      "id": "https://openalex.org/C2778793908",
      "wikidata": null,
      "display_name": "Citation impact",
      "level": 3,
      "score": 4.567492
    }
  ],
  "counts_by_year": [
    {"year": 2022, "works_count": 83, "cited_by_count": 1143},
    {"year": 2021, "works_count": 204, "cited_by_count": 3395}
  ],
  "works_api_url": "https://api.openalex.org/works?filter=concepts.id:C2778407487",
  "updated_date": "2022-06-19",
  "created_date": "2018-01-05"
}''';
