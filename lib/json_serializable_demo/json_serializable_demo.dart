import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json_serializable_demo.g.dart';

class JsonSerializableDemo extends StatefulWidget {
  @override
  _JsonSerializableDemoState createState() => _JsonSerializableDemoState();
}

class _JsonSerializableDemoState extends State<JsonSerializableDemo> {
  List<Map<String, dynamic>> list = [
    {
      'id': '123',
      'name': '123',
      'email': '123',
      'birth_day': DateTime.now().toIso8601String(),
    },
    {
      'id': '456',
      'name': '456',
      'email': '456',
      'birth_day': DateTime.now().toIso8601String(),
    },
    {
      'id': '789',
      'name': '789',
      'email': '789',
      'birth_day': DateTime.now().toIso8601String(),
    },
    {
      'id': '321',
      'name': '321',
      'email': '321',
      'birth_day': DateTime.now().toIso8601String(),
    },
  ];

  List<User> listUser = [];

  @override
  void initState() {
    super.initState();
    getListUser().then((list) {
      setState(() {
        listUser = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'JsonSerializableDemo',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: listUser
                .map(
                  (user) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildUser(user),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  Future<List<User>> getListUser() {
    return Future.delayed(Duration(seconds: 1), () {
      return list
          .map(
            (json) => User.fromJson(json),
          )
          .toList();
    });
  }

  Widget _buildUser(User user) {
    return GestureDetector(
      onTap: () {
        print('user bd: ${user.birthDay}');
      },
      child: Container(
        color: Colors.lightBlue,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'user: ${user.toJson()}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

@JsonSerializable()
class User {
  static DateTime _fromUtcToLocal(String date) =>
      date == null ? null : DateTime.parse(date).toLocal();

  static String _fromLocalToUtc(DateTime date) =>
      date == null ? null : date.toUtc().toIso8601String();

  final String id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(
    name: 'birth_day',
    fromJson: _fromUtcToLocal,
    toJson: _fromLocalToUtc,
  )
  final DateTime birthDay;

  User({
    this.id,
    this.name,
    this.email,
    this.birthDay,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
