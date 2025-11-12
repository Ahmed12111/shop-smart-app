import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shop_smart_app/widgets/custom_app_bar_title.dart';
import 'package:shop_smart_app/widgets/custom_sub_title.dart';
import 'package:shop_smart_app/widgets/custom_text_button.dart';
import 'package:shop_smart_app/widgets/custom_text_field.dart';
import 'package:shop_smart_app/widgets/custom_title_text.dart';
import '../../consts/my_validators.dart';
import '../../services/assets_manager.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/ForgotPasswordScreen';
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final TextEditingController _emailController;
  late final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _emailController.dispose();
    }
    super.dispose();
  }

  Future<void> _forgetPassFCT() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {}
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CustomAppBarTitle(fontSize: 22),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              physics: const BouncingScrollPhysics(),
              children: [
                // Section 1 - Header
                SizedBox(height: size.height * 0.04),

                Image.asset(
                  AssetsManager.forgotPassword,
                  width: size.width * 0.6,
                  height: size.width * 0.6,
                ),
                SizedBox(height: size.height * 0.02),

                const CustomTitleText(text: 'Forgot password', fontSize: 22),
                SizedBox(height: size.height * 0.02),

                const CustomSubTitle(
                  text:
                      'Please enter the email address you\'d like your password reset information sent to',
                  fontSize: 14,
                ),
                SizedBox(height: size.height * 0.04),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        fillColor: Theme.of(context).cardColor,
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'youremail@email.com',
                        prefixIcon: IconlyLight.message,
                        validator: (value) {
                          return MyValidators.emailValidator(value);
                        },
                        onFieldSubmited: (_) {
                          // Move focus to the next field when the "next" button is pressed
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.04),

                CustomTextButton(
                  width: double.infinity,
                  borderRadius: 12,
                  icon: IconlyBold.send,
                  backgroundColor: Colors.blueAccent,
                  text: "Request link",
                  onPressed: () async {
                    _forgetPassFCT();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
