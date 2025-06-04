import 'dart:convert';
import 'package:admin_tcc/config/constants.dart';
import 'package:admin_tcc/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<List<UserModel>> _getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(AppConstants.userUrl);

    if (jsonString == null) return [];

    final List<dynamic> decoded = json.decode(jsonString);
    return decoded.map((e) => UserModel.fromJson(e)).toList();
  }

  Future<void> _saveUsers(List<UserModel> users) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(users.map((user) => user.toJson()).toList());
    await prefs.setString(AppConstants.userUrl, jsonString);
  }

  Future<void> _addUser(UserModel user) async {
    final users = await _getUsers();
    final updatedUsers = [...users, user];
    await _saveUsers(updatedUsers);
  }

  Future<bool> userExist({required String email}) async {
    final users = await _getUsers();
    return users.any((user) => user.email == email);
  }

  Future<UserModel?> signIn({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final users = await _getUsers();

    final userVerified = users.where((user) => user.email == email && user.password == password);

    if (userVerified.isEmpty) return null;

    return userVerified.first;
  }

  Future<String?> signUp({required UserModel newUser}) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    try {
      if (!await userExist(email: newUser.email)) {
        await _addUser(newUser);
        return null;
      } else {
        return 'Já existe um usuário com este e-mail.';
      }
    } catch (e) {
      return 'Erro ao criar o usuário. Tente novamente mais tarde.';
    }
  }

  Future<void> deleteUser(int id) async {
    final users = await _getUsers();
    final updated = users.where((u) => u.id != id).toList();
    await _saveUsers(updated);
  }

  Future<void> updateRemedies({
    required int userId,
    required String? remedies,
  }) async {
    final users = await _getUsers();
    final index = users.indexWhere((user) => user.id == userId);

    if (index == -1) return;

    final updatedUser = users[index].copyWith(
      remedies: remedies ?? users[index].remedies,
    );

    users[index] = updatedUser;

    await _saveUsers(users);
  }

  Future<void> updateSoftAndHardSkill({
    required int userId,
    required String? softsAndHardSkills,
  }) async {
    final users = await _getUsers();
    final index = users.indexWhere((user) => user.id == userId);

    if (index == -1) return;

    final updatedUser = users[index].copyWith(
      softsAndHardSkills: softsAndHardSkills ?? users[index].softsAndHardSkills,
      isFinishSignUp: true,
    );

    users[index] = updatedUser;

    await _saveUsers(users);
  }
}
