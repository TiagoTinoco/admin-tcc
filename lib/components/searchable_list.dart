import 'package:admin_tcc/components/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:admin_tcc/config/custom_colors.dart';

class SearchableList extends StatefulWidget {
  const SearchableList({super.key});

  @override
  State<SearchableList> createState() => _SearchableListState();
}

class _SearchableListState extends State<SearchableList> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> students = [
    'Tiago Tinoco Martins dos Santos',
    'Fernanda Araujo Almeida',
    'João Pedro',
  ];

  List<String> filteredNames = [];

  @override
  void initState() {
    super.initState();
    filteredNames = students;
    _searchController.addListener(_filterNames);
  }

  void _filterNames() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredNames = students.where((name) => name.toLowerCase().contains(query)).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _searchController,
          keyboardType: TextInputType.text,
          style: TextStyle(
            fontSize: 14,
            color: CustomColors.black,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 8,
            ),
            hintText: 'Pesquisar pelo nome',
            prefixIcon: Icon(
              Icons.search_rounded,
              size: 20,
              color: CustomColors.blackLow,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 1.5,
                color: Color(0xFFE6E6E6),
              ),
            ),
            hintStyle: TextStyle(
              fontSize: 14,
              color: CustomColors.blackLow,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 1.5,
                color: Color(0xFFE6E6E6),
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 1.5,
                color: Color(0xFFE6E6E6),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        ...filteredNames.map(
          (name) => CustomListTile(
            icon: Icons.person,
            title: name,
            isSOS: name == 'Fernanda Araujo Almeida',
          ),
        ),
      ],
    );
  }
}
