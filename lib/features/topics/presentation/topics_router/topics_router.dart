import 'package:commons/router/router.dart';
import 'package:demo_valorant/features/topics/domain/entities/subtopic_entity.dart';
import 'package:go_router/go_router.dart';

import '../pages/topics_page.dart';
import '../pages/subtopic_detail_page.dart';

class TopicsRouter extends BaseRoutes {
  static RouteName topics = RouteName(name: 'topics', path: '/topics');
  static RouteName subtopicDetail = RouteName(
    name: 'detail',
    path: 'topic/:topicId/detail/:subtopicId/:detailName',
  );

  @override
  List<RouteBase> get routes => [
    GoRoute(
      path: topics.path,
      name: topics.name,
      builder: (context, state) => const TopicsPage(),
      routes: [
        GoRoute(
          path: subtopicDetail.path,
          name: subtopicDetail.name,
          builder: (context, state) {
            final topicId = state.pathParameters['topicId']!;
            final subtopicId = state.pathParameters['subtopicId']!;
            final nameDetail = state.pathParameters['detailName']!;

            return SubtopicDetailPage(
              topicId: topicId,
              subtopicId: subtopicId,
              detailName: nameDetail,
            );
          },
        ),
      ],
    ),
  ];
}
