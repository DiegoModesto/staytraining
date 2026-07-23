import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/di/providers.dart';
import '../../core/ui/responsive.dart';
import '../../models/models.dart';

/// "Meu perfil" / ficha do aluno — view + edit personal data, profile photo (pick + crop) and,
/// for students, their health apports (add/remove) using the catalog.
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  Profile? _profile;
  bool _loading = true;
  bool _saving = false;
  String? _error;

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _emergency = TextEditingController();
  final _height = TextEditingController();
  final _weight = TextEditingController();
  BloodType _bloodType = BloodType.unknown;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _emergency.dispose();
    _height.dispose();
    _weight.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final p = await ref.read(trainingApiProvider).getMyProfile();
      _name.text = p.fullName;
      _email.text = p.email;
      _phone.text = p.phone ?? '';
      _emergency.text = p.emergencyPhone ?? '';
      _height.text = p.heightCm?.toString() ?? '';
      _weight.text = p.weightKg?.toString() ?? '';
      _bloodType = p.bloodType;
      setState(() {
        _profile = p;
        _error = null;
      });
    } catch (e) {
      setState(() => _error = '$e');
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _save() async {
    if (_name.text.trim().isEmpty || _email.text.trim().isEmpty || _phone.text.trim().isEmpty) {
      _snack('Preencha nome, e-mail e telefone.');
      return;
    }
    if ((_profile?.isStudent ?? false) && _emergency.text.trim().isEmpty) {
      _snack('Telefone de emergência é obrigatório.');
      return;
    }
    setState(() => _saving = true);
    try {
      await ref.read(trainingApiProvider).updateMyProfile(
            fullName: _name.text.trim(),
            email: _email.text.trim(),
            phone: _phone.text.trim(),
            emergencyPhone: _emergency.text.trim().isEmpty ? null : _emergency.text.trim(),
            bloodType: _bloodType,
            heightCm: int.tryParse(_height.text.trim()),
            weightKg: double.tryParse(_weight.text.trim().replaceAll(',', '.')),
          );
      _snack('Perfil salvo.');
    } catch (e) {
      _snack('Falha ao salvar: $e');
    } finally {
      setState(() => _saving = false);
    }
  }

  Future<void> _changePhoto() async {
    try {
      final XFile? picked = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 90);
      if (picked == null) return;

      final CroppedFile? cropped = await ImageCropper().cropImage(
        sourcePath: picked.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        maxWidth: 512,
        maxHeight: 512,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 85,
        uiSettings: [
          AndroidUiSettings(toolbarTitle: 'Recortar foto', lockAspectRatio: true, hideBottomControls: false),
          IOSUiSettings(title: 'Recortar foto', aspectRatioLockEnabled: true),
        ],
      );
      if (cropped == null) return;

      final bytes = await cropped.readAsBytes();
      final url = await ref.read(trainingApiProvider).uploadMyPhoto(bytes, 'avatar.jpg', 'image/jpeg');
      setState(() => _profile = _profile == null ? null : _copyWithPhoto(url));
      _snack('Foto atualizada.');
    } catch (e) {
      _snack('Falha ao enviar foto: $e');
    }
  }

  Profile _copyWithPhoto(String url) => Profile(
        isStudent: _profile!.isStudent,
        fullName: _profile!.fullName,
        email: _profile!.email,
        phone: _profile!.phone,
        emergencyPhone: _profile!.emergencyPhone,
        bloodType: _profile!.bloodType,
        heightCm: _profile!.heightCm,
        weightKg: _profile!.weightKg,
        photoUrl: url,
        apportments: _profile!.apportments,
      );

  void _snack(String msg) {
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meu perfil')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Falha ao carregar: $_error'))
              : Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: Breakpoints.contentMaxWidth),
                    child: RefreshIndicator(
                  onRefresh: _load,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Center(child: _photo()),
                      const SizedBox(height: 8),
                      Center(
                        child: TextButton.icon(
                          icon: const Icon(Icons.photo_camera),
                          label: const Text('Alterar foto'),
                          onPressed: _changePhoto,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _field(_name, 'Nome *'),
                      _field(_email, 'E-mail *', keyboard: TextInputType.emailAddress),
                      _field(_phone, 'Telefone de contato *', keyboard: TextInputType.phone),
                      if (_profile?.isStudent ?? false)
                        _field(_emergency, 'Telefone de emergência *', keyboard: TextInputType.phone),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: DropdownButtonFormField<BloodType>(
                          initialValue: _bloodType,
                          decoration: const InputDecoration(labelText: 'Tipo sanguíneo'),
                          items: BloodType.values
                              .map((b) => DropdownMenuItem(value: b, child: Text(b.label)))
                              .toList(),
                          onChanged: (v) => setState(() => _bloodType = v ?? BloodType.unknown),
                        ),
                      ),
                      Row(children: [
                        Expanded(child: _field(_height, 'Altura (cm)', keyboard: TextInputType.number)),
                        const SizedBox(width: 12),
                        Expanded(child: _field(_weight, 'Peso (kg)', keyboard: TextInputType.number)),
                      ]),
                      const SizedBox(height: 12),
                      FilledButton.icon(
                        icon: const Icon(Icons.save),
                        label: Text(_saving ? 'Salvando...' : 'Salvar'),
                        onPressed: _saving ? null : _save,
                      ),
                      if (_profile?.isStudent ?? false) ...[
                        const Divider(height: 32),
                        _apportsSection(),
                      ],
                      if (_profile?.isStudent ?? false) ...[
                        const Divider(height: 32),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.forum_outlined),
                          title: const Text('Minhas perguntas'),
                          subtitle: const Text('Perguntas ao professor e respostas'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => context.go('/questions'),
                        ),
                      ],
                      const Divider(height: 32),
                      _appearanceSection(context),
                    ],
                  ),
                ),
                  ),
                ),
    );
  }

  Widget _appearanceSection(BuildContext context) {
    final mode = ref.watch(themeControllerProvider).mode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text('Aparência', style: Theme.of(context).textTheme.titleMedium),
        ),
        const SizedBox(height: 8),
        SegmentedButton<ThemeMode>(
          showSelectedIcon: false,
          segments: const [
            ButtonSegment(value: ThemeMode.system, label: Text('Sistema')),
            ButtonSegment(value: ThemeMode.light, label: Text('Claro')),
            ButtonSegment(value: ThemeMode.dark, label: Text('Escuro')),
          ],
          selected: {mode},
          onSelectionChanged: (s) => ref.read(themeControllerProvider).setMode(s.first),
        ),
      ],
    );
  }

  Widget _photo() {
    final url = _profile?.photoUrl;
    return CircleAvatar(
      radius: 48,
      backgroundImage: (url != null && url.isNotEmpty) ? CachedNetworkImageProvider(url) : null,
      child: (url == null || url.isEmpty) ? const Icon(Icons.person, size: 48) : null,
    );
  }

  Widget _field(TextEditingController c, String label, {TextInputType? keyboard}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: TextField(controller: c, keyboardType: keyboard, decoration: InputDecoration(labelText: label)),
      );

  Widget _apportsSection() {
    final apports = _profile?.apportments ?? const [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(children: [
          const Expanded(child: Text('Apontamentos de saúde', style: TextStyle(fontWeight: FontWeight.bold))),
          IconButton(icon: const Icon(Icons.add), onPressed: _addApportment),
        ]),
        if (apports.isEmpty)
          const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Sem apontamentos.'))
        else
          ...apports.map((a) => Card(
                child: ListTile(
                  leading: const Icon(Icons.health_and_safety),
                  title: Text('${a.bodyPartName}: ${a.problemTypeName}'),
                  subtitle: a.observation == null ? null : Text('Obs: ${a.observation}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => _removeApportment(a),
                  ),
                ),
              )),
      ],
    );
  }

  Future<void> _addApportment() async {
    final catalog = await ref.read(trainingApiProvider).listHealthCatalog();
    if (!mounted || catalog.isEmpty) {
      if (mounted) _snack('Catálogo de saúde vazio.');
      return;
    }

    final result = await showDialog<_ApportInput>(
      context: context,
      builder: (_) => _AddApportmentDialog(catalog: catalog),
    );
    if (result == null) return;

    try {
      await ref.read(trainingApiProvider).addMyApportment(result.bodyPartId, result.problemTypeId, result.observation);
      await _load();
    } catch (e) {
      _snack('Falha ao adicionar: $e');
    }
  }

  Future<void> _removeApportment(ProfileApportment a) async {
    try {
      await ref.read(trainingApiProvider).removeMyApportment(a.id);
      await _load();
    } catch (e) {
      _snack('Falha ao remover: $e');
    }
  }
}

class _ApportInput {
  _ApportInput(this.bodyPartId, this.problemTypeId, this.observation);
  final String bodyPartId;
  final String problemTypeId;
  final String? observation;
}

class _AddApportmentDialog extends StatefulWidget {
  const _AddApportmentDialog({required this.catalog});
  final List<CatalogBodyPart> catalog;

  @override
  State<_AddApportmentDialog> createState() => _AddApportmentDialogState();
}

class _AddApportmentDialogState extends State<_AddApportmentDialog> {
  CatalogBodyPart? _bodyPart;
  CatalogProblemType? _problemType;
  final _obs = TextEditingController();

  @override
  void dispose() {
    _obs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Novo apontamento'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<CatalogBodyPart>(
              initialValue: _bodyPart,
              decoration: const InputDecoration(labelText: 'Local do corpo'),
              items: widget.catalog.map((b) => DropdownMenuItem(value: b, child: Text(b.name))).toList(),
              onChanged: (v) => setState(() {
                _bodyPart = v;
                _problemType = null;
              }),
            ),
            DropdownButtonFormField<CatalogProblemType>(
              initialValue: _problemType,
              decoration: const InputDecoration(labelText: 'Tipo de problema'),
              items: (_bodyPart?.problemTypes ?? [])
                  .map((p) => DropdownMenuItem(value: p, child: Text(p.name)))
                  .toList(),
              onChanged: (v) => setState(() => _problemType = v),
            ),
            TextField(controller: _obs, decoration: const InputDecoration(labelText: 'Observação (opcional)'), maxLines: 3),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
        FilledButton(
          onPressed: () {
            if (_bodyPart == null || _problemType == null) return;
            Navigator.pop(context, _ApportInput(_bodyPart!.id, _problemType!.id,
                _obs.text.trim().isEmpty ? null : _obs.text.trim()));
          },
          child: const Text('Adicionar'),
        ),
      ],
    );
  }
}
