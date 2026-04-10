// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'practice_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PracticeSession _$PracticeSessionFromJson(Map<String, dynamic> json) {
  return _PracticeSession.fromJson(json);
}

/// @nodoc
mixin _$PracticeSession {
  String get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  Instrument get instrument => throw _privateConstructorUsedError;
  PracticeCategory get category => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  int? get bpmGoal => throw _privateConstructorUsedError;
  int? get bpmAchieved => throw _privateConstructorUsedError;
  int get rating => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;

  /// Serializes this PracticeSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PracticeSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PracticeSessionCopyWith<PracticeSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PracticeSessionCopyWith<$Res> {
  factory $PracticeSessionCopyWith(
          PracticeSession value, $Res Function(PracticeSession) then) =
      _$PracticeSessionCopyWithImpl<$Res, PracticeSession>;
  @useResult
  $Res call(
      {String id,
      DateTime date,
      Instrument instrument,
      PracticeCategory category,
      Duration duration,
      String? notes,
      int? bpmGoal,
      int? bpmAchieved,
      int rating,
      List<String> tags});
}

/// @nodoc
class _$PracticeSessionCopyWithImpl<$Res, $Val extends PracticeSession>
    implements $PracticeSessionCopyWith<$Res> {
  _$PracticeSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PracticeSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? instrument = null,
    Object? category = null,
    Object? duration = null,
    Object? notes = freezed,
    Object? bpmGoal = freezed,
    Object? bpmAchieved = freezed,
    Object? rating = null,
    Object? tags = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      instrument: null == instrument
          ? _value.instrument
          : instrument // ignore: cast_nullable_to_non_nullable
              as Instrument,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as PracticeCategory,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      bpmGoal: freezed == bpmGoal
          ? _value.bpmGoal
          : bpmGoal // ignore: cast_nullable_to_non_nullable
              as int?,
      bpmAchieved: freezed == bpmAchieved
          ? _value.bpmAchieved
          : bpmAchieved // ignore: cast_nullable_to_non_nullable
              as int?,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PracticeSessionImplCopyWith<$Res>
    implements $PracticeSessionCopyWith<$Res> {
  factory _$$PracticeSessionImplCopyWith(_$PracticeSessionImpl value,
          $Res Function(_$PracticeSessionImpl) then) =
      __$$PracticeSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime date,
      Instrument instrument,
      PracticeCategory category,
      Duration duration,
      String? notes,
      int? bpmGoal,
      int? bpmAchieved,
      int rating,
      List<String> tags});
}

/// @nodoc
class __$$PracticeSessionImplCopyWithImpl<$Res>
    extends _$PracticeSessionCopyWithImpl<$Res, _$PracticeSessionImpl>
    implements _$$PracticeSessionImplCopyWith<$Res> {
  __$$PracticeSessionImplCopyWithImpl(
      _$PracticeSessionImpl _value, $Res Function(_$PracticeSessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of PracticeSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? instrument = null,
    Object? category = null,
    Object? duration = null,
    Object? notes = freezed,
    Object? bpmGoal = freezed,
    Object? bpmAchieved = freezed,
    Object? rating = null,
    Object? tags = null,
  }) {
    return _then(_$PracticeSessionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      instrument: null == instrument
          ? _value.instrument
          : instrument // ignore: cast_nullable_to_non_nullable
              as Instrument,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as PracticeCategory,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      bpmGoal: freezed == bpmGoal
          ? _value.bpmGoal
          : bpmGoal // ignore: cast_nullable_to_non_nullable
              as int?,
      bpmAchieved: freezed == bpmAchieved
          ? _value.bpmAchieved
          : bpmAchieved // ignore: cast_nullable_to_non_nullable
              as int?,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PracticeSessionImpl implements _PracticeSession {
  const _$PracticeSessionImpl(
      {required this.id,
      required this.date,
      required this.instrument,
      required this.category,
      required this.duration,
      this.notes,
      this.bpmGoal,
      this.bpmAchieved,
      this.rating = 3,
      final List<String> tags = const []})
      : _tags = tags;

  factory _$PracticeSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PracticeSessionImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime date;
  @override
  final Instrument instrument;
  @override
  final PracticeCategory category;
  @override
  final Duration duration;
  @override
  final String? notes;
  @override
  final int? bpmGoal;
  @override
  final int? bpmAchieved;
  @override
  @JsonKey()
  final int rating;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'PracticeSession(id: $id, date: $date, instrument: $instrument, category: $category, duration: $duration, notes: $notes, bpmGoal: $bpmGoal, bpmAchieved: $bpmAchieved, rating: $rating, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PracticeSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.instrument, instrument) ||
                other.instrument == instrument) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.bpmGoal, bpmGoal) || other.bpmGoal == bpmGoal) &&
            (identical(other.bpmAchieved, bpmAchieved) ||
                other.bpmAchieved == bpmAchieved) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      date,
      instrument,
      category,
      duration,
      notes,
      bpmGoal,
      bpmAchieved,
      rating,
      const DeepCollectionEquality().hash(_tags));

  /// Create a copy of PracticeSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PracticeSessionImplCopyWith<_$PracticeSessionImpl> get copyWith =>
      __$$PracticeSessionImplCopyWithImpl<_$PracticeSessionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PracticeSessionImplToJson(
      this,
    );
  }
}

abstract class _PracticeSession implements PracticeSession {
  const factory _PracticeSession(
      {required final String id,
      required final DateTime date,
      required final Instrument instrument,
      required final PracticeCategory category,
      required final Duration duration,
      final String? notes,
      final int? bpmGoal,
      final int? bpmAchieved,
      final int rating,
      final List<String> tags}) = _$PracticeSessionImpl;

  factory _PracticeSession.fromJson(Map<String, dynamic> json) =
      _$PracticeSessionImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get date;
  @override
  Instrument get instrument;
  @override
  PracticeCategory get category;
  @override
  Duration get duration;
  @override
  String? get notes;
  @override
  int? get bpmGoal;
  @override
  int? get bpmAchieved;
  @override
  int get rating;
  @override
  List<String> get tags;

  /// Create a copy of PracticeSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PracticeSessionImplCopyWith<_$PracticeSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
