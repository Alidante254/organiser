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
  final TextInputType? inputType;
  final double? paddingX;
  final double? paddingY;
  final double? textSize;
  final Color? iconColor;

  StyledTextField({
    required this.controller,
    required this.label,
    this.iconColor,
    this.isMultiline = false,
    this.maxLines = 1,
    this.onChanged,
    this.validator,
    this.leadingIcon,
    this.trailingIcon,
    this.onLeadingIconTap,
    this.onTrailingIconTap,
    this.inputType,
    this.paddingX = 10.0,
    this.paddingY = 20.0,
    this.textSize = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildRegularTextField(context),
      ],
    );
  }

  Widget _buildRegularTextField(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: paddingX!, vertical: paddingY!),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Expanded(
        child: Center(
          child: TextField(
            style: TextStyle(
              fontSize: textSize,
            ),
            decoration: InputDecoration(
                hintText: label,
                hintStyle: TextStyle(
                    fontSize: textSize, fontWeight: FontWeight.normal),
                border: InputBorder.none,
                suffixIcon: Icon(
                  trailingIcon,
                  color: iconColor,
                )),
            keyboardType: inputType,
          ),
        ),
      ),
    );
  }
}

class BottomBorderTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final TextInputType inputType;

  BottomBorderTextField({
    required this.controller,
    required this.hintText,
    this.leadingIcon,
    this.trailingIcon,
    this.inputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 0.0,
          ),
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(leadingIcon),
          suffixIcon: Icon(trailingIcon),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class AutocompleteTextField<T extends Object> extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final List<T> autocompleteList;
  final String? Function(T?) autocompleteLabelBuilder;
  final void Function(T?)? onAutocompleteSelected;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final void Function()? onLeadingIconTap;
  final void Function()? onTrailingIconTap;

  AutocompleteTextField({
    required this.controller,
    required this.label,
    required this.autocompleteList,
    required this.autocompleteLabelBuilder,
    this.onAutocompleteSelected,
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
        _buildAutocompleteTextField(),
      ],
    );
  }

  Widget _buildAutocompleteTextField() {
    return Autocomplete<T>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        return autocompleteList
            .where((item) => autocompleteLabelBuilder(item)!
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase()))
            .toList();
      },
      onSelected: onAutocompleteSelected,
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return StyledTextField(
          controller: textEditingController,
          isMultiline: false,
          maxLines: 1,
          onChanged: (value) {},
          validator: (value) {
            return null;
          },
          leadingIcon: leadingIcon,
          trailingIcon: trailingIcon,
          onLeadingIconTap: onLeadingIconTap,
          onTrailingIconTap: onTrailingIconTap,
          label: label,
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<T> onSelected, Iterable<T> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView(
                children: options
                    .map((item) => ListTile(
                          title: Text(autocompleteLabelBuilder(item) ?? ''),
                          onTap: () {
                            onSelected(item);
                          },
                        ))
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
