import 'package:family/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:family/components/custom_textformfield.dart';
import 'package:family/components/wide_button.dart';
import 'package:family/screens/forgot_password_screen.dart';
import 'package:family/styles/colors.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;
  ValueNotifier<bool> isButtonDisabled = ValueNotifier(true);
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_updateButtonState);
    passwordController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    isButtonDisabled.value = email.isEmpty || password.isEmpty;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    isButtonDisabled.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _signInWithEmail() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  void _signInWithGoogle() {}

  void _navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }

  void _navigateToForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
    );
  }

  void _unfocusAllFields() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: _unfocusAllFields,
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 116, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Back!",
                    style: GoogleFonts.urbanist(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height: 1.25, //Line height of 30px with 24px font size
                      color: titleTextColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Sign In to your account",
                    style: GoogleFonts.urbanist(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.5, //Line height of 24px with 16px font size
                      color: bodyTextColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  InkWell(
                    onTap: _signInWithGoogle,
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        border: Border.all(color: textFieldEnabledBorderColor),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Container(
                        color: screenBackgroundColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/google.png',
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(width: 24),
                            Text(
                              "Sign in with Google",
                              style: GoogleFonts.urbanist(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: buttonTextColorReverse,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: textFieldEnabledBorderColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "OR",
                            style: GoogleFonts.urbanist(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: textFieldLabelColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: textFieldEnabledBorderColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          labelText: "Type your email",
                          textEditingController: emailController,
                          prefixIconPath: 'assets/icons/mail.svg',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Email is required'),
                            FormBuilderValidators.email(
                                errorText: 'Enter a valid email address'),
                          ]),
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          labelText: "Type your password",
                          textEditingController: passwordController,
                          prefixIconPath: 'assets/icons/lock_icon.svg',
                          suffixIconPath: _obscureText
                              ? 'assets/icons/eye_off_icon.svg'
                              : 'assets/icons/eye.svg',
                          suffixIconOnTap: _togglePasswordVisibility,
                          obscureText: _obscureText,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Password is required'),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _navigateToForgotPassword,
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        "Forgot Password?",
                        style: GoogleFonts.urbanist(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  ValueListenableBuilder(
                    valueListenable: isButtonDisabled,
                    builder: (context, disabled, _) {
                      return WideButton(
                        title: "Sign In",
                        disabled: disabled,
                        isLoading: isLoading,
                        onTap: _signInWithEmail,
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 16),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.urbanist(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: bodyTextColor,
                            height:
                                1.57, // Line height of 22px with 14px font size
                          ),
                          children: [
                            const TextSpan(text: "Don't have account? "),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: _navigateToSignUp,
                                child: Text(
                                  "Sign Up",
                                  style: GoogleFonts.urbanist(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
