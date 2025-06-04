import 'package:admin_tcc/app_routes.dart';
import 'package:admin_tcc/components/icon_button.dart';
import 'package:admin_tcc/components/icon_container_button.dart';
import 'package:admin_tcc/components/input.dart';
import 'package:admin_tcc/components/show_custom_snackbar.dart';
import 'package:admin_tcc/components/text_button.dart';
import 'package:admin_tcc/config/custom_colors.dart';
import 'package:admin_tcc/controller/user_controller.dart';
import 'package:admin_tcc/enums/input_kind_enum.dart';
import 'package:admin_tcc/enums/sign_in_enum.dart';
import 'package:admin_tcc/enums/snackbar_kind_enum.dart';
import 'package:admin_tcc/enums/text_button_kind_enum.dart';
import 'package:admin_tcc/models/user_model.dart';
import 'package:admin_tcc/pages/auth/controllers/sign_in_controller.dart';
import 'package:admin_tcc/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _focusNode = FocusNode();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signInController = context.watch<SignInController>();
    final userController = context.watch<UserController>();

    return switch (signInController.signInStep) {
      SignInEnum.email => Scaffold(
          body: CustomScrollView(
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
                    key: _formKeyEmail,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                          controller: _emailController,
                          validator: emailValidator,
                          prefixIcon: Icon(
                            Icons.email_rounded,
                            color: CustomColors.primary.shade400,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: SafeArea(
                  bottom: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 16,
                          bottom: 12,
                        ),
                        child: CustomIconContainerButton(
                          icon: Icons.arrow_forward_ios_rounded,
                          iconSize: 22,
                          iconColor: Colors.white,
                          backgroundColor: CustomColors.primary,
                          onPress: () {
                            if (_formKeyEmail.currentState!.validate()) {
                              signInController.changeScreen(SignInEnum.password);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      SignInEnum.password => Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: IconButton(
                  onPressed: () => signInController.changeScreen(SignInEnum.email),
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
                    key: _formKeyPassword,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Qual a sua senha?',
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
                          textInputType: TextInputType.number,
                          fontSize: 20,
                          controller: _passwordController,
                          focusNode: _focusNode,
                          validator: passwordValidator,
                          maxLength: 6,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          letterSpacing: 24.0,
                          inputKind: InputKindEnum.invisible,
                          obscureText: signInController.isVisiblePassword,
                          sufixIcon: CustomIconButton(
                            onPress: () => signInController.changeIsVisiblePassword(),
                            icon: signInController.isVisiblePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                            iconSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: SafeArea(
                  bottom: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        child: CustomTextButton(
                          title: isLoading ? 'Carregando' : 'Entrar',
                          fontSize: 18,
                          textAlign: TextAlign.center,
                          color: CustomColors.neutral,
                          backgroundColor: isLoading ? CustomColors.primary.shade500 : CustomColors.primary,
                          textButtonKind: TextButtonKindEnum.large,
                          onPress: !isLoading
                              ? () async {
                                  setState(() => isLoading = true);

                                  if (_formKeyPassword.currentState!.validate()) {
                                    UserModel? userSigned = await signInController.signIn(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );

                                    if (userSigned == null) {
                                      return showCustomSnackBar(
                                        context: context,
                                        description: 'Usuário e/ou senha inválido.',
                                        snackbarKind: SnackBarKindEnum.warning,
                                      );
                                    }

                                    userController.clearUserController();

                                    userController.userModel = userSigned;

                                    signInController.changeScreen(SignInEnum.email);

                                    Navigator.of(context).pushNamedAndRemoveUntil(
                                      AppRoutes.home,
                                      (route) => false,
                                    );
                                  }

                                  setState(() => isLoading = false);
                                }
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    };
  }
}
