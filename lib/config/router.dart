import 'package:go_router/go_router.dart';
import '../screens/home/home_screen.dart';
import '../screens/home/task_detail_screen.dart';
import '../screens/flag/flag_detail_screen.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(initialIndex: 0),
        routes: [
          GoRoute(
            path: 'task/:taskId',
            builder: (context, state) {
              final taskId = state.pathParameters['taskId']!;
              return TaskDetailScreen(taskId: taskId);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/flag',
        builder: (context, state) => const HomeScreen(initialIndex: 1),
        routes: [
          GoRoute(
            path: ':flagId',
            builder: (context, state) {
              final flagId = state.pathParameters['flagId']!;
              return FlagDetailScreen(flagId: flagId);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const HomeScreen(initialIndex: 2),
      ),
    ],
  );

GoRouter getRouter() => _router;