import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/login_screen.dart';
import '../../features/execution/session_screen.dart';
import '../../features/exercises/exercise_detail_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/notes/notes_screen.dart';
import '../../features/reports/weekly_report_screen.dart';
import '../../features/workouts/workout_detail_screen.dart';
import '../../features/workouts/workouts_screen.dart';
import '../di/providers.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.read(authControllerProvider);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: auth,
    redirect: (context, state) {
      if (!auth.isReady) return null;
      final loggingIn = state.matchedLocation == '/login';
      if (!auth.isAuthenticated) return loggingIn ? null : '/login';
      if (loggingIn) return '/';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (c, s) => const LoginScreen()),
      GoRoute(path: '/', builder: (c, s) => const HomeScreen()),
      GoRoute(path: '/workouts', builder: (c, s) => const WorkoutsScreen()),
      GoRoute(
        path: '/workouts/:id',
        builder: (c, s) => WorkoutDetailScreen(workoutId: s.pathParameters['id']!),
      ),
      GoRoute(
        path: '/exercises/:id',
        builder: (c, s) => ExerciseDetailScreen(exerciseId: s.pathParameters['id']!),
      ),
      GoRoute(
        path: '/session/:workoutId',
        builder: (c, s) => SessionScreen(workoutId: s.pathParameters['workoutId']!),
      ),
      GoRoute(path: '/notes', builder: (c, s) => const NotesScreen()),
      GoRoute(path: '/reports', builder: (c, s) => const WeeklyReportScreen()),
    ],
  );
});
