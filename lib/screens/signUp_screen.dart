import 'package:family/components/custom_textformfield.dart';
import 'package:family/components/wide_button.dart';
import 'package:family/screens/forgot_password_screen.dart';
import 'package:family/screens/signIn_screen.dart';
import 'package:family/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscureText = true;
  bool _isPasswordFocused = false;
  bool _termsAgreed = false;
  ValueNotifier<bool> isButtonDisabled = ValueNotifier(true);
  bool isLoading = false;

  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  bool hasMinLength = false;
  bool hasNumber = false;
  bool hasLetter = false;
  bool hasStrongPassword = false;

  @override
  void initState() {
    super.initState();

    firstNameController.addListener(_updateButtonState);
    lastNameController.addListener(_updateButtonState);
    emailController.addListener(_updateButtonState);
    passwordController.addListener(_updatePasswordAndButtonState);

    passwordFocusNode.addListener(() {
      setState(() {
        _isPasswordFocused = passwordFocusNode.hasFocus;
      });
    });
  }

  void _updatePasswordAndButtonState() {
    final password = passwordController.text;

    setState(() {
      hasMinLength = password.length >= 8;
      hasNumber = RegExp(r'[0-9]').hasMatch(password);
      hasLetter = RegExp(r'[a-zA-Z]').hasMatch(password);
      hasStrongPassword = hasMinLength && hasNumber && hasLetter;
    });

    _updateButtonState();
  }

  void _updateButtonState() {
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    isButtonDisabled.value = firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        !hasStrongPassword ||
        !_termsAgreed;
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    isButtonDisabled.dispose();

    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggleTermsAgreement(bool? value) {
    setState(() {
      _termsAgreed = value ?? false;
    });
    _updateButtonState();
  }

  void _navigateToSignIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
  }

  void _unfocusAllFields() {
    FocusScope.of(context).unfocus();
  }

  void _createAccount() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isLoading = false;
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ForgotPasswordScreen(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GestureDetector(
          onTap: _unfocusAllFields,
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 72, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign Up",
                    style: GoogleFonts.urbanist(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height: 1.25,
                      color: titleTextColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Create account and enjoy all services",
                    style: GoogleFonts.urbanist(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      color: bodyTextColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          labelText: "Type your first name",
                          textEditingController: firstNameController,
                          prefixIconPath: 'assets/icons/user.svg',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'First name is required'),
                            FormBuilderValidators.minLength(2,
                                errorText: 'Must be at least 2 characters'),
                          ]),
                        ),
                        const SizedBox(height: 16),

                        CustomTextFormField(
                          labelText: "Type your last name",
                          textEditingController: lastNameController,
                          prefixIconPath: 'assets/icons/user.svg',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Last name is required'),
                            FormBuilderValidators.minLength(2,
                                errorText: 'Must be at least 2 characters'),
                          ]),
                        ),
                        const SizedBox(height: 16),

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
                          validator: (_) {
                            if (!hasStrongPassword) {
                              return 'Password must meet all criteria';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        AnimatedContainer(  // akhne aktu bug ase height width ar
                          duration: const Duration(milliseconds: 100),
                          height: (_isPasswordFocused ||
                                  passwordController.text.isNotEmpty)
                              ? (!hasStrongPassword ? 100 : 36)
                              : 0,
                          width: 327,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!hasStrongPassword) ...[
                                Row(
                                  children: [
                                    Icon(
                                      hasMinLength ? Icons.check : Icons.close,
                                      color: hasMinLength
                                          ? Colors.green
                                          : Colors.red,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Minimum 8 characters",
                                      style: GoogleFonts.urbanist(
                                        fontSize: 14,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      hasNumber ? Icons.check : Icons.close,
                                      color:
                                          hasNumber ? Colors.green : Colors.red,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "At least 1 number (1-9)",
                                      style: GoogleFonts.urbanist(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      hasLetter ? Icons.check : Icons.close,
                                      color:
                                          hasLetter ? Colors.green : Colors.red,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "At least lowercase or uppercase letters",
                                      style: GoogleFonts.urbanist(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ] else ...[
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "You have very strong password",
                                      style: GoogleFonts.urbanist(
                                        fontSize: 14,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: _termsAgreed,
                                onChanged: _toggleTermsAgreement,
                                activeColor: const Color(0xFFFF4500),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: GoogleFonts.urbanist(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    height: 1.57,
                                  ),
                                  children: [
                                    const TextSpan(
                                        text: "I agree to the company "),
                                    WidgetSpan(
                                      child: GestureDetector(
                                        onTap: null,
                                        child: Text(
                                          "Term of Service",
                                          style: GoogleFonts.urbanist(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFFFF4500),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const TextSpan(text: " and "),
                                    WidgetSpan(
                                      child: GestureDetector(
                                        onTap: null,
                                        child: Text(
                                          "Privacy Policy",
                                          style: GoogleFonts.urbanist(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFFFF4500),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 48),

                  ValueListenableBuilder(
                    valueListenable: isButtonDisabled,
                    builder: (context, disabled, _) {
                      return WideButton(
                        title: "Create Account",
                        disabled: disabled,
                        isLoading: isLoading,
                        onTap: _createAccount,
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
                            height: 1.57,
                          ),
                          children: [
                            const TextSpan(text: "Have an account? "),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: _navigateToSignIn,
                                child: Text(
                                  "Sign In",
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


                  SizedBox(
                      height: MediaQuery.of(context).viewInsets.bottom > 0
                          ? 300
                          : 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
