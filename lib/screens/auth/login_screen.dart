import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shop_smart_app/consts/my_validators.dart';
import 'package:shop_smart_app/roots_app.dart';
import 'package:shop_smart_app/screens/auth/forgot_password.dart';
import 'package:shop_smart_app/screens/auth/register_screen.dart';
import 'package:shop_smart_app/screens/loading_manager.dart';
import 'package:shop_smart_app/services/auth_service.dart';
import 'package:shop_smart_app/widgets/custom_app_bar_title.dart';
import 'package:shop_smart_app/widgets/custom_snack_bar_widget.dart';
import 'package:shop_smart_app/widgets/custom_sub_title.dart';
import 'package:shop_smart_app/widgets/custom_text_button.dart';
import 'package:shop_smart_app/widgets/custom_text_field.dart';
import 'package:shop_smart_app/widgets/custom_title_text.dart';

class LoginScreen extends StatefulWidget {
  static const routName = '/LoginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool isLoading = false;
  String? errMsg;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    // Focus Nodes
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    // Focus Nodes
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loginValidationMethod() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();
    setState(() => isLoading = true);

    try {
      final errorMessage = await AuthService.signInWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (errorMessage != null) {
        CustomSnackbar.showError(context, errorMessage);
        return;
      }

      CustomSnackbar.showSuccess(context, "Signed in successfully");

      if (mounted) {
        Navigator.pushReplacementNamed(context, RootsApp.routName);
      }
    } catch (e) {
      CustomSnackbar.showError(context, "An unexpected error occurred");
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: LoadingManager(
          isLoading: isLoading,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.06),
                  const CustomAppBarTitle(fontSize: 36),
                  SizedBox(height: size.height * 0.06),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: CustomTitleText(text: "Welcome back", fontSize: 26),
                  ),

                  SizedBox(height: size.height * 0.01),

                  Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: CustomSubTitle(
                      text:
                          "Let's get you logged in so you can start exploring",
                      fontSize: 17,
                    ),
                  ),

                  SizedBox(height: size.height * 0.02),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.01),
                        CustomTextField(
                          fillColor: Theme.of(context).cardColor,
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,

                          hintText: "Email address",
                          prefixIcon: IconlyLight.message,

                          validator: (value) {
                            return MyValidators.emailValidator(value);
                          },
                          onFieldSubmited: (value) {
                            FocusScope.of(
                              context,
                            ).requestFocus(_passwordFocusNode);
                          },
                        ),

                        SizedBox(height: size.height * 0.02),

                        CustomTextField(
                          fillColor: Theme.of(context).cardColor,
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscureText,
                          hintText: "*********",
                          prefixIcon: IconlyLight.lock,
                          onSuffixIconTap: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          suffixIcon: obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          validator: (value) {
                            return MyValidators.passwordValidator(value);
                          },
                          onFieldSubmited: (value) {
                            _loginValidationMethod();
                          },
                        ),

                        SizedBox(height: size.height * 0.02),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ForgotPasswordScreen();
                                  },
                                ),
                              );
                            },
                            child: const CustomSubTitle(
                              text: "Forgot password?",
                              textDecoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),

                        SizedBox(height: size.height * 0.02),

                        CustomTextButton(
                          backgroundColor: Colors.blueAccent,
                          borderRadius: 12,
                          text: "Login",
                          onPressed: () async {
                            _loginValidationMethod();
                          },
                          icon: Icons.login,
                        ),

                        SizedBox(height: size.height * 0.02),

                        CustomSubTitle(
                          text: "OR connect using".toUpperCase(),
                          fontSize: 22,
                        ),

                        SizedBox(height: size.height * 0.02),

                        SizedBox(height: size.height * 0.04),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomSubTitle(
                              text: "Don't have an account?",
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  RegisterScreen.routName,
                                );
                              },
                              child: const CustomSubTitle(
                                text: "Sign up",
                                textDecoration: TextDecoration.underline,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ],
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
