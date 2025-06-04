import 'package:admin_tcc/enums/gender_enum.dart';
import 'package:admin_tcc/models/user_model.dart';
import 'package:admin_tcc/services/user_service.dart';
import 'package:flutter/material.dart';

class SignUpController extends ChangeNotifier {
  final UserService _userService;

  SignUpController(this._userService);

  GenderEnum? choicedGender;

  void changeGender(GenderEnum gender) {
    choicedGender = gender;
  }

  Future<String?> createUser({required UserModel newUser}) async {
    return await _userService.signUp(newUser: newUser);
  }
}
