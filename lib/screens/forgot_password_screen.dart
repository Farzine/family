import 'package:family/components/custom_textformfield.dart';
import 'package:family/components/success_page.dart';
import 'package:family/screens/new_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../components/wide_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailTextEditingController = TextEditingController();
  ValueNotifier<bool> showTextField = ValueNotifier(false);
  ValueNotifier<bool> isDisabled = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    emailTextEditingController.addListener(() {
      isDisabled.value = emailTextEditingController.text.trim().isEmpty;
    });
  }

  @override
  void dispose() {
    emailTextEditingController.dispose();
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ValueListenableBuilder(
            valueListenable: showTextField,
            builder: (context, show, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Forgot Password",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Enter your email, we will send a verification code to email",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  show
                      ? Form(
                          key: _formKey,
                          child: CustomTextFormField(
                            textEditingController: emailTextEditingController,
                            labelText: "Type your email",
                            prefixIconPath:
                                'assets/icons/transparent_mail_icon.svg',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Field cannot be empty'; // triggers errorBorder
                              }
                              return null;
                            },
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            showTextField.value = true;
                          },
                          child: Container(
                            height: 72,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xffF0F0F0), width: 1),
                                borderRadius: BorderRadius.circular(4)),
                            child: ListTile(
                              leading: SvgPicture.asset(
                                'assets/icons/email_icon.svg',
                                width: 40,
                                height: 40,
                              ),
                              title: Text(
                                "Email",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              subtitle: Text(
                                "********@mail.com",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 228,
                  ),
                  ValueListenableBuilder(
                    valueListenable: isDisabled,
                    builder: (context, disabled, child) {
                      return WideButton(
                          title: "Send Link",
                          // Added to test the error border
                          onTap: () {
                            if (!_formKey.currentState!.validate()) {
                              print('Validation failed');
                            } else {
                              print('Valid input');
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SuccessPage(
                                          iconPath: 'assets/icons/success_icon.svg',
                                          title: 'Password reset successful',
                                          body: 'Password has been reset successfully. Create a new password that is safe and easy to remember',
                                          buttonTitle: 'Change Password',
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => const NewPasswordScreen()),
                                            );
                                          },
                                        )),
                              );
                            }
                          },
                          disabled: disabled);
                    }
                  )
                ],
              );
            }),
      ),
    );
  }
}
