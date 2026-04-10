// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practice_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PracticeSessionImpl _$$PracticeSessionImplFromJson(
        Map<String, dynamic> json) =>
    _$PracticeSessionImpl(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      instrument: $enumDecode(_$InstrumentEnumMap, json['instrument']),
      category: $enumDecode(_$PracticeCategoryEnumMap, json['category']),
      duration: Duration(microseconds: (json['duration'] as num).toInt()),
      notes: json['notes'] as String?,
      bpmGoal: (json['bpmGoal'] as num?)?.toInt(),
      bpmAchieved: (json['bpmAchieved'] as num?)?.toInt(),
      rating: (json['rating'] as num?)?.toInt() ?? 3,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$$PracticeSessionImplToJson(
        _$PracticeSessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'instrument': _$InstrumentEnumMap[instance.instrument]!,
      'category': _$PracticeCategoryEnumMap[instance.category]!,
      'duration': instance.duration.inMicroseconds,
      'notes': instance.notes,
      'bpmGoal': instance.bpmGoal,
      'bpmAchieved': instance.bpmAchieved,
      'rating': instance.rating,
      'tags': instance.tags,
    };

const _$InstrumentEnumMap = {
  Instrument.electricGuitar: 'electric_guitar',
  Instrument.acousticGuitar: 'acoustic_guitar',
  Instrument.bass: 'bass',
  Instrument.piano: 'piano',
  Instrument.drums: 'drums',
  Instrument.vocals: 'vocals',
  Instrument.other: 'other',
};

const _$PracticeCategoryEnumMap = {
  PracticeCategory.technique: 'technique',
  PracticeCategory.songs: 'songs',
  PracticeCategory.theory: 'theory',
  PracticeCategory.improvisation: 'improvisation',
  PracticeCategory.earTraining: 'ear_training',
  PracticeCategory.sightReading: 'sight_reading',
  PracticeCategory.recording: 'recording',
  PracticeCategory.jamming: 'jamming',
  PracticeCategory.warmup: 'warmup',
  PracticeCategory.other: 'other',
};
