import 'package:flutter/material.dart';

import '../styles/colors.dart';

class WideButton extends StatefulWidget {
  WideButton(
      {super.key,
      required this.title,
      required this.disabled,
      required this.onTap,
      this.isLoading = false,
      this.isColorReversed = false});

  String title;
  bool disabled;
  bool isColorReversed;
  bool isLoading;
  GestureTapCallback? onTap;

  @override
  State<WideButton> createState() => _WideButtonState();
}

class _WideButtonState extends State<WideButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: InkWell(
          onTap: widget.disabled || widget.isLoading ? null : widget.onTap,
          child: Container(
            height: 48,
            decoration: BoxDecoration(
                color: getButtonColor(),
                borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: widget.isLoading ? SizedBox(height:20, width: 20,child: CircularProgressIndicator(color: getButtonTextColor(),)) : Text(
                widget.title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: getButtonTextColor()),
              ),
            ),
          ),
        ));
  }

  Color getButtonColor() => widget.disabled
      ? disabledButtonColor
      : widget.isColorReversed
          ? buttonColorReverse
          : buttonColor;

  Color getButtonTextColor() => widget.disabled
      ? disabledButtonTextColor
      : widget.isColorReversed
          ? buttonTextColorReverse
          : buttonTextColor;
}
