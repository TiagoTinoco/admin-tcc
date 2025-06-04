import 'package:admin_tcc/config/custom_colors.dart';
import 'package:admin_tcc/pages/auth/home_auth_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.wait(
      [Future<void>.delayed(const Duration(milliseconds: 2000))],
    ).then((_) async {
      await Navigator.of(context).pushReplacement(
        PageRouteBuilder<void>(
          transitionDuration: const Duration(milliseconds: 1000),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) {
            return SizeTransition(
              sizeFactor: animation,
              child: const HomeAuthPage(),
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              CustomColors.primary.shade700,
              CustomColors.primary,
              CustomColors.primary,
              CustomColors.primary.shade500,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: CircularProgressIndicator(
              color: CustomColors.neutral,
            ),
          ),
        ),
      ),
    );
  }
}
