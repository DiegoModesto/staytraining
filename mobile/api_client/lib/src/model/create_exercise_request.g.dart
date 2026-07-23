// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_exercise_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateExerciseRequest extends CreateExerciseRequest {
  @override
  final String name;
  @override
  final String? description;
  @override
  final String modalityId;
  @override
  final String primaryMuscleGroupId;
  @override
  final BuiltList<String>? secondaryMuscleGroupIds;
  @override
  final String? usageExample;
  @override
  final int defaultSets;
  @override
  final int defaultReps;
  @override
  final int defaultRestSeconds;
  @override
  final bool isAerobic;
  @override
  final int? defaultWorkSeconds;
  @override
  final int? defaultIntervalRestSeconds;
  @override
  final int? defaultRounds;
  @override
  final BuiltList<ExerciseMediaInput>? media;

  factory _$CreateExerciseRequest(
          [void Function(CreateExerciseRequestBuilder)? updates]) =>
      (CreateExerciseRequestBuilder()..update(updates))._build();

  _$CreateExerciseRequest._(
      {required this.name,
      this.description,
      required this.modalityId,
      required this.primaryMuscleGroupId,
      this.secondaryMuscleGroupIds,
      this.usageExample,
      required this.defaultSets,
      required this.defaultReps,
      required this.defaultRestSeconds,
      required this.isAerobic,
      this.defaultWorkSeconds,
      this.defaultIntervalRestSeconds,
      this.defaultRounds,
      this.media})
      : super._();
  @override
  CreateExerciseRequest rebuild(
          void Function(CreateExerciseRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateExerciseRequestBuilder toBuilder() =>
      CreateExerciseRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateExerciseRequest &&
        name == other.name &&
        description == other.description &&
        modalityId == other.modalityId &&
        primaryMuscleGroupId == other.primaryMuscleGroupId &&
        secondaryMuscleGroupIds == other.secondaryMuscleGroupIds &&
        usageExample == other.usageExample &&
        defaultSets == other.defaultSets &&
        defaultReps == other.defaultReps &&
        defaultRestSeconds == other.defaultRestSeconds &&
        isAerobic == other.isAerobic &&
        defaultWorkSeconds == other.defaultWorkSeconds &&
        defaultIntervalRestSeconds == other.defaultIntervalRestSeconds &&
        defaultRounds == other.defaultRounds &&
        media == other.media;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, modalityId.hashCode);
    _$hash = $jc(_$hash, primaryMuscleGroupId.hashCode);
    _$hash = $jc(_$hash, secondaryMuscleGroupIds.hashCode);
    _$hash = $jc(_$hash, usageExample.hashCode);
    _$hash = $jc(_$hash, defaultSets.hashCode);
    _$hash = $jc(_$hash, defaultReps.hashCode);
    _$hash = $jc(_$hash, defaultRestSeconds.hashCode);
    _$hash = $jc(_$hash, isAerobic.hashCode);
    _$hash = $jc(_$hash, defaultWorkSeconds.hashCode);
    _$hash = $jc(_$hash, defaultIntervalRestSeconds.hashCode);
    _$hash = $jc(_$hash, defaultRounds.hashCode);
    _$hash = $jc(_$hash, media.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateExerciseRequest')
          ..add('name', name)
          ..add('description', description)
          ..add('modalityId', modalityId)
          ..add('primaryMuscleGroupId', primaryMuscleGroupId)
          ..add('secondaryMuscleGroupIds', secondaryMuscleGroupIds)
          ..add('usageExample', usageExample)
          ..add('defaultSets', defaultSets)
          ..add('defaultReps', defaultReps)
          ..add('defaultRestSeconds', defaultRestSeconds)
          ..add('isAerobic', isAerobic)
          ..add('defaultWorkSeconds', defaultWorkSeconds)
          ..add('defaultIntervalRestSeconds', defaultIntervalRestSeconds)
          ..add('defaultRounds', defaultRounds)
          ..add('media', media))
        .toString();
  }
}

class CreateExerciseRequestBuilder
    implements Builder<CreateExerciseRequest, CreateExerciseRequestBuilder> {
  _$CreateExerciseRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _modalityId;
  String? get modalityId => _$this._modalityId;
  set modalityId(String? modalityId) => _$this._modalityId = modalityId;

  String? _primaryMuscleGroupId;
  String? get primaryMuscleGroupId => _$this._primaryMuscleGroupId;
  set primaryMuscleGroupId(String? primaryMuscleGroupId) =>
      _$this._primaryMuscleGroupId = primaryMuscleGroupId;

  ListBuilder<String>? _secondaryMuscleGroupIds;
  ListBuilder<String> get secondaryMuscleGroupIds =>
      _$this._secondaryMuscleGroupIds ??= ListBuilder<String>();
  set secondaryMuscleGroupIds(ListBuilder<String>? secondaryMuscleGroupIds) =>
      _$this._secondaryMuscleGroupIds = secondaryMuscleGroupIds;

  String? _usageExample;
  String? get usageExample => _$this._usageExample;
  set usageExample(String? usageExample) => _$this._usageExample = usageExample;

  int? _defaultSets;
  int? get defaultSets => _$this._defaultSets;
  set defaultSets(int? defaultSets) => _$this._defaultSets = defaultSets;

  int? _defaultReps;
  int? get defaultReps => _$this._defaultReps;
  set defaultReps(int? defaultReps) => _$this._defaultReps = defaultReps;

  int? _defaultRestSeconds;
  int? get defaultRestSeconds => _$this._defaultRestSeconds;
  set defaultRestSeconds(int? defaultRestSeconds) =>
      _$this._defaultRestSeconds = defaultRestSeconds;

  bool? _isAerobic;
  bool? get isAerobic => _$this._isAerobic;
  set isAerobic(bool? isAerobic) => _$this._isAerobic = isAerobic;

  int? _defaultWorkSeconds;
  int? get defaultWorkSeconds => _$this._defaultWorkSeconds;
  set defaultWorkSeconds(int? defaultWorkSeconds) =>
      _$this._defaultWorkSeconds = defaultWorkSeconds;

  int? _defaultIntervalRestSeconds;
  int? get defaultIntervalRestSeconds => _$this._defaultIntervalRestSeconds;
  set defaultIntervalRestSeconds(int? defaultIntervalRestSeconds) =>
      _$this._defaultIntervalRestSeconds = defaultIntervalRestSeconds;

  int? _defaultRounds;
  int? get defaultRounds => _$this._defaultRounds;
  set defaultRounds(int? defaultRounds) =>
      _$this._defaultRounds = defaultRounds;

  ListBuilder<ExerciseMediaInput>? _media;
  ListBuilder<ExerciseMediaInput> get media =>
      _$this._media ??= ListBuilder<ExerciseMediaInput>();
  set media(ListBuilder<ExerciseMediaInput>? media) => _$this._media = media;

  CreateExerciseRequestBuilder() {
    CreateExerciseRequest._defaults(this);
  }

  CreateExerciseRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _description = $v.description;
      _modalityId = $v.modalityId;
      _primaryMuscleGroupId = $v.primaryMuscleGroupId;
      _secondaryMuscleGroupIds = $v.secondaryMuscleGroupIds?.toBuilder();
      _usageExample = $v.usageExample;
      _defaultSets = $v.defaultSets;
      _defaultReps = $v.defaultReps;
      _defaultRestSeconds = $v.defaultRestSeconds;
      _isAerobic = $v.isAerobic;
      _defaultWorkSeconds = $v.defaultWorkSeconds;
      _defaultIntervalRestSeconds = $v.defaultIntervalRestSeconds;
      _defaultRounds = $v.defaultRounds;
      _media = $v.media?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateExerciseRequest other) {
    _$v = other as _$CreateExerciseRequest;
  }

  @override
  void update(void Function(CreateExerciseRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateExerciseRequest build() => _build();

  _$CreateExerciseRequest _build() {
    _$CreateExerciseRequest _$result;
    try {
      _$result = _$v ??
          _$CreateExerciseRequest._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'CreateExerciseRequest', 'name'),
            description: description,
            modalityId: BuiltValueNullFieldError.checkNotNull(
                modalityId, r'CreateExerciseRequest', 'modalityId'),
            primaryMuscleGroupId: BuiltValueNullFieldError.checkNotNull(
                primaryMuscleGroupId,
                r'CreateExerciseRequest',
                'primaryMuscleGroupId'),
            secondaryMuscleGroupIds: _secondaryMuscleGroupIds?.build(),
            usageExample: usageExample,
            defaultSets: BuiltValueNullFieldError.checkNotNull(
                defaultSets, r'CreateExerciseRequest', 'defaultSets'),
            defaultReps: BuiltValueNullFieldError.checkNotNull(
                defaultReps, r'CreateExerciseRequest', 'defaultReps'),
            defaultRestSeconds: BuiltValueNullFieldError.checkNotNull(
                defaultRestSeconds,
                r'CreateExerciseRequest',
                'defaultRestSeconds'),
            isAerobic: BuiltValueNullFieldError.checkNotNull(
                isAerobic, r'CreateExerciseRequest', 'isAerobic'),
            defaultWorkSeconds: defaultWorkSeconds,
            defaultIntervalRestSeconds: defaultIntervalRestSeconds,
            defaultRounds: defaultRounds,
            media: _media?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'secondaryMuscleGroupIds';
        _secondaryMuscleGroupIds?.build();

        _$failedField = 'media';
        _media?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CreateExerciseRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
