import 'package:demo_valorant/core/injectors/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/topics_bloc.dart';

class TopicsPage extends StatelessWidget {
  const TopicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TopicsBloc>()..add(GetTopicsEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Topics')),
        body: BlocBuilder<TopicsBloc, TopicsState>(
          builder: (context, state) {
            if (state is TopicsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TopicsError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is TopicsLoaded) {
              return ListView.separated(
                itemCount: state.topics.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final topic = state.topics[index];
                  final imageUrl = topic.icon;

                  return ListTile(
                    leading: Image.network(
                      imageUrl,
                      width: 40,
                      height: 40,
                      errorBuilder: (_, __, ___) => const Icon(Icons.error),
                    ),
                    title: Text(topic.name),
                    subtitle: Text(topic.id),
                  );
                },
              );
            }
            return const Center(child: Text('No topics loaded'));
          },
        ),
      ),
    );
  }
}
