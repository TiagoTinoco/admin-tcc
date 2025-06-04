import 'package:admin_tcc/app_routes.dart';
import 'package:admin_tcc/components/input.dart';
import 'package:admin_tcc/components/input_pin.dart';
import 'package:admin_tcc/components/show_custom_snackbar.dart';
import 'package:admin_tcc/components/text_button.dart';
import 'package:admin_tcc/config/custom_colors.dart';
import 'package:admin_tcc/enums/gender_enum.dart';
import 'package:admin_tcc/enums/snackbar_kind_enum.dart';
import 'package:admin_tcc/enums/text_button_kind_enum.dart';
import 'package:admin_tcc/enums/user_kind_enum.dart';
import 'package:admin_tcc/models/user_model.dart';
import 'package:admin_tcc/pages/auth/controllers/sign_up_controller.dart';
import 'package:admin_tcc/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

final _formKey = GlobalKey<FormState>();

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isLoading = false;

  final List<Tab> tabs = const [
    Tab(text: 'aluno/candidato'),
    Tab(text: 'funcionário/gestor'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SignUpController>();

    bool isStudent = _tabController.index == 0;
    Color areaColor = isStudent ? CustomColors.primary : CustomColors.secondary;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back_rounded,
                color: CustomColors.neutral,
              ),
            ),
            backgroundColor: areaColor.withOpacity(0.7),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  indicatorColor: areaColor,
                  labelColor: areaColor,
                  tabs: tabs,
                ),
                _FormArea(
                  areaColor: areaColor,
                  nameController: _nameController,
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: areaColor.withOpacity(0.04),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: CustomTextButton(
              title: isLoading ? 'Carregando' : 'Cadastrar',
              fontSize: 18,
              textAlign: TextAlign.center,
              color: CustomColors.neutral,
              backgroundColor: !isLoading ? areaColor : areaColor.withOpacity(0.5),
              textButtonKind: TextButtonKindEnum.large,
              onPress: !isLoading
                  ? () async {
                      setState(() => isLoading = true);

                      if (_formKey.currentState!.validate()) {
                        if (controller.choicedGender == null) {
                          return showCustomSnackBar(
                            context: context,
                            description: 'O gênero não foi informado. Escolha um gênero.',
                            snackbarKind: SnackBarKindEnum.info,
                          );
                        }

                        if (_passwordController.text.isEmpty) {
                          return showCustomSnackBar(
                            context: context,
                            description: 'A senha não pode ser vazia. Crie uma senha.',
                            snackbarKind: SnackBarKindEnum.info,
                          );
                        }

                        UserModel newUser = UserModel(
                          name: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          userKind: isStudent ? UserKindEnum.student : UserKindEnum.manager,
                          gender: controller.choicedGender!,
                        );

                        final String? msg = await controller.createUser(newUser: newUser);

                        if (msg != null) {
                          return showCustomSnackBar(
                            context: context,
                            title: 'Houve um erro',
                            description: msg,
                            snackbarKind: SnackBarKindEnum.warning,
                          );
                        }

                        showCustomSnackBar(
                          context: context,
                          description: 'Seu cadastro foi concluído com sucesso.',
                          duration: const Duration(seconds: 2),
                          snackbarKind: SnackBarKindEnum.success,
                        );

                        await Future.delayed(const Duration(seconds: 3));

                        Navigator.of(context).popAndPushNamed(AppRoutes.signIn);
                      }

                      setState(() => isLoading = false);
                    }
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}

class _FormArea extends StatefulWidget {
  const _FormArea({
    required this.areaColor,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  });

  final Color areaColor;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<_FormArea> createState() => __FormArea();
}

class __FormArea extends State<_FormArea> {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SignUpController>();

    Widget genderButtons(GenderEnum gender) {
      return Padding(
        padding: const EdgeInsets.only(right: 12),
        child: CustomTextButton(
          title: gender.label,
          color: controller.choicedGender == gender ? CustomColors.neutral : CustomColors.black,
          backgroundColor: controller.choicedGender == gender ? widget.areaColor : CustomColors.neutral,
          hasBorder: controller.choicedGender != gender,
          onPress: () {
            setState(() {
              controller.changeGender(gender);
            });
          },
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(
        top: 32,
        left: 16,
        right: 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Qual o seu nome?',
              style: TextStyle(
                fontSize: 22,
                letterSpacing: 1.0,
                color: CustomColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            CustomInput(
              enabled: true,
              textInputType: TextInputType.text,
              controller: widget.nameController,
              validator: nameValidator,
              borderColor: widget.areaColor,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
              ],
              textCapitalization: TextCapitalization.words,
              prefixIcon: Icon(
                Icons.person,
                color: widget.areaColor.withOpacity(0.4),
                size: 24,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Insira seu e-mail',
              style: TextStyle(
                fontSize: 22,
                letterSpacing: 1.0,
                color: CustomColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            CustomInput(
              enabled: true,
              textInputType: TextInputType.emailAddress,
              controller: widget.emailController,
              validator: emailValidator,
              borderColor: widget.areaColor,
              prefixIcon: Icon(
                Icons.email_rounded,
                color: widget.areaColor.withOpacity(0.4),
                size: 24,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Qual o seu gênero?',
              style: TextStyle(
                fontSize: 22,
                letterSpacing: 1.0,
                color: CustomColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: GenderEnum.values //
                  .map((gender) => genderButtons(gender))
                  .toList(),
            ),
            const SizedBox(height: 32),
            Text(
              'Crie uma senha',
              style: TextStyle(
                fontSize: 22,
                letterSpacing: 1.0,
                color: CustomColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            CustomInputPin(
              colorArea: widget.areaColor.withOpacity(0.7),
              pinLength: 6,
              controller: widget.passwordController,
            ),
          ],
        ),
      ),
    );
  }
}
