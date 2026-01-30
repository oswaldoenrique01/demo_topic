import 'package:equatable/equatable.dart';

enum ContentBlockType {
  title,
  subtitle,
  paragraph,
  image,
  video,
  code,
}

class ContentBlockEntity extends Equatable {
  final ContentBlockType type;
  final String value;

  const ContentBlockEntity({
    required this.type,
    required this.value,
  });

  @override
  List<Object?> get props => [type, value];
}
