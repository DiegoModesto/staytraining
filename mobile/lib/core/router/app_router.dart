import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/login_screen.dart';
import '../../features/execution/session_screen.dart';
import '../../features/exercises/exercise_detail_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/notes/notes_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/questions/questions_screen.dart';
import '../../features/reports/weekly_report_screen.dart';
import '../../features/workouts/workout_builder_screen.dart';
import '../../features/workouts/workout_detail_screen.dart';
import '../../features/workouts/workouts_screen.dart';
import '../ui/main_shell.dart';
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
      // Full-screen routes (no bottom nav / rail): login and the immersive workout session.
      GoRoute(path: '/login', builder: (c, s) => const LoginScreen()),
      GoRoute(
        path: '/session/:workoutId',
        builder: (c, s) => SessionScreen(workoutId: s.pathParameters['workoutId']!),
      ),

      // Main app: responsive shell with one branch (stack) per tab.
      StatefulShellRoute.indexedStack(
        builder: (c, s, navigationShell) => MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/', builder: (c, s) => const HomeScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/workouts',
                builder: (c, s) => const WorkoutsScreen(),
                routes: [
                  // 'new' before ':id' so it isn't captured as an id.
                  GoRoute(path: 'new', builder: (c, s) => const WorkoutBuilderScreen()),
                  GoRoute(
                    path: ':id',
                    builder: (c, s) => WorkoutDetailScreen(workoutId: s.pathParameters['id']!),
                  ),
                ],
              ),
              GoRoute(
                path: '/exercises/:id',
                builder: (c, s) => ExerciseDetailScreen(exerciseId: s.pathParameters['id']!),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/notes', builder: (c, s) => const NotesScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/reports', builder: (c, s) => const WeeklyReportScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/profile', builder: (c, s) => const ProfileScreen()),
              GoRoute(path: '/questions', builder: (c, s) => const QuestionsScreen()),
            ],
          ),
        ],
      ),
    ],
  );
});
