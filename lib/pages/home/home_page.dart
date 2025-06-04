import 'package:admin_tcc/components/show_custom_snackbar.dart';
import 'package:admin_tcc/components/text_button.dart';
import 'package:admin_tcc/config/custom_colors.dart';
import 'package:admin_tcc/controller/user_controller.dart';
import 'package:admin_tcc/enums/snackbar_kind_enum.dart';
import 'package:admin_tcc/pages/home/sections/manager_section.dart';
import 'package:admin_tcc/pages/home/sections/settings_section.dart';
import 'package:admin_tcc/pages/home/sections/student_section.dart';
import 'package:admin_tcc/pages/home/widgets/user_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userController = context.watch<UserController>();
    Color areaColor = userController.isStudent ? CustomColors.primary.shade700 : CustomColors.secondary.withOpacity(0.7);

    return Scaffold(
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          UserInfoWidget(areaColor: areaColor),
          SliverFillRemaining(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _selectedIndex = index);
              },
              children: [
                _HomeSection(areaColor: areaColor),
                const SettingsSection(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _BottomNavigationBar(
        selectedIndex: _selectedIndex,
        areaColor: areaColor,
        onPress: _onItemTapped,
      ),
    );
  }
}

class _HomeSection extends StatelessWidget {
  const _HomeSection({
    required this.areaColor,
  });

  final Color areaColor;

  @override
  Widget build(BuildContext context) {
    final userController = context.watch<UserController>();

    return Column(
      children: [
        if (userController.isManager) const ManagerSection(),
        if (userController.isStudent) ...[
          const StudentSection(),
          const Spacer(),
          const SizedBox(height: 16),
          CustomTextButton(
            onPress: () => showCustomSnackBar(
              context: context,
              description: 'Seu gestor ja foi avisado, respire e espere seu gestor chegar até você.',
              snackbarKind: SnackBarKindEnum.success,
            ),
            title: 'Emergência',
            color: CustomColors.neutral,
            backgroundColor: CustomColors.warning,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 32,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar({
    required this.selectedIndex,
    required this.areaColor,
    required this.onPress,
  });

  final int selectedIndex;
  final Color areaColor;
  final Function(int) onPress;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: MediaQuery.of(context).size.width * 0.3,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(90),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(90),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: selectedIndex,
            onTap: onPress,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            selectedItemColor: areaColor,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            showUnselectedLabels: false,
            showSelectedLabels: false,
            items: [
              _buildBarItem(Icons.home_rounded, 0),
              _buildBarItem(Icons.settings_rounded, 1),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBarItem(IconData icon, int index) {
    final bool isSelected = selectedIndex == index;

    return BottomNavigationBarItem(
      label: '',
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 4,
            width: isSelected ? 24 : 0,
            decoration: BoxDecoration(
              color: isSelected ? areaColor : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 4),
          Icon(
            icon,
            size: 26,
            color: isSelected ? areaColor : Colors.grey,
          ),
        ],
      ),
    );
  }
}
