// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Exercise extends Exercise {
  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? modalityId;
  @override
  final String? modalityName;
  @override
  final String? primaryMuscleGroupId;
  @override
  final BuiltList<String>? secondaryMuscleGroupIds;
  @override
  final String? usageExample;
  @override
  final int? defaultSets;
  @override
  final int? defaultReps;
  @override
  final int? defaultRestSeconds;
  @override
  final bool? isAerobic;
  @override
  final int? defaultWorkSeconds;
  @override
  final int? defaultIntervalRestSeconds;
  @override
  final int? defaultRounds;
  @override
  final BuiltList<ExerciseMedia>? media;

  factory _$Exercise([void Function(ExerciseBuilder)? updates]) =>
      (ExerciseBuilder()..update(updates))._build();

  _$Exercise._(
      {this.id,
      this.name,
      this.description,
      this.modalityId,
      this.modalityName,
      this.primaryMuscleGroupId,
      this.secondaryMuscleGroupIds,
      this.usageExample,
      this.defaultSets,
      this.defaultReps,
      this.defaultRestSeconds,
      this.isAerobic,
      this.defaultWorkSeconds,
      this.defaultIntervalRestSeconds,
      this.defaultRounds,
      this.media})
      : super._();
  @override
  Exercise rebuild(void Function(ExerciseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExerciseBuilder toBuilder() => ExerciseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Exercise &&
        id == other.id &&
        name == other.name &&
        description == other.description &&
        modalityId == other.modalityId &&
        modalityName == other.modalityName &&
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
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, modalityId.hashCode);
    _$hash = $jc(_$hash, modalityName.hashCode);
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
    return (newBuiltValueToStringHelper(r'Exercise')
          ..add('id', id)
          ..add('name', name)
          ..add('description', description)
          ..add('modalityId', modalityId)
          ..add('modalityName', modalityName)
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

class ExerciseBuilder implements Builder<Exercise, ExerciseBuilder> {
  _$Exercise? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _modalityId;
  String? get modalityId => _$this._modalityId;
  set modalityId(String? modalityId) => _$this._modalityId = modalityId;

  String? _modalityName;
  String? get modalityName => _$this._modalityName;
  set modalityName(String? modalityName) => _$this._modalityName = modalityName;

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

  ListBuilder<ExerciseMedia>? _media;
  ListBuilder<ExerciseMedia> get media =>
      _$this._media ??= ListBuilder<ExerciseMedia>();
  set media(ListBuilder<ExerciseMedia>? media) => _$this._media = media;

  ExerciseBuilder() {
    Exercise._defaults(this);
  }

  ExerciseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _description = $v.description;
      _modalityId = $v.modalityId;
      _modalityName = $v.modalityName;
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
  void replace(Exercise other) {
    _$v = other as _$Exercise;
  }

  @override
  void update(void Function(ExerciseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Exercise build() => _build();

  _$Exercise _build() {
    _$Exercise _$result;
    try {
      _$result = _$v ??
          _$Exercise._(
            id: id,
            name: name,
            description: description,
            modalityId: modalityId,
            modalityName: modalityName,
            primaryMuscleGroupId: primaryMuscleGroupId,
            secondaryMuscleGroupIds: _secondaryMuscleGroupIds?.build(),
            usageExample: usageExample,
            defaultSets: defaultSets,
            defaultReps: defaultReps,
            defaultRestSeconds: defaultRestSeconds,
            isAerobic: isAerobic,
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
            r'Exercise', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
