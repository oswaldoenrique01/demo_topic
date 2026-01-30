import 'package:commons/commons.dart';
import 'package:demo_valorant/features/home/presentation/pages/home_page.dart';
import 'package:demo_valorant/features/selection/presentation/pages/selection_page.dart';
import 'package:demo_valorant/features/splash/presentation/pages/splash_page.dart';
import 'package:demo_valorant/features/topics/presentation/pages/topics_page.dart';
import 'package:go_router/go_router.dart';

import '../../features/create/presentation/pages/create_page.dart';

class AppRouter implements BaseRoutes {
  static RouteName splash = RouteName(name: 'splash', path: '/');
  static RouteName selection = RouteName(name: 'selection', path: '/selection');
  static RouteName home = RouteName(name: 'home', path: '/home');
  static RouteName topics = RouteName(name: 'topics', path: '/topics');
  static RouteName create = RouteName(name: 'create', path: '/create');

  @override
  List<RouteBase> get routes => [
    GoRoute(
      path: splash.path,
      name: splash.name,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: selection.path,
      name: selection.name,
      builder: (context, state) => const SelectionPage(),
    ),
    GoRoute(
      path: home.path,
      name: home.name,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: topics.path,
      name: topics.name,
      builder: (context, state) => const TopicsPage(),
    ),
    GoRoute(
      path: create.path,
      name: create.name,
      builder: (context, state) => const CreatePage(),
    ),
  ];
}
