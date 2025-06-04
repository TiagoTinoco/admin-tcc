import 'package:admin_tcc/enums/sign_in_enum.dart';
import 'package:admin_tcc/models/user_model.dart';
import 'package:admin_tcc/services/user_service.dart';
import 'package:flutter/material.dart';

class SignInController extends ChangeNotifier {
  final UserService _userService;

  SignInController(this._userService);

  SignInEnum signInStep = SignInEnum.email;
  bool isVisiblePassword = false;

  void changeScreen(SignInEnum screen) {
    signInStep = screen;
    notifyListeners();
  }

  void changeIsVisiblePassword() {
    isVisiblePassword = !isVisiblePassword;
    notifyListeners();
  }

  Future<UserModel?> signIn({required String email, required String password}) async {
    return await _userService.signIn(email: email, password: password);
  }
}
