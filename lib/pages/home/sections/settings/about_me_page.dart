import 'package:admin_tcc/components/box_circle.dart';
import 'package:admin_tcc/config/custom_colors.dart';
import 'package:admin_tcc/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutMePage extends StatefulWidget {
  const AboutMePage({super.key});

  @override
  State<AboutMePage> createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  @override
  Widget build(BuildContext context) {
    final userController = context.watch<UserController>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            title: Text(
              'Informações fornecidas',
              style: TextStyle(
                fontSize: 16,
                color: CustomColors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor: CustomColors.neutral,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              vertical: 22,
              horizontal: 16,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Remédios informados',
                    style: TextStyle(
                      fontSize: 22,
                      letterSpacing: 1.0,
                      color: CustomColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (userController.userModel!.remedies != null)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: userController.userModel!.remedies!
                          .split(';') //
                          .map((remedy) => BoxCircle(title: remedy.trim()))
                          .toList(),
                    ),
                  const SizedBox(height: 24),
                  Text(
                    'Habilidades informadas',
                    style: TextStyle(
                      fontSize: 22,
                      letterSpacing: 1.0,
                      color: CustomColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (userController.userModel!.softsAndHardSkills != null)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: userController.userModel!.softsAndHardSkills!
                          .split(';') //
                          .map((remedy) => BoxCircle(title: remedy.trim()))
                          .toList(),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
