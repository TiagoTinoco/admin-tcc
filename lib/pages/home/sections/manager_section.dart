import 'package:admin_tcc/components/searchable_list.dart';
import 'package:flutter/material.dart';

class ManagerSection extends StatefulWidget {
  const ManagerSection({super.key});

  @override
  State<ManagerSection> createState() => ManagerSectionState();
}

class ManagerSectionState extends State<ManagerSection> {
  static final List<Color> cardColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchableList(),
        ],
      ),
    );
  }
}
