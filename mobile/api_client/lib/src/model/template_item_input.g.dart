// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_item_input.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TemplateItemInput extends TemplateItemInput {
  @override
  final String exerciseId;
  @override
  final int order;
  @override
  final String? sectionLabel;
  @override
  final int sets;
  @override
  final int reps;
  @override
  final int restSeconds;
  @override
  final int? durationSeconds;
  @override
  final int? workSeconds;
  @override
  final int? intervalRestSeconds;
  @override
  final int? rounds;
  @override
  final String? creatorNotes;

  factory _$TemplateItemInput(
          [void Function(TemplateItemInputBuilder)? updates]) =>
      (TemplateItemInputBuilder()..update(updates))._build();

  _$TemplateItemInput._(
      {required this.exerciseId,
      required this.order,
      this.sectionLabel,
      required this.sets,
      required this.reps,
      required this.restSeconds,
      this.durationSeconds,
      this.workSeconds,
      this.intervalRestSeconds,
      this.rounds,
      this.creatorNotes})
      : super._();
  @override
  TemplateItemInput rebuild(void Function(TemplateItemInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TemplateItemInputBuilder toBuilder() =>
      TemplateItemInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TemplateItemInput &&
        exerciseId == other.exerciseId &&
        order == other.order &&
        sectionLabel == other.sectionLabel &&
        sets == other.sets &&
        reps == other.reps &&
        restSeconds == other.restSeconds &&
        durationSeconds == other.durationSeconds &&
        workSeconds == other.workSeconds &&
        intervalRestSeconds == other.intervalRestSeconds &&
        rounds == other.rounds &&
        creatorNotes == other.creatorNotes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, exerciseId.hashCode);
    _$hash = $jc(_$hash, order.hashCode);
    _$hash = $jc(_$hash, sectionLabel.hashCode);
    _$hash = $jc(_$hash, sets.hashCode);
    _$hash = $jc(_$hash, reps.hashCode);
    _$hash = $jc(_$hash, restSeconds.hashCode);
    _$hash = $jc(_$hash, durationSeconds.hashCode);
    _$hash = $jc(_$hash, workSeconds.hashCode);
    _$hash = $jc(_$hash, intervalRestSeconds.hashCode);
    _$hash = $jc(_$hash, rounds.hashCode);
    _$hash = $jc(_$hash, creatorNotes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TemplateItemInput')
          ..add('exerciseId', exerciseId)
          ..add('order', order)
          ..add('sectionLabel', sectionLabel)
          ..add('sets', sets)
          ..add('reps', reps)
          ..add('restSeconds', restSeconds)
          ..add('durationSeconds', durationSeconds)
          ..add('workSeconds', workSeconds)
          ..add('intervalRestSeconds', intervalRestSeconds)
          ..add('rounds', rounds)
          ..add('creatorNotes', creatorNotes))
        .toString();
  }
}

class TemplateItemInputBuilder
    implements Builder<TemplateItemInput, TemplateItemInputBuilder> {
  _$TemplateItemInput? _$v;

  String? _exerciseId;
  String? get exerciseId => _$this._exerciseId;
  set exerciseId(String? exerciseId) => _$this._exerciseId = exerciseId;

  int? _order;
  int? get order => _$this._order;
  set order(int? order) => _$this._order = order;

  String? _sectionLabel;
  String? get sectionLabel => _$this._sectionLabel;
  set sectionLabel(String? sectionLabel) => _$this._sectionLabel = sectionLabel;

  int? _sets;
  int? get sets => _$this._sets;
  set sets(int? sets) => _$this._sets = sets;

  int? _reps;
  int? get reps => _$this._reps;
  set reps(int? reps) => _$this._reps = reps;

  int? _restSeconds;
  int? get restSeconds => _$this._restSeconds;
  set restSeconds(int? restSeconds) => _$this._restSeconds = restSeconds;

  int? _durationSeconds;
  int? get durationSeconds => _$this._durationSeconds;
  set durationSeconds(int? durationSeconds) =>
      _$this._durationSeconds = durationSeconds;

  int? _workSeconds;
  int? get workSeconds => _$this._workSeconds;
  set workSeconds(int? workSeconds) => _$this._workSeconds = workSeconds;

  int? _intervalRestSeconds;
  int? get intervalRestSeconds => _$this._intervalRestSeconds;
  set intervalRestSeconds(int? intervalRestSeconds) =>
      _$this._intervalRestSeconds = intervalRestSeconds;

  int? _rounds;
  int? get rounds => _$this._rounds;
  set rounds(int? rounds) => _$this._rounds = rounds;

  String? _creatorNotes;
  String? get creatorNotes => _$this._creatorNotes;
  set creatorNotes(String? creatorNotes) => _$this._creatorNotes = creatorNotes;

  TemplateItemInputBuilder() {
    TemplateItemInput._defaults(this);
  }

  TemplateItemInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _exerciseId = $v.exerciseId;
      _order = $v.order;
      _sectionLabel = $v.sectionLabel;
      _sets = $v.sets;
      _reps = $v.reps;
      _restSeconds = $v.restSeconds;
      _durationSeconds = $v.durationSeconds;
      _workSeconds = $v.workSeconds;
      _intervalRestSeconds = $v.intervalRestSeconds;
      _rounds = $v.rounds;
      _creatorNotes = $v.creatorNotes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TemplateItemInput other) {
    _$v = other as _$TemplateItemInput;
  }

  @override
  void update(void Function(TemplateItemInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TemplateItemInput build() => _build();

  _$TemplateItemInput _build() {
    final _$result = _$v ??
        _$TemplateItemInput._(
          exerciseId: BuiltValueNullFieldError.checkNotNull(
              exerciseId, r'TemplateItemInput', 'exerciseId'),
          order: BuiltValueNullFieldError.checkNotNull(
              order, r'TemplateItemInput', 'order'),
          sectionLabel: sectionLabel,
          sets: BuiltValueNullFieldError.checkNotNull(
              sets, r'TemplateItemInput', 'sets'),
          reps: BuiltValueNullFieldError.checkNotNull(
              reps, r'TemplateItemInput', 'reps'),
          restSeconds: BuiltValueNullFieldError.checkNotNull(
              restSeconds, r'TemplateItemInput', 'restSeconds'),
          durationSeconds: durationSeconds,
          workSeconds: workSeconds,
          intervalRestSeconds: intervalRestSeconds,
          rounds: rounds,
          creatorNotes: creatorNotes,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
