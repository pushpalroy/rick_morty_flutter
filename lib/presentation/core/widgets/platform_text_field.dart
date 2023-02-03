import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:rick_morty_flutter/presentation/core/widgets/abstract_plaform_widget.dart';

class RmTextField
    extends AbstractPlatformWidget<CupertinoTextField, TextField> {
  const RmTextField(
      {Key? key,
      this.controller,
      this.focusNode,
      this.maxLength,
      this.inputFormatters,
      this.keyboardType,
      this.autocorrect = true,
      this.toolbarOptions,
      this.hintText,
      this.obscureText = false})
      : super(key: key);

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool autocorrect;
  final ToolbarOptions? toolbarOptions;
  final String? hintText;
  final bool obscureText;

  @override
  CupertinoTextField buildCupertino(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      focusNode: focusNode,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      autocorrect: autocorrect,
      toolbarOptions: toolbarOptions,
      placeholder: hintText,
      obscureText: obscureText,
    );
  }

  @override
  TextField buildMaterial(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      autocorrect: autocorrect,
      toolbarOptions: toolbarOptions,
      decoration: InputDecoration(
        labelText: hintText,
      ),
      obscureText: obscureText,
    );
  }
}
