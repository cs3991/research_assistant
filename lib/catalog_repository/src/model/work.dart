

class Work {
  Work({
    required this.title,
    required this.authors,
    required this.abstract,
    required this.primaryLocation,
    required this.citedByCount,
    required this.publicationYear,
    required this.publicationDate,
    required this.isOpenAccess,
    required this.conceptsNames,
    this.bestOaUrl,
  });

  String title;
  List<String> authors;
  String abstract;
  String primaryLocation;
  int citedByCount;
  int publicationYear;
  DateTime publicationDate;
  bool isOpenAccess;
  List<String> conceptsNames;
  Uri? bestOaUrl;
}
