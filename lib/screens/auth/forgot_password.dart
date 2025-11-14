import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shop_smart_app/consts/my_validators.dart';
import 'package:shop_smart_app/services/assets_manager.dart';
import 'package:shop_smart_app/services/auth_service.dart';
import 'package:shop_smart_app/widgets/custom_app_bar_title.dart';
import 'package:shop_smart_app/widgets/custom_sub_title.dart';
import 'package:shop_smart_app/widgets/custom_text_button.dart';
import 'package:shop_smart_app/widgets/custom_text_field.dart';
import 'package:shop_smart_app/widgets/custom_title_text.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/ForgotPasswordScreen';
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _forgetPassFCT() async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);

    try {
      final error = await AuthService.sendPasswordResetEmail(
        _emailController.text.trim(),
      );

      if (!mounted) return;

      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error), backgroundColor: Colors.red),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Reset link sent! Check your email'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
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
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(height: size.height * 0.04),
              Image.asset(
                AssetsManager.forgotPassword,
                width: size.width * 0.5,
                height: size.width * 0.5,
              ),
              SizedBox(height: size.height * 0.02),
              const CustomTitleText(text: 'Forgot password', fontSize: 22),
              SizedBox(height: size.height * 0.02),
              const CustomSubTitle(
                text: 'Enter your email to receive a password reset link',
                fontSize: 14,
              ),
              SizedBox(height: size.height * 0.04),
              Form(
                key: _formKey,
                child: CustomTextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'youremail@email.com',
                  prefixIcon: IconlyLight.message,
                  validator: MyValidators.emailValidator,
                  textInputAction: TextInputAction.done,
                  onFieldSubmited: (_) => _forgetPassFCT(),
                ),
              ),
              SizedBox(height: size.height * 0.04),
              CustomTextButton(
                width: double.infinity,
                borderRadius: 12,
                icon: IconlyBold.send,
                backgroundColor: Colors.blueAccent,
                text: _isLoading ? 'Sending...' : 'Request link',
                onPressed: _forgetPassFCT,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
