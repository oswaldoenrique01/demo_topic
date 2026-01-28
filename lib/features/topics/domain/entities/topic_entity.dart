import 'package:equatable/equatable.dart';

class TopicEntity extends Equatable {
  final String id;
  final String name;
  final String icon;

  const TopicEntity({required this.id, required this.name, required this.icon});

  @override
  List<Object?> get props => [id, name, icon];
}
