import 'dart:math';

class ElasticDetail {
  String id;
  String name;
  String weft;
  String rubber;
  String covering;
  int quantitySold;
  List<Map<String, String>> warpYarns;

  String pick;
  String hooks;
  String weight;
  String elongation;
  String recovery;
  String strech;
  String drawType;
  int stock;
  String? order;
  int rubberEnds;
  String image =
      "https://m.media-amazon.com/images/I/71T+RigBjqL._AC_UF894,1000_QL80_.jpg";
  String costing;

  ElasticDetail(
      {required this.id,
      required this.name,
      required this.weft,
      required this.rubber,
      required this.covering,
      required this.quantitySold,
      required this.warpYarns,
      required this.pick,
      required this.hooks,
      required this.weight,
      required this.elongation,
      required this.recovery,
      required this.strech,
      required this.drawType,
      required this.stock,
      this.order,

      required this.costing,
      required this.rubberEnds});

  factory ElasticDetail.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        '_id': String id,
        'name': String name,
        'warpSpandex': Map rubber,
        'spandexCovering': Map covering,
        'weftYarn': Map weft,

        'quantityProduced': int quantitySold,
        'stock': int stock,
        'spandexEnds': int rubberEnds,
        'yarnEnds': int yarnEnds,
        'pick': double pick,
        'noOfHook': int designHooks,
        'weight': int weight,
        'warpYarn': List warpYarn,
        'testingParameters': Map testing,
        'drawType': dynamic dt,
        'costing': dynamic costing
      } =>
        ElasticDetail(
            id: id,
            name: name,
            weft: weft['id']['name'],
            covering: covering['id']['name'],
            rubber: rubber['id']['name'],

            quantitySold: quantitySold,
            stock: stock,
            rubberEnds: rubberEnds,
            pick: pick.toString(),
            hooks: designHooks.toString(),
            weight: weight.toString(),
            strech: testing['strech'].toString(),
            elongation: testing['elongation'].toString(),
            recovery: testing['recovery'].toString(),
            drawType: dt ?? "8",
            warpYarns: warpYarn
                .map((x) => {
                      'name': x['id']['name'].toString(),
                      'ends': x['ends'].toString(),
                      'type': x['type'] != null ? x['type'].toString() : 'base'
                    })
                .toList(),
            costing: costing ?? "not assigned"),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
