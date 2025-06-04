import 'package:admin_tcc/config/custom_colors.dart';
import 'package:admin_tcc/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputPin extends StatefulWidget {
  const CustomInputPin({
    super.key,
    required this.colorArea,
    required this.pinLength,
    required this.controller,
  });

  final Color colorArea;
  final int pinLength;
  final TextEditingController controller;

  @override
  State<CustomInputPin> createState() => _CustomInputPinState();
}

class _CustomInputPinState extends State<CustomInputPin> {
  final FocusNode _focusNode = FocusNode();
  String? _errorText;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.requestFocus();
        setState(() {});
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 1,
            child: Opacity(
              opacity: 0,
              child: TextField(
                controller: widget.controller,
                focusNode: _focusNode,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                maxLength: widget.pinLength,
                onChanged: (value) => setState(() {
                  _errorText = passwordValidator(value);
                }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.pinLength, (index) {
                bool isFirst = index == widget.controller.text.length && _focusNode.hasFocus;
                bool isNotEmpty = index < widget.controller.text.length;

                return Flexible(
                  flex: 1,
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isFirst || isNotEmpty
                            ? _errorText != null
                                ? CustomColors.warning
                                : widget.colorArea
                            : CustomColors.black,
                        width: isFirst || isNotEmpty ? 2 : 1.2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      isNotEmpty ? widget.controller.text[index] : '',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          if (_errorText != null) ...[
            Text(
              _errorText!,
              style: TextStyle(
                color: CustomColors.warning,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
