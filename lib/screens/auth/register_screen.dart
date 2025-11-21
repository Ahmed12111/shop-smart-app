import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_smart_app/consts/my_validators.dart';
import 'package:shop_smart_app/roots_app.dart';
import 'package:shop_smart_app/screens/loading_manager.dart';
import 'package:shop_smart_app/services/auth_service.dart';
import 'package:shop_smart_app/services/my_app_methods.dart';
import 'package:shop_smart_app/widgets/custom_app_bar_title.dart';
import 'package:shop_smart_app/widgets/custom_snack_bar_widget.dart';
import 'package:shop_smart_app/widgets/custom_sub_title.dart';
import 'package:shop_smart_app/widgets/custom_text_button.dart';
import 'package:shop_smart_app/widgets/custom_text_field.dart';
import 'package:shop_smart_app/widgets/custom_title_text.dart';
import 'package:shop_smart_app/widgets/pick_image_widget.dart';

class RegisterScreen extends StatefulWidget {
  static const routName = '/RegisterScreen';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _nameController,
      _emailController,
      _passwordController,
      _confirmPasswordController;
  late final FocusNode _nameFocusNode,
      _emailFocusNode,
      _passwordFocusNode,
      _confirmPasswordFocusNode;
  late final _formKey = GlobalKey<FormState>();
  bool obscureText1 = true;
  bool obscureText2 = true;
  XFile? pickedImageFile;
  bool isLoading = false;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    // Focus Nodes
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    // Focus Nodes
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  Future<void> registerValidationMethod() async {
    FocusScope.of(context).unfocus();

    if (pickedImageFile == null) {
      CustomSnackbar.showError(context, "Please select a profile image");
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();
    setState(() => isLoading = true);

    try {
      final errorMessage = await AuthService.createUserWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (errorMessage != null) {
        if (!mounted) return;
        CustomSnackbar.showError(context, errorMessage);
        return;
      }

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("Failed to get created user");

      final base64Image = await _convertImageToBase64(
        File(pickedImageFile!.path),
      );

      await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        'userId': user.uid,
        'userName': _nameController.text.trim(),
        'userImage': base64Image,
        'userEmail': _emailController.text.trim().toLowerCase(),
        'createdAt': Timestamp.now(),
        'userWish': [],
        'userCart': [],
      });

      CustomSnackbar.showSuccess(context, "Account created successfully");

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, RootsApp.routName);
    } on FirebaseAuthException catch (error) {
      if (!mounted) return;
      await MyAppMethods.showErrorORWarningDialog(
        context: context,
        subtitle: error.message ?? "Authentication failed",
        fct: () {},
      );
    } catch (error) {
      if (!mounted) return;
      await MyAppMethods.showErrorORWarningDialog(
        context: context,
        subtitle: "Error: $error",
        fct: () {},
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<String> _convertImageToBase64(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    return base64Encode(bytes);
  }

  Future<void> localImagePicker() async {
    final ImagePicker imagePicker = ImagePicker();

    await MyAppMethods.imagePickerDialog(
      context: context,
      camera: () async {
        pickedImageFile = await imagePicker.pickImage(
          source: ImageSource.camera,
        );
        setState(() {});
      },
      gallery: () async {
        pickedImageFile = await imagePicker.pickImage(
          source: ImageSource.gallery,
        );
        setState(() {});
      },
      remove: () {
        setState(() {
          pickedImageFile = null;
        });
      },
    );
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
                children: [
                  SizedBox(height: size.height * 0.06),
                  const CustomAppBarTitle(fontSize: 36),
                  SizedBox(height: size.height * 0.04),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: CustomTitleText(text: "Welcome", fontSize: 26),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomSubTitle(
                      text:
                          "Sign up now to receive special offers and updates from our app.",
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  SizedBox(
                    height: size.width * 0.40,
                    width: size.width * 0.40,
                    child: PickImageWidget(
                      pickedImage: pickedImageFile,
                      onTap: () {
                        localImagePicker();
                      },
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          fillColor: Theme.of(context).cardColor,
                          controller: _nameController,
                          focusNode: _nameFocusNode,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          hintText: "Full name",
                          prefixIcon: IconlyLight.user2,
                          validator: (value) {
                            return MyValidators.displayNamevalidator(value);
                          },
                          onFieldSubmited: (value) {
                            FocusScope.of(
                              context,
                            ).requestFocus(_emailFocusNode);
                          },
                        ),
                        SizedBox(height: size.height * 0.02),
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
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscureText1,
                          hintText: "*********",
                          prefixIcon: IconlyLight.lock,
                          onSuffixIconTap: () {
                            setState(() {
                              obscureText1 = !obscureText1;
                            });
                          },
                          suffixIcon: obscureText1
                              ? Icons.visibility
                              : Icons.visibility_off,
                          validator: (value) {
                            return MyValidators.passwordValidator(value);
                          },
                          onFieldSubmited: (value) {
                            FocusScope.of(
                              context,
                            ).requestFocus(_confirmPasswordFocusNode);
                          },
                        ),
                        SizedBox(height: size.height * 0.02),
                        CustomTextField(
                          fillColor: Theme.of(context).cardColor,
                          controller: _confirmPasswordController,
                          focusNode: _confirmPasswordFocusNode,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscureText2,
                          hintText: "*********",
                          prefixIcon: IconlyLight.lock,
                          onSuffixIconTap: () {
                            setState(() {
                              obscureText2 = !obscureText2;
                            });
                          },
                          suffixIcon: obscureText2
                              ? Icons.visibility
                              : Icons.visibility_off,
                          validator: (value) {
                            return MyValidators.repeatPasswordValidator(
                              value: value,
                              password: _passwordController.text,
                            );
                          },
                          onFieldSubmited: (value) {
                            registerValidationMethod();
                          },
                        ),
                        SizedBox(height: size.height * 0.02),
                        CustomTextButton(
                          text: "Sign up",
                          backgroundColor: Colors.blueAccent,
                          onPressed: () async {
                            registerValidationMethod();
                          },
                          icon: IconlyLight.addUser,
                          width: double.infinity,
                          borderRadius: 12,
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
