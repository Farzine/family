import 'package:family/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    required this.labelText,
    required this.validator,
    required this.textEditingController,
    this.prefixIconPath,
    this.prefixIconOnTap,
    this.suffixIconPath,
    this.suffixIconOnTap,
    this.obscureText = false,
    super.key,
  });

  String labelText;
  String? prefixIconPath;
  String? suffixIconPath;
  FormFieldValidator<String> validator;
  GestureTapCallback? prefixIconOnTap;
  GestureTapCallback? suffixIconOnTap;
  TextEditingController textEditingController;
  bool obscureText;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText,
      controller: widget.textEditingController,
      cursorColor: textFieldCursorColor,
      cursorWidth: 1,
      cursorHeight: 20,
      style: Theme.of(context).textTheme.titleMedium,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: GoogleFonts.urbanist(
          color: textFieldLabelColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        floatingLabelStyle: GoogleFonts.urbanist(
          color: textFieldLabelColor,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: widget.prefixIconPath != null
            ? InkWell(
                onTap: widget.prefixIconOnTap,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: SvgPicture.asset(
                    widget.prefixIconPath ?? "",
                    width: 20,
                    height: 20,
                  ),
                ),
              )
            : null,
        suffixIcon: widget.suffixIconPath != null
            ? InkWell(
                onTap: widget.suffixIconOnTap,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: SvgPicture.asset(
                    widget.suffixIconPath ?? "",
                    width: 20,
                    height: 20,
                  ),
                ),
              )
            : null,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: textFieldEnabledBorderColor,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: textFieldFocusedBorderColor,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: textFieldErrorBorderColor),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: textFieldErrorBorderColor,
          ),
        ),
      ),
      validator: widget.validator,
    );
  }
}
