import 'package:admin_tcc/app_routes.dart';
import 'package:admin_tcc/components/text_button.dart';
import 'package:admin_tcc/config/custom_colors.dart';
import 'package:flutter/material.dart';

class HomeAuthPage extends StatelessWidget {
  const HomeAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: CustomColors.primary.shade100,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: sizeHeight * 0.20,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: CustomColors.primary.shade700,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(300),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: sizeHeight * 0.12,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: CustomColors.neutral,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(300),
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: sizeHeight * 0.06,
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Olá, que bom te ver por aqui!',
                      style: TextStyle(
                        fontSize: 22,
                        color: CustomColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 26),
                    CustomTextButton(
                      title: 'Já tenho uma conta',
                      color: CustomColors.neutral,
                      backgroundColor: CustomColors.primary.shade500,
                      onPress: () => Navigator.of(context).pushNamed(AppRoutes.signIn),
                    ),
                    const SizedBox(height: 14),
                    CustomTextButton(
                      title: 'Não tenho uma conta',
                      onPress: () => Navigator.of(context).pushNamed(AppRoutes.signUp),
                    ),
                    const Spacer(),
                    Center(
                      child: Text(
                        'versão 1.0 (beta)',
                        style: TextStyle(
                          color: CustomColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
