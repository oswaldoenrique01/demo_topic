import 'package:demo_valorant/features/topics/domain/entities/subtopic_entity.dart';
import 'package:demo_valorant/features/topics/domain/entities/topic_entity.dart';
import 'package:flutter/material.dart';
import '../../../../auth/authentication/data/cache/session_cache.dart';
import '../atoms/topic_icon.dart';
import '../molecules/subtopic_item.dart';

class TopicAccordion extends StatefulWidget {
  final TopicEntity topic;
  final bool isLoading;
  final List<SubtopicEntity> subtopics;
  final String? errorMessage;
  final VoidCallback? onTap;
  final bool shouldExpand;
  final ValueChanged<SubtopicEntity>? onSubtopic;
  final VoidCallback? onEditTopic;
  final ValueChanged<SubtopicEntity>? onEditSubtopic;
  final VoidCallback? onAddSubtopic;

  const TopicAccordion({
    super.key,
    required this.topic,
    required this.onTap,
    this.isLoading = false,
    this.subtopics = const [],
    this.errorMessage,
    this.shouldExpand = false,
    this.onSubtopic,
    this.onEditTopic,
    this.onEditSubtopic,
    this.onAddSubtopic,
  });

  @override
  State<TopicAccordion> createState() => _TopicAccordionState();
}

class _TopicAccordionState extends State<TopicAccordion> {
  final ExpansibleController _controller = ExpansibleController();

  @override
  void didUpdateWidget(TopicAccordion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shouldExpand && !oldWidget.shouldExpand) {
      _controller.expand();
    }
  }

  @override
  Widget build(BuildContext context) {
    final String errorMessage = widget.errorMessage ?? '';
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ExpansionTile(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          controller: _controller,
          onExpansionChanged: (expanded) {
            if (expanded) {
              widget.onTap?.call();
            }
          },
          tilePadding: const EdgeInsets.all(16.0),
          childrenPadding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16,
          ),
          leading: TopicIcon(url: widget.topic.icon),
          title: Text(
            widget.topic.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
              fontSize: 16,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.onEditTopic != null &&
                  cacheUser.role == RoleUser.admin)
                IconButton(
                  icon: const Icon(Icons.edit, size: 20, color: Colors.grey),
                  onPressed: widget.onEditTopic,
                  splashRadius: 20,
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                ),
              const SizedBox(width: 8),
              _buildTrailingIcon(),
            ],
          ),
          children: [
            if (widget.subtopics.isNotEmpty)
              ...widget.subtopics.map(
                (subtopic) => GestureDetector(
                  onTap: () => widget.onSubtopic?.call(
                    SubtopicEntity(
                      id: subtopic.id,
                      name: subtopic.name,
                      icon: subtopic.icon,
                      topicId: widget.topic.id,
                    ),
                  ),
                  child: SubtopicItem(
                    subtopic: subtopic,
                    onEdit: () => widget.onEditSubtopic?.call(subtopic),
                  ),
                ),
              ),
            if (widget.isLoading)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),

            if (widget.subtopics.isEmpty &&
                !widget.isLoading &&
                errorMessage.isEmpty)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.layers_clear_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Sin subtemas registrados",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Selecciona otro tema para explorar más detalles.",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),

            if (errorMessage.isNotEmpty)
              Text(
                'Error: ${widget.errorMessage}',
                style: const TextStyle(color: Colors.red),
              ),
            if (widget.onAddSubtopic != null &&
                cacheUser.role == RoleUser.admin)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextButton.icon(
                  onPressed: widget.onAddSubtopic,
                  icon: const Icon(Icons.add, size: 20),
                  label: const Text('Agregar Subtema'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Colors.blue.withAlpha(13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrailingIcon() {
    if (widget.isLoading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }
    return const Icon(Icons.expand_more, color: Colors.grey);
  }
}
