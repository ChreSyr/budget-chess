// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PreferencesStateImpl _$$PreferencesStateImplFromJson(
        Map<String, dynamic> json) =>
    _$PreferencesStateImpl(
      brightness: $enumDecode(_$BrightnessEnumMap, json['brightness']),
      languageCode: json['languageCode'] as String,
      seedColor: $enumDecode(_$SeedColorEnumMap, json['seedColor']),
    );

Map<String, dynamic> _$$PreferencesStateImplToJson(
        _$PreferencesStateImpl instance) =>
    <String, dynamic>{
      'brightness': _$BrightnessEnumMap[instance.brightness]!,
      'languageCode': instance.languageCode,
      'seedColor': _$SeedColorEnumMap[instance.seedColor]!,
    };

const _$BrightnessEnumMap = {
  Brightness.dark: 'dark',
  Brightness.light: 'light',
};

const _$SeedColorEnumMap = {
  SeedColor.lightgreen: 'lightgreen',
  SeedColor.green: 'green',
  SeedColor.blue: 'blue',
  SeedColor.pink: 'pink',
  SeedColor.yellow: 'yellow',
  SeedColor.orange: 'orange',
};
