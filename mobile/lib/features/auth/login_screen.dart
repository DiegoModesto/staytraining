import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/di/providers.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _tokenCtrl = TextEditingController();
  bool _showDev = false;

  @override
  void dispose() {
    _tokenCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider);

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.fitness_center, size: 72, color: Theme.of(context).colorScheme.primary),
                const SizedBox(height: 12),
                Text('StayTraining', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 32),
                if (auth.error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(auth.error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                  ),
                FilledButton.icon(
                  onPressed: auth.isBusy ? null : () => ref.read(authControllerProvider).loginOidc(),
                  icon: const Icon(Icons.login),
                  label: Text(auth.isBusy ? 'Entrando...' : 'Entrar'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => setState(() => _showDev = !_showDev),
                  child: const Text('Usar token (dev)'),
                ),
                if (_showDev) ...[
                  TextField(
                    controller: _tokenCtrl,
                    decoration: const InputDecoration(labelText: 'Bearer token', border: OutlineInputBorder()),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () => ref.read(authControllerProvider).loginManual(_tokenCtrl.text),
                    child: const Text('Continuar'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
