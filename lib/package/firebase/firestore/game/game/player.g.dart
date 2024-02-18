// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerAnalysisImpl _$$PlayerAnalysisImplFromJson(Map<String, dynamic> json) =>
    _$PlayerAnalysisImpl(
      inaccuracies: json['inaccuracies'] as int,
      mistakes: json['mistakes'] as int,
      blunders: json['blunders'] as int,
      acpl: json['acpl'] as int?,
      accuracy: json['accuracy'] as int?,
    );

Map<String, dynamic> _$$PlayerAnalysisImplToJson(
        _$PlayerAnalysisImpl instance) =>
    <String, dynamic>{
      'inaccuracies': instance.inaccuracies,
      'mistakes': instance.mistakes,
      'blunders': instance.blunders,
      'acpl': instance.acpl,
      'accuracy': instance.accuracy,
    };

_$PlayerImpl _$$PlayerImplFromJson(Map<String, dynamic> json) => _$PlayerImpl(
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      aiLevel: json['aiLevel'] as int?,
      rating: json['rating'] as int?,
      ratingDiff: json['ratingDiff'] as int?,
      provisional: json['provisional'] as bool?,
      onGame: json['onGame'] as bool?,
      isGone: json['isGone'] as bool?,
      offeringDraw: json['offeringDraw'] as bool?,
      offeringRematch: json['offeringRematch'] as bool?,
      proposingTakeback: json['proposingTakeback'] as bool?,
      analysis: json['analysis'] == null
          ? null
          : PlayerAnalysis.fromJson(json['analysis'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PlayerImplToJson(_$PlayerImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'aiLevel': instance.aiLevel,
      'rating': instance.rating,
      'ratingDiff': instance.ratingDiff,
      'provisional': instance.provisional,
      'onGame': instance.onGame,
      'isGone': instance.isGone,
      'offeringDraw': instance.offeringDraw,
      'offeringRematch': instance.offeringRematch,
      'proposingTakeback': instance.proposingTakeback,
      'analysis': instance.analysis,
    };
