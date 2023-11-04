import 'package:open_alex_api/open_alex_api.dart' as openAlexApi;

class Work {
  Work({
    required this.title,
    required this.authors,
  });

  factory Work.fromApi(openAlexApi.Work work) {
    return Work(
      title: work.title ?? '',
      authors: work.authorships.map((e) => e.author.displayName).toList(),
    );
  }

  String title;
  List<String> authors;
  String abstract =
      "The proliferation of electric vehicles (EVs) and their inherent flexibility in charging timings make them an asset to improve grid performance. In contrast to direct control by a utility or autonomous price-based charging, the transactive control framework not only provides benefits to both grid and customers but also ensures customer autonomy. In this work, we design a transactive electric vehicle (TEV) agent that incorporates the EV owner's willingness to trade-off between savings and amenity in form of a slider, where the EV owner's amenity is characterized as vehicle readiness. Further, a privacy-preserving bidding formulation is proposed that also represents the customer's transactive preference. A transactive market mechanism is discussed that integrates the TEV Agents into the local retail market and reconciles with the current day-ahead and real-time market structure. It is demonstrated that the proposed slider is able to provide a preferred trade-off between savings and amenity to individual customers. At the same time, the market mechanism is shown to successfully reduce both peak prices and peak demand. A comparative investigation of V1G and V2G technologies with respect to the battery prices is also discussed.";
}
