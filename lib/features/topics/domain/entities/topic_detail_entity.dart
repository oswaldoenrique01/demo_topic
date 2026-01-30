import 'package:equatable/equatable.dart';

class TopicDetailEntity extends Equatable {
  final String id;
  final String name;
  final String icon;
  final String description;
  final String bannerImage;
  final List<String> gallery;

  const TopicDetailEntity({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.bannerImage,
    required this.gallery,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    icon,
    description,
    bannerImage,
    gallery,
  ];
}
