import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shop_smart_app/roots_app.dart';
import 'package:shop_smart_app/services/my_app_methods.dart';
import 'package:shop_smart_app/widgets/custom_text_button.dart';

class GoogleButton extends StatefulWidget {
  const GoogleButton({super.key});

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  bool _isLoading = false;

  Future<void> _loginWithGoogle() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final googleSignIn = GoogleSignIn();
      final googleAccount = await googleSignIn.signIn();

      if (googleAccount == null) return;

      final googleAuth = await googleAccount.authentication;

      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        if (mounted) {
          await MyAppMethods.showErrorORWarningDialog(
            context: context,
            subtitle: "Failed to get authentication tokens",
            fct: () {},
          );
        }
        return;
      }

      final authResults = await FirebaseAuth.instance.signInWithCredential(
        GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        ),
      );

      if (authResults.additionalUserInfo?.isNewUser ?? false) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(authResults.user!.uid)
            .set({
              'userId': authResults.user!.uid,
              'userName': authResults.user!.displayName,
              'userImage': authResults.user!.photoURL,
              'userEmail': authResults.user!.email,
              'createdAt': Timestamp.now(),
              'userWish': [],
              'userCart': [],
            });
      }

      if (mounted) {
        Navigator.pushReplacementNamed(context, RootsApp.routName);
      }
    } on FirebaseAuthException catch (error) {
      if (mounted) {
        await MyAppMethods.showErrorORWarningDialog(
          context: context,
          subtitle: error.message ?? "Authentication failed",
          fct: () {},
        );
      }
    } catch (error) {
      if (mounted) {
        await MyAppMethods.showErrorORWarningDialog(
          context: context,
          subtitle: "Error: $error",
          fct: () {},
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : CustomTextButton(
            icon: Ionicons.logo_google,
            backgroundColor: Colors.blueAccent,
            borderRadius: 12,
            width: MediaQuery.sizeOf(context).width * 0.85,
            text: "Sign in with Google",
            onPressed: _loginWithGoogle,
          );
  }
}
