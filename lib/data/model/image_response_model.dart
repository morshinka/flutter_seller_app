// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// {
//     "image_path": "/upload/image/1703500974.png",
//     "base_url": "http://7c1c-2001-448a-406f-149b-b903-9318-d39f-9ffc.ngrok-free.app"
// }

class ImageResponseModel {
  final String imagePath;
  final String baseUrl;
  ImageResponseModel({
    required this.imagePath,
    required this.baseUrl,
  });

  ImageResponseModel copyWith({
    String? imagePath,
    String? baseUrl,
  }) {
    return ImageResponseModel(
      imagePath: imagePath ?? this.imagePath,
      baseUrl: baseUrl ?? this.baseUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imagePath': imagePath,
      'baseUrl': baseUrl,
    };
  }

  factory ImageResponseModel.fromMap(Map<String, dynamic> map) {
    return ImageResponseModel(
      imagePath: map['image_path'] as String,
      baseUrl: map['base_url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageResponseModel.fromJson(String source) =>
      ImageResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ImageResponseModel(imagePath: $imagePath, baseUrl: $baseUrl)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ImageResponseModel &&
        other.imagePath == imagePath &&
        other.baseUrl == baseUrl;
  }

  @override
  int get hashCode => imagePath.hashCode ^ baseUrl.hashCode;
}
