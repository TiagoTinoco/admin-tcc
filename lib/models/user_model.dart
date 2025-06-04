import 'dart:math';

import 'package:admin_tcc/enums/gender_enum.dart';
import 'package:admin_tcc/enums/user_kind_enum.dart';

class UserModel {
  UserModel({
    int? id,
    required this.name,
    required this.email,
    required this.password,
    required this.userKind,
    required this.gender,
    this.isFinishSignUp,
    this.remedies,
    this.softsAndHardSkills,
    this.familyContacts,
  }) : id = id ?? _generateRandomId();

  final int id;
  final String name;
  final String email;
  final String password;
  final bool? isFinishSignUp;
  final List<int>? familyContacts;
  final UserKindEnum userKind;
  final GenderEnum gender;
  String? remedies;
  String? softsAndHardSkills;

  static int _generateRandomId() {
    return Random().nextInt(100) + 1000;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      userKind: UserKindEnum.values.firstWhere((e) => e.name == json['userKind']),
      gender: GenderEnum.values.firstWhere((e) => e.name == json['gender']),
      isFinishSignUp: json['isFinishSignUp'] ?? false,
      remedies: json['remedies'] ?? '',
      softsAndHardSkills: json['softsAndHardSkills'] ?? '',
      familyContacts: (json['familyContacts'] as List?)?.map((e) => int.tryParse(e.toString()) ?? 0).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'userKind': userKind.name,
        'gender': gender.name,
        'isFinishSignUp': isFinishSignUp,
        'remedies': remedies,
        'softsAndHardSkills': softsAndHardSkills,
        'familyContacts': familyContacts,
      };

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    bool? isFinishSignUp,
    String? remedies,
    String? softsAndHardSkills,
    List<int>? familyContacts,
    UserKindEnum? userKind,
    GenderEnum? gender,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      userKind: userKind ?? this.userKind,
      gender: gender ?? this.gender,
      isFinishSignUp: isFinishSignUp ?? this.isFinishSignUp,
      remedies: remedies ?? this.remedies,
      softsAndHardSkills: softsAndHardSkills ?? this.softsAndHardSkills,
      familyContacts: familyContacts ?? this.familyContacts,
    );
  }
}
