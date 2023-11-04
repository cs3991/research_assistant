import 'package:open_alex_api/open_alex_api.dart' as openAlexApi;

class Work {
  Work({
    required this.title,
    required this.authors,
    required this.abstract,
  });

  factory Work.fromApi(openAlexApi.Work work) {
    var abstractList = <String>[];
    if (work.abstractInvertedIndex != null) {
      int abstractLength = 0;
      for (final positions in work.abstractInvertedIndex!.values) {
        for (var position in positions) {
          if (position > abstractLength) {
            abstractLength = position;
          }
        }
      }
      abstractList = List.filled(abstractLength + 1, '');
      for (final word in work.abstractInvertedIndex!.keys) {
        for (final position in work.abstractInvertedIndex![word]!) {
          abstractList[position] = word;
        }
      }
    }

    return Work(
      title: work.title ?? '',
      authors: work.authorships.map((e) => e.author.displayName).toList(),
      abstract: abstractList.join(' '),
    );
  }

  String title;
  List<String> authors;
  String abstract;
}
