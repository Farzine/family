import 'package:family/components/custom_textformfield.dart';
import 'package:family/components/success_page.dart';
import 'package:family/components/wide_button.dart';
import 'package:family/screens/circle_creation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final passwordTextEditingController = TextEditingController();
  final confirmPasswordTextEditingController = TextEditingController();
  ValueNotifier<bool> obscurePassword = ValueNotifier(false);
  ValueNotifier<bool> obscureConfirmPassword = ValueNotifier(false);
  final ValueNotifier<bool> isDisabled = ValueNotifier(true);


  void _checkFields() {
    final isFilled = passwordTextEditingController.text.trim().isEmpty ||
        confirmPasswordTextEditingController.text.trim().isEmpty;
    isDisabled.value = isFilled;
  }

  @override
  void initState() {
    super.initState();
    passwordTextEditingController.addListener(() {
      _checkFields();
    });
    confirmPasswordTextEditingController.addListener(() {
      _checkFields();
    });
  }

  @override
  void dispose() {
    passwordTextEditingController.dispose();
    confirmPasswordTextEditingController.dispose();
    isDisabled.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
            child: SvgPicture.asset(
              'assets/icons/appbar_back_button_icon.svg',
              width: 40,
              height: 40,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 36),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Password",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Create a new password that is safe and easy to remember",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 26,
              ),
              ValueListenableBuilder(
                valueListenable: obscurePassword,
                builder: (context, obscure, child) {
                  return CustomTextFormField(
                    obscureText: obscure,
                    textEditingController: passwordTextEditingController,
                    labelText: "New Password",
                    prefixIconPath:
                    'assets/icons/lock_icon.svg',
                    suffixIconPath: 'assets/icons/eye_off_icon.svg',
                    suffixIconOnTap: () {
                      obscurePassword.value = !obscurePassword.value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field cannot be empty'; // triggers errorBorder
                      }
                      return null;
                    },
                  );
                }
              ),
              const SizedBox(
                height: 16,
              ),
              ValueListenableBuilder(
                valueListenable: obscureConfirmPassword,
                builder: (context, obscure, child) {
                  return CustomTextFormField(
                    obscureText: obscure,
                    textEditingController: confirmPasswordTextEditingController,
                    labelText: "Confirm New Password",
                    prefixIconPath:
                    'assets/icons/lock_icon.svg',
                    suffixIconPath: 'assets/icons/eye_off_icon.svg',
                    suffixIconOnTap: () {
                      obscureConfirmPassword.value = !obscureConfirmPassword.value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field cannot be empty'; // triggers errorBorder
                      }
                      return null;
                    },
                  );
                }
              ),
              Spacer(),
              ValueListenableBuilder(
                valueListenable: isDisabled,
                builder: (context, disabled, child) {
                  return WideButton(
                      title: "Confirm New Password",
                      // Added to test the error border
                      onTap: () {
                        if (!_formKey.currentState!.validate()) {
                          print('Validation failed');
                        } else {
                          print('Valid input');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CircleCreationScreen()),
                          );
                        }
                      },
                      disabled: disabled);
                }
              )
            ],
          ),
        )
      ),
    );
  }
}
