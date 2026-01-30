import 'package:demo_valorant/core/injectors/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/topic_model.dart';
import '../../domain/entities/content_block_entity.dart';
import '../bloc/form/form_bloc.dart';
import '../organism/content_bloc_widget.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FormCreateBloc>()..add(GetFormEvent()),
      child: ContentEditorPage(),
    );
  }
}

class ContentEditorPage extends StatefulWidget {
  const ContentEditorPage({super.key});

  @override
  State<ContentEditorPage> createState() => _ContentEditorPageState();
}

class _ContentEditorPageState extends State<ContentEditorPage> {
  final List<ContentBlockModel> blocks = [];

  void _addBlock(ContentBlockType type) {
    setState(() {
      blocks.add(
        ContentBlockModel(type: type, value: ''),
      );
    });
  }

  void _updateBlock(int index, ContentBlockModel updated) {
    setState(() {
      blocks[index] = updated;
    });
  }

  void _removeBlock(int index) {
    setState(() {
      blocks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear contenido')),
      floatingActionButton: PopupMenuButton<ContentBlockType>(
        icon: const Icon(Icons.add),
        onSelected: _addBlock,
        itemBuilder: (_) => ContentBlockType.values
            .map(
              (type) => PopupMenuItem(
            value: type,
            child: Text('Agregar ${type.name}'),
          ),
        )
            .toList(),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: blocks.length,
        itemBuilder: (_, index) {
          return ContentBlockEditor(
            block: blocks[index],
            onChanged: (updated) => _updateBlock(index, updated),
            onDelete: () => _removeBlock(index),
          );
        },
      ),
    );
  }
}
