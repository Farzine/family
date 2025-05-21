import 'package:family/components/wide_button.dart';
import 'package:family/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({
    required this.iconPath,
    required this.title,
    required this.body,
    required this.buttonTitle,
    required this.onTap,
    super.key,
  });

  final String iconPath;
  final String title;
  final String body;
  final String buttonTitle;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 184, bottom: 36),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconPath,
                width: 124,
                height: 124,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                textAlign: TextAlign.center,
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: const Color(0xffffffff)),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                textAlign: TextAlign.center,
                body,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: const Color(0xfff8f8fb)),
                maxLines: 3,
              ),
              const Spacer(),
              WideButton(
                title: buttonTitle,
                disabled: false,
                onTap: onTap,
                isColorReversed: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
