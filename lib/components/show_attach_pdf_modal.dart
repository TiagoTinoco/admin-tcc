import 'package:admin_tcc/components/show_custom_snackbar.dart';
import 'package:admin_tcc/components/text_button.dart';
import 'package:admin_tcc/config/custom_colors.dart';
import 'package:admin_tcc/enums/snackbar_kind_enum.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void showAttachPdfModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => const AttachPdfSheet(),
  );
}

class AttachPdfSheet extends StatefulWidget {
  const AttachPdfSheet({super.key});

  @override
  State<AttachPdfSheet> createState() => _AttachPdfSheetState();
}

class _AttachPdfSheetState extends State<AttachPdfSheet> {
  String? fileName;
  PlatformFile? pickedFile;

  Future<void> _pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        pickedFile = result.files.first;
        fileName = pickedFile!.name;
      });
    }
  }

  void _onContinue() {
    Navigator.pop(context);
    showCustomSnackBar(
      context: context,
      description: 'Seu laudo médico foi enviado com sucesso!',
      snackbarKind: SnackBarKindEnum.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.neutral,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Text(
                  'Anexe o seu laudo médico',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _pickPdf,
                child: AbsorbPointer(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Selecionar PDF',
                      prefixIcon: const Icon(Icons.attach_file),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              if (fileName != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    fileName!,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              const SizedBox(height: 24),
              CustomTextButton(
                onPress: pickedFile != null ? _onContinue : null,
                title: 'Continuar',
                contentPadding: const EdgeInsets.all(16),
                textAlign: TextAlign.center,
                backgroundColor: pickedFile != null ? CustomColors.primary : CustomColors.primary.shade400,
                color: CustomColors.neutral,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
