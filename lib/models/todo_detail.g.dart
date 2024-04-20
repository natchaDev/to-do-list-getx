// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoDetail _$TodoDetailFromJson(Map<String, dynamic> json) => TodoDetail(
      json['id'] as String,
      json['title'] as String,
      DateTime.parse(json['date'] as String),
      json['status'] as String,
      json['description'] as String?,
      json['image'] as String?,
    );

Map<String, dynamic> _$TodoDetailToJson(TodoDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': instance.date.toIso8601String(),
      'status': instance.status,
      'description': instance.description,
      'image': instance.image,
    };
