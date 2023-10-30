enum Continent {
  africa("Africa", "Q15"),
  antarctica("Antarctica", "Q51"),
  asia("Asia", "Q48"),
  europe("Europe", "Q46"),
  northAmerica("North America", "Q49"),
  oceania("Oceania", "Q55643"),
  southAmerica("South America", "Q18");

  const Continent(
    this.name,
    this.id,
  );

  final String name;

  final String id;
}
