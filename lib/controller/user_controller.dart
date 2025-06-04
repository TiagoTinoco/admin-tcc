import 'package:admin_tcc/enums/user_kind_enum.dart';
import 'package:admin_tcc/models/user_model.dart';
import 'package:admin_tcc/services/user_service.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  final UserService _userService;

  UserController(this._userService);

  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  bool get isStudent => userModel!.userKind == UserKindEnum.student;
  bool get isManager => userModel!.userKind == UserKindEnum.manager;

  String get nameAndNickname {
    final name = _userModel?.name.trim();
    if (name == null || name.isEmpty) return '';

    final parts = name.split(' ');
    return parts.take(2).join(' ');
  }

  set userModel(UserModel? userModel) {
    _userModel = userModel;
    notifyListeners();
  }

  Future<void> updateRemedies(String remedies) async {
    _userModel?.remedies = remedies;

    await _userService.updateRemedies(
      userId: _userModel!.id,
      remedies: remedies,
    );

    notifyListeners();
  }

  Future<void> updateSoftAndHardSkill(String softAndHardSkill) async {
    _userModel?.softsAndHardSkills = softAndHardSkill;

    await _userService.updateSoftAndHardSkill(
      userId: _userModel!.id,
      softsAndHardSkills: softAndHardSkill,
    );

    notifyListeners();
  }

  void clearUserController() {
    _userModel = null;
    notifyListeners();
  }
}
