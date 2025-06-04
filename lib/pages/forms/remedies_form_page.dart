import 'package:admin_tcc/app_routes.dart';
import 'package:admin_tcc/components/box_circle.dart';
import 'package:admin_tcc/components/input.dart';
import 'package:admin_tcc/components/show_custom_snackbar.dart';
import 'package:admin_tcc/components/text_button.dart';
import 'package:admin_tcc/controller/user_controller.dart';
import 'package:admin_tcc/enums/snackbar_kind_enum.dart';
import 'package:admin_tcc/enums/text_button_kind_enum.dart';
import 'package:flutter/material.dart';
import 'package:admin_tcc/config/custom_colors.dart';
import 'package:provider/provider.dart';

class RemediesFormPage extends StatefulWidget {
  const RemediesFormPage({super.key});

  @override
  State<RemediesFormPage> createState() => _RemediesFormPageState();
}

class _RemediesFormPageState extends State<RemediesFormPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _remedies = [];

  void _handleSubmitted(String value) {
    if (value.trim().isEmpty) return;

    setState(() {
      _remedies.add(value.trim());
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final formKeyRemedies = GlobalKey<FormState>();
    final userController = context.watch<UserController>();

    return Scaffold(
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            backgroundColor: CustomColors.neutral,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              vertical: 22,
              horizontal: 16,
            ),
            sliver: SliverToBoxAdapter(
              child: Form(
                key: formKeyRemedies,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Digite os remédios que você usa diariamente',
                      style: TextStyle(
                        fontSize: 22,
                        letterSpacing: 1.0,
                        color: CustomColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    CustomInput(
                      controller: _controller,
                      prefixIcon: Icon(
                        Icons.data_saver_on_rounded,
                        color: CustomColors.primary.shade600,
                      ),
                      hintText: 'Ex: dipirona 500gm 6/6hrs',
                      onFieldSubmitted: _handleSubmitted,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Digite o remédio com a hora que deve ser tomado e aperte Enter',
                      style: TextStyle(
                        fontSize: 12,
                        color: CustomColors.blackLow,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _remedies
                          .map(
                            (remedy) => BoxCircle(title: remedy),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: SafeArea(
              bottom: true,
              child: Column(
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    child: CustomTextButton(
                      title: 'Continuar',
                      fontSize: 18,
                      textAlign: TextAlign.center,
                      color: CustomColors.neutral,
                      backgroundColor: CustomColors.primary,
                      textButtonKind: TextButtonKindEnum.large,
                      onPress: () async {
                        if (_remedies.isEmpty) {
                          return showCustomSnackBar(
                            context: context,
                            description: 'Digite pelo menos um remédio que você use.',
                            snackbarKind: SnackBarKindEnum.info,
                          );
                        }

                        await userController.updateRemedies(_remedies.join(';'));

                        Navigator.of(context).popAndPushNamed(AppRoutes.softAndHardSkill);
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
