import '../../domain/entities/topic_entity.dart';

class TopicModel extends TopicEntity {
  const TopicModel({
    required super.id,
    required super.name,
    required super.icon,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
    );
  }
}
