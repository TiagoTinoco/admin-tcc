import 'package:admin_tcc/app_routes.dart';
import 'package:admin_tcc/components/alert_button.dart';
import 'package:admin_tcc/config/custom_colors.dart';
import 'package:admin_tcc/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfoWidget extends StatefulWidget {
  const UserInfoWidget({
    super.key,
    required this.areaColor,
  });

  final Color areaColor;

  @override
  State<UserInfoWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  @override
  Widget build(BuildContext context) {
    final userController = context.watch<UserController>();

    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: widget.areaColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(22),
            bottomRight: Radius.circular(22),
          ),
        ),
        child: SafeArea(
          top: true,
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/profile.png',
                        width: 240,
                        height: 240,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      userController.userModel!.name,
                      style: TextStyle(
                        color: CustomColors.neutral,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Empresa:',
                          style: TextStyle(
                            color: CustomColors.neutral,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Person Jackson',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.neutral,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              if (userController.isStudent && !userController.userModel!.isFinishSignUp!) ...[
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: CustomColors.black.withOpacity(0.2),
                      blurRadius: 16,
                      spreadRadius: 10,
                    ),
                  ]),
                  child: AlertButton(
                    icon: Icons.arrow_forward_ios_rounded,
                    message: 'Complete o seu formulário, clicando aqui!',
                    messageColor: Colors.white,
                    backgroundColor: CustomColors.orange,
                    onPress: () {
                      final hasRemedies = userController.userModel?.remedies;

                      if (hasRemedies != null && hasRemedies.isEmpty) {
                        Navigator.of(context).pushNamed(AppRoutes.remediesForm);
                      } else {
                        Navigator.of(context).pushNamed(AppRoutes.softAndHardSkill);
                      }
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
