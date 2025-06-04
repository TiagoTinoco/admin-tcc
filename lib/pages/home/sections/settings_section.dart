import 'package:admin_tcc/app_routes.dart';
import 'package:admin_tcc/components/list_tile.dart';
import 'package:admin_tcc/components/show_custom_snackbar.dart';
import 'package:admin_tcc/config/custom_colors.dart';
import 'package:admin_tcc/controller/user_controller.dart';
import 'package:admin_tcc/enums/snackbar_kind_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = context.watch<UserController>();

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomListTile(
            icon: Icons.person,
            title: 'Meu Perfil',
            onPress: () => showCustomSnackBar(
              context: context,
              description: 'Essa função não está disponível.',
              snackbarKind: SnackBarKindEnum.info,
            ),
          ),
          if (userController.isStudent)
            CustomListTile(
              icon: Icons.menu_book_rounded,
              title: 'Informações fornecidas',
              onPress: () {
                final controller = context.read<UserController>();

                if (controller.isStudent && !controller.userModel!.isFinishSignUp!) {
                  return showCustomSnackBar(
                    context: context,
                    description: 'Complete o formulário primeiro.',
                    snackbarKind: SnackBarKindEnum.info,
                  );
                }

                Navigator.of(context).pushNamed(AppRoutes.aboutMePage);
              },
            ),
          CustomListTile(
            icon: Icons.logout_rounded,
            title: 'Deslogar',
            color: CustomColors.warning,
            onPress: () => Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.homeAuth,
              (routes) => false,
            ),
          ),
        ],
      ),
    );
  }
}
