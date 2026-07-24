import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/di/providers.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: StayTrainingApp()));
}

class StayTrainingApp extends ConsumerStatefulWidget {
  const StayTrainingApp({super.key});

  @override
  ConsumerState<StayTrainingApp> createState() => _StayTrainingAppState();
}

class _StayTrainingAppState extends ConsumerState<StayTrainingApp> {
  @override
  void initState() {
    super.initState();
    // Restore auth + init local notifications after first frame.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(notificationServiceProvider).init();
      await ref.read(authControllerProvider).restore();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Register / clear the device push token as auth state flips (no-op until PUSH_ENABLED + Firebase).
    ref.listen(authControllerProvider, (_, next) {
      final push = ref.read(pushRegistrationServiceProvider);
      if (next.isAuthenticated) {
        push.register();
      } else {
        push.reset();
        // Clear cached data on logout so the next login starts fresh.
        ref.read(localStoreProvider).clearCache();
      }
    });

    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeControllerProvider).mode;
    return MaterialApp.router(
      title: 'StayTraining',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
