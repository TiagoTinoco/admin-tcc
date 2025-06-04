import 'package:admin_tcc/app_routes.dart';
import 'package:admin_tcc/config/custom_colors.dart';
import 'package:admin_tcc/controller/user_controller.dart';
import 'package:admin_tcc/pages/auth/controllers/sign_in_controller.dart';
import 'package:admin_tcc/pages/auth/controllers/sign_up_controller.dart';
import 'package:admin_tcc/pages/auth/home_auth_page.dart';
import 'package:admin_tcc/pages/home/sections/settings/about_me_page.dart';
import 'package:admin_tcc/services/user_service.dart';
import 'package:admin_tcc/pages/auth/sign_in_page.dart';
import 'package:admin_tcc/pages/auth/sign_up_page.dart';
import 'package:admin_tcc/pages/forms/soft_and_hard_skill_form_page.dart';
import 'package:admin_tcc/pages/forms/remedies_form_page.dart';
import 'package:admin_tcc/pages/home/home_page.dart';
import 'package:admin_tcc/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    UserService userService = UserService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserController(userService)),
        ChangeNotifierProvider(create: (context) => SignInController(userService)),
        ChangeNotifierProvider(create: (context) => SignUpController(userService)),
      ],
      child: MaterialApp(
        title: 'Admin TCC',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: CustomColors.neutral,
          primaryColor: CustomColors.primary,
          fontFamily: 'Poppins',
        ),
        initialRoute: AppRoutes.splash,
        routes: {
          AppRoutes.splash: (ctx) => const SplashPage(),
          AppRoutes.homeAuth: (ctx) => const HomeAuthPage(),
          AppRoutes.signIn: (ctx) => const SignInPage(),
          AppRoutes.signUp: (ctx) => const SignUpPage(),
          AppRoutes.home: (ctx) => const HomePage(),
          AppRoutes.remediesForm: (ctx) => const RemediesFormPage(),
          AppRoutes.softAndHardSkill: (ctx) => const SoftAndHardSkillFormPage(),
          AppRoutes.aboutMePage: (ctx) => const AboutMePage(),
        },
      ),
    );
  }
}
