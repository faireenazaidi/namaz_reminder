import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:namaz_reminders/Widget/appColor.dart';
import 'package:namaz_reminders/Widget/primary_text.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';

class PrimaryTextField extends StatelessWidget {
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final int? maxLine;
  final int? maxLength;
  final int? minLength;
  final bool? enabled;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final InputDecoration? decoration;
  final ValueChanged<String>? onChanged;
  final Color? borderColor;
  final String? labelText;
  final Color? backgroundColor;
  final Color? hintTextColor;
  final InputBorder? border;
  final TextStyle? style;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;

  const PrimaryTextField({
    Key? key,
    this.hintText,
    this.controller,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.minLength,
    this.enabled,
    this.textAlign,
    this.keyboardType,
    this.decoration,
    this.onChanged,
    this.borderColor,
    this.maxLine,
    this.labelText,
    this.backgroundColor,
    this.hintTextColor,
    this.border,
    this.suffixIconConstraints,
    this.prefixIconConstraints,
    this.style,
    this.inputFormatters,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      cursorColor: Colors.black,
      enabled: enabled ?? true,
      controller: controller,
      textInputAction: TextInputAction.done,
      minLines: maxLine,
      maxLines: maxLine == null ? 1 : maxLine,
      maxLength: maxLength,
      textAlign: textAlign ?? TextAlign.start,
      keyboardType: keyboardType,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: decoration ??
          InputDecoration(
            constraints: const BoxConstraints(
              maxHeight: 60,
              minHeight: 40,

            ),

            floatingLabelBehavior: FloatingLabelBehavior.always,
            filled: true,
            fillColor: Colors.white,
            isDense: true,
            counterText: '',
            contentPadding: const EdgeInsets.all(12),
            hintText: hintText,
            hintStyle: MyTextTheme.mediumPCN.copyWith(
              color: hintTextColor ?? AppColor.greyDark,
              fontSize: 14,
            ),
            labelText: labelText,
            labelStyle: MyTextTheme.smallPCB,
            errorStyle: MyTextTheme.mediumBCN.copyWith(
              color: AppColor.error,
              fontSize: 14,
            ),
            suffixIconConstraints: suffixIconConstraints ??
                const BoxConstraints(
                  maxHeight: 30,
                  minHeight: 20,
                  maxWidth: 40,
                  minWidth: 40,
                ),
            prefixIconConstraints: prefixIconConstraints ??
                const BoxConstraints(
                  maxHeight: 30,
                  minHeight: 20,
                  maxWidth: 40,
                  minWidth: 40,
                ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            focusedBorder: border ??
                OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(PrimaryTextFieldUtil.border),
                  ),
                  borderSide: BorderSide(
                    color: borderColor ?? PrimaryTextFieldUtil.borderColor,
                    width: 1,
                  ),
                ),
            enabledBorder: border ??
                OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(PrimaryTextFieldUtil.border),
                  ),
                  borderSide: BorderSide(
                    color: borderColor ?? PrimaryTextFieldUtil.borderColor,
                    width: 1,
                  ),
                ),
            disabledBorder: border ??
                OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(PrimaryTextFieldUtil.border),
                  ),
                  borderSide: BorderSide(
                    color: borderColor ?? PrimaryTextFieldUtil.borderColor,
                    width: 1,
                  ),
                ),
            errorBorder: border ??
                OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(PrimaryTextFieldUtil.border),
                  ),
                  borderSide: BorderSide(
                    color: borderColor ?? PrimaryTextFieldUtil.borderColor,
                    width: 1,
                  ),
                ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(PrimaryTextFieldUtil.border),
              ),
              borderSide: BorderSide(
                color: borderColor ?? PrimaryTextFieldUtil.borderColor,
                width: 1,
              ),
            ),
          ),
      validator: validator,
    );

  }
}
