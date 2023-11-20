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
    required this.doiUrl,
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
  Uri? doiUrl;

  String toString() {
    return 'Work(title: $title)';
  }
}
