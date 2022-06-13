import '../../domain/entities/cat_image.dart';

class CatImageModel extends CatImage {
  CatImageModel(
      {required super.id,
      required super.width,
      required super.height,
      required super.url})
      : super();

  factory CatImageModel.fromJson(Map<String, dynamic> json) => CatImageModel(
        id: json['id'],
        width: json['width'],
        height: json['height'],
        url: json['url'] ?? 'https://i.imgur.com/4gEy8mR.png',
      );
}
