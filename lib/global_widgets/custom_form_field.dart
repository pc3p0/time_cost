import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    required this.textController,
    required this.helperLabel,
    required this.prefixIcon,
    this.validator,
    this.isCurrency,
    this.isLast,
    this.isEnabled,
  }) : super(key: key);

  final TextEditingController textController;
  final String helperLabel;
  final Widget prefixIcon;
  final String? Function(String?)? validator;
  final bool? isCurrency;
  final bool? isLast;
  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    // Horizontal extent of this screen.
    var deviceWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: (deviceWidth * 0.8),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: prefixIcon,
          ),
          Expanded(
            child: Text(
              helperLabel,
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: textController,
              enabled: isEnabled,
              autocorrect: false,
              keyboardType: TextInputType.number,
              textInputAction: (isLast ?? false)
                  ? TextInputAction.done
                  : TextInputAction.next,
              inputFormatters: (isCurrency ?? false)
                  ? [CurrencyTextInputFormatter(locale: 'en', symbol: '\$')]
                  : null,
              validator: validator,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                errorMaxLines: 2,
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
