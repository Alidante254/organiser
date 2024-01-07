import 'package:flutter/material.dart';

class StyledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isMultiline;
  final int maxLines;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final void Function()? onLeadingIconTap;
  final void Function()? onTrailingIconTap;

  StyledTextField({
    required this.controller,
    required this.label,
    this.isMultiline = false,
    this.maxLines = 1,
    this.onChanged,
    this.validator,
    this.leadingIcon,
    this.trailingIcon,
    this.onLeadingIconTap,
    this.onTrailingIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        _buildRegularTextField(),
      ],
    );
  }

  Widget _buildRegularTextField() {
    return TextFormField(
      controller: controller,
      keyboardType: isMultiline ? TextInputType.multiline : TextInputType.text,
      maxLines: isMultiline ? maxLines : 1,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        prefixIcon: leadingIcon != null
            ? GestureDetector(
                onTap: onLeadingIconTap,
                child: Icon(leadingIcon),
              )
            : null,
        suffixIcon: trailingIcon != null
            ? GestureDetector(
                onTap: onTrailingIconTap,
                child: Icon(trailingIcon),
              )
            : null,
      ),
    );
  }
}


