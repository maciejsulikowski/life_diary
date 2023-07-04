// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WeatherModel _$$_WeatherModelFromJson(Map<String, dynamic> json) =>
    _$_WeatherModel(
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      current:
          CurrentCondition.fromJson(json['current'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_WeatherModelToJson(_$_WeatherModel instance) =>
    <String, dynamic>{
      'location': instance.location,
      'current': instance.current,
    };

_$_Location _$$_LocationFromJson(Map<String, dynamic> json) => _$_Location(
      name: json['name'] as String,
      region: json['region'] as String,
      country: json['country'] as String,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      tz_id: json['tz_id'] as String,
      localtime_epoch: json['localtime_epoch'] as int,
      localtime: json['localtime'] as String,
    );

Map<String, dynamic> _$$_LocationToJson(_$_Location instance) =>
    <String, dynamic>{
      'name': instance.name,
      'region': instance.region,
      'country': instance.country,
      'lat': instance.lat,
      'lon': instance.lon,
      'tz_id': instance.tz_id,
      'localtime_epoch': instance.localtime_epoch,
      'localtime': instance.localtime,
    };

_$_CurrentCondition _$$_CurrentConditionFromJson(Map<String, dynamic> json) =>
    _$_CurrentCondition(
      last_updated_epoch: json['last_updated_epoch'] as int,
      last_updated: json['last_updated'] as String,
      temp_c: (json['temp_c'] as num).toDouble(),
      temp_f: (json['temp_f'] as num).toDouble(),
      is_day: json['is_day'] as int,
      condition:
          WeatherCondition.fromJson(json['condition'] as Map<String, dynamic>),
      wind_mph: (json['wind_mph'] as num).toDouble(),
      wind_kph: (json['wind_kph'] as num).toDouble(),
      wind_degree: json['wind_degree'] as int,
      wind_dir: json['wind_dir'] as String,
      pressure_mb: (json['pressure_mb'] as num).toDouble(),
      pressure_in: (json['pressure_in'] as num).toDouble(),
      precip_mm: (json['precip_mm'] as num).toDouble(),
      precip_in: (json['precip_in'] as num).toDouble(),
      humidity: json['humidity'] as int,
      cloud: json['cloud'] as int,
      feelslike_c: (json['feelslike_c'] as num).toDouble(),
      feelslike_f: (json['feelslike_f'] as num).toDouble(),
      vis_km: (json['vis_km'] as num).toDouble(),
      vis_miles: (json['vis_miles'] as num).toDouble(),
      uv: (json['uv'] as num).toDouble(),
      gust_mph: (json['gust_mph'] as num).toDouble(),
      gust_kph: (json['gust_kph'] as num).toDouble(),
    );

Map<String, dynamic> _$$_CurrentConditionToJson(_$_CurrentCondition instance) =>
    <String, dynamic>{
      'last_updated_epoch': instance.last_updated_epoch,
      'last_updated': instance.last_updated,
      'temp_c': instance.temp_c,
      'temp_f': instance.temp_f,
      'is_day': instance.is_day,
      'condition': instance.condition,
      'wind_mph': instance.wind_mph,
      'wind_kph': instance.wind_kph,
      'wind_degree': instance.wind_degree,
      'wind_dir': instance.wind_dir,
      'pressure_mb': instance.pressure_mb,
      'pressure_in': instance.pressure_in,
      'precip_mm': instance.precip_mm,
      'precip_in': instance.precip_in,
      'humidity': instance.humidity,
      'cloud': instance.cloud,
      'feelslike_c': instance.feelslike_c,
      'feelslike_f': instance.feelslike_f,
      'vis_km': instance.vis_km,
      'vis_miles': instance.vis_miles,
      'uv': instance.uv,
      'gust_mph': instance.gust_mph,
      'gust_kph': instance.gust_kph,
    };

_$_WeatherCondition _$$_WeatherConditionFromJson(Map<String, dynamic> json) =>
    _$_WeatherCondition(
      text: json['text'] as String,
      icon: json['icon'] as String,
      code: json['code'] as int,
    );

Map<String, dynamic> _$$_WeatherConditionToJson(_$_WeatherCondition instance) =>
    <String, dynamic>{
      'text': instance.text,
      'icon': instance.icon,
      'code': instance.code,
    };
