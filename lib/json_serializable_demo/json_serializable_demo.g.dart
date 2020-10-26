// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_serializable_demo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    birthDay: User._fromUtcToLocal(json['birth_day'] as String),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'birth_day': User._fromLocalToUtc(instance.birthDay),
    };
