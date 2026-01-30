import 'package:demo_valorant/core/injectors/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/topic_detail_bloc.dart';

class TopicDetailPage extends StatelessWidget {
  final String id;

  const TopicDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TopicDetailBloc>()..add(GetTopicDetailEvent(id)),
      child: Scaffold(
        body: BlocBuilder<TopicDetailBloc, TopicDetailState>(
          builder: (context, state) {
            if (state is TopicDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TopicDetailError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is TopicDetailLoaded) {
              final topic = state.topic;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 300.0,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(topic.name),
                      background: Hero(
                        tag: topic.id,
                        child: Image.network(
                          topic.bannerImage,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: Colors.grey,
                            child: const Center(
                              child: Icon(Icons.error, size: 50),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(topic.icon),
                                radius: 30,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  topic.name,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineMedium,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Description",
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            topic.description,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            "Gallery",
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: topic.gallery.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 300,
                                  margin: const EdgeInsets.only(right: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(
                                      image: NetworkImage(topic.gallery[index]),
                                      fit: BoxFit.cover,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
