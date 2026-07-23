// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reorder_workout_items_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReorderWorkoutItemsRequest extends ReorderWorkoutItemsRequest {
  @override
  final BuiltList<String> orderedItemIds;

  factory _$ReorderWorkoutItemsRequest(
          [void Function(ReorderWorkoutItemsRequestBuilder)? updates]) =>
      (ReorderWorkoutItemsRequestBuilder()..update(updates))._build();

  _$ReorderWorkoutItemsRequest._({required this.orderedItemIds}) : super._();
  @override
  ReorderWorkoutItemsRequest rebuild(
          void Function(ReorderWorkoutItemsRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReorderWorkoutItemsRequestBuilder toBuilder() =>
      ReorderWorkoutItemsRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReorderWorkoutItemsRequest &&
        orderedItemIds == other.orderedItemIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, orderedItemIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReorderWorkoutItemsRequest')
          ..add('orderedItemIds', orderedItemIds))
        .toString();
  }
}

class ReorderWorkoutItemsRequestBuilder
    implements
        Builder<ReorderWorkoutItemsRequest, ReorderWorkoutItemsRequestBuilder> {
  _$ReorderWorkoutItemsRequest? _$v;

  ListBuilder<String>? _orderedItemIds;
  ListBuilder<String> get orderedItemIds =>
      _$this._orderedItemIds ??= ListBuilder<String>();
  set orderedItemIds(ListBuilder<String>? orderedItemIds) =>
      _$this._orderedItemIds = orderedItemIds;

  ReorderWorkoutItemsRequestBuilder() {
    ReorderWorkoutItemsRequest._defaults(this);
  }

  ReorderWorkoutItemsRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _orderedItemIds = $v.orderedItemIds.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReorderWorkoutItemsRequest other) {
    _$v = other as _$ReorderWorkoutItemsRequest;
  }

  @override
  void update(void Function(ReorderWorkoutItemsRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReorderWorkoutItemsRequest build() => _build();

  _$ReorderWorkoutItemsRequest _build() {
    _$ReorderWorkoutItemsRequest _$result;
    try {
      _$result = _$v ??
          _$ReorderWorkoutItemsRequest._(
            orderedItemIds: orderedItemIds.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'orderedItemIds';
        orderedItemIds.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ReorderWorkoutItemsRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
