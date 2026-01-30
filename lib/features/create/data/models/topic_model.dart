import '../../domain/entities/content_block_entity.dart';

class ContentBlockModel extends ContentBlockEntity {
  const ContentBlockModel({
    required super.type,
    required super.value,
  });

  factory ContentBlockModel.fromJson(Map<String, dynamic> json) {
    return ContentBlockModel(
      type: json['type'] as dynamic,
      value: json['value'] as String,
    );
  }
}
