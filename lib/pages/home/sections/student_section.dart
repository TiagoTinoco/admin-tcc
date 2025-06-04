import 'package:admin_tcc/components/list_tile.dart';
import 'package:admin_tcc/components/show_attach_pdf_modal.dart';
import 'package:admin_tcc/components/show_custom_snackbar.dart';
import 'package:admin_tcc/enums/snackbar_kind_enum.dart';
import 'package:flutter/material.dart';

class StudentSection extends StatefulWidget {
  const StudentSection({super.key});

  @override
  State<StudentSection> createState() => StudentSectionState();
}

class StudentSectionState extends State<StudentSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomListTile(
            icon: Icons.medical_information_rounded,
            title: 'Anexar laudo médico',
            onPress: () => showAttachPdfModal(context),
          ),
          CustomListTile(
            icon: Icons.all_inbox_rounded,
            title: 'Observações',
            onPress: () => showCustomSnackBar(
              context: context,
              description: 'Essa função não está disponível.',
              snackbarKind: SnackBarKindEnum.info,
            ),
          ),
        ],
      ),
    );
  }
}
