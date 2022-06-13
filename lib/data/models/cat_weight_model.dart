import 'package:cats/domain/entities/cat_weight.dart';

class CatWeightModel extends CatWeight {
  CatWeightModel({required super.imperial, required super.metric});

  factory CatWeightModel.fromJson(Map<String, dynamic> json) =>
      CatWeightModel(imperial: json['imperial'], metric: json['metric']);
}
