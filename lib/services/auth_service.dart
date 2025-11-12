import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  /// Sign in with email & password
  static Future<String?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return 'The email address is badly formatted.';
        case 'user-disabled':
          return 'This user account has been disabled.';
        case 'user-not-found':
          return 'No user found for that email.';
        case 'wrong-password':
          return 'Wrong password provided.';
        case 'invalid-credential':
          return 'Invalid auth credential.';
        case 'operation-not-allowed':
          return 'Email/password sign-in is not enabled.';
        case 'too-many-requests':
          return 'Too many unsuccessful login attempts. Try again later.';
        case 'network-request-failed':
          return 'Network error. Check your connection.';
        default:
          return e.message ?? 'An unknown error occurred. Please try again.';
      }
    } catch (e) {
      return 'Unexpected error: $e';
    }
  }

  /// Create user with email & password
  static Future<String?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'An account already exists for that email.';
        case 'invalid-email':
          return 'The email address is badly formatted.';
        case 'operation-not-allowed':
          return 'Email registration is not enabled.';
        case 'weak-password':
          return 'The password provided is too weak.';
        case 'network-request-failed':
          return 'Network error. Check your connection.';
        default:
          return e.message ?? 'An unknown error occurred. Please try again.';
      }
    } catch (e) {
      return 'Unexpected error: $e';
    }
  }

  /// Send password reset email
  static Future<String?> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return 'Enter a valid email address.';
        case 'missing-email':
          return 'Email address is required.';
        case 'user-not-found':
          return 'No account found for this email.';
        case 'network-request-failed':
          return 'Network error. Check your connection.';
        default:
          return e.message ?? 'An unknown error occurred. Please try again.';
      }
    } catch (e) {
      return 'Unexpected error: $e';
    }
  }

  /// Send email verification to current user
  static Future<String?> sendEmailVerification() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        return null;
      } else {
        return 'No user logged in or email already verified.';
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'too-many-requests':
          return 'Too many requests. Please wait and try again.';
        case 'user-not-found':
          return 'No user found.';
        case 'network-request-failed':
          return 'Network error. Check your connection.';
        default:
          return e.message ?? 'An unknown error occurred. Please try again.';
      }
    } catch (e) {
      return 'Unexpected error: $e';
    }
  }

  /// Sign out
  static Future<String?> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'Error signing out.';
    } catch (e) {
      return 'Unexpected error: $e';
    }
  }

  /// Update password for current user
  static Future<String?> updatePassword(String newPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return 'No user logged in.';
      await user.updatePassword(newPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          return 'The password provided is too weak.';
        case 'requires-recent-login':
          return 'Please re-authenticate to update your password.';
        case 'user-disabled':
          return 'This user account has been disabled.';
        case 'user-not-found':
          return 'No user found.';
        case 'network-request-failed':
          return 'Network error. Check your connection.';
        default:
          return e.message ?? 'An unknown error occurred. Please try again.';
      }
    } catch (e) {
      return 'Unexpected error: $e';
    }
  }

  /// Delete current user account
  static Future<String?> deleteUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return 'No user logged in.';
      await user.delete();
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'requires-recent-login':
          return 'Please re-authenticate to delete your account.';
        case 'user-disabled':
          return 'This user account has been disabled.';
        case 'user-not-found':
          return 'No user found.';
        case 'network-request-failed':
          return 'Network error. Check your connection.';
        default:
          return e.message ?? 'An unknown error occurred. Please try again.';
      }
    } catch (e) {
      return 'Unexpected error: $e';
    }
  }

  /// Re-authenticate the current user
  static Future<String?> reauthenticateUser(
    String email,
    String password,
  ) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return 'No user logged in.';
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await user.reauthenticateWithCredential(credential);
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-mismatch':
          return 'Credentials do not match the user.';
        case 'user-not-found':
          return 'No user found for this email.';
        case 'invalid-credential':
          return 'The credential is invalid or expired.';
        case 'invalid-email':
          return 'The email address is badly formatted.';
        case 'wrong-password':
          return 'Wrong password provided.';
        case 'user-disabled':
          return 'This account has been disabled.';
        case 'network-request-failed':
          return 'Network error. Check your connection.';
        default:
          return e.message ?? 'An unknown error occurred. Please try again.';
      }
    } catch (e) {
      return 'Unexpected error: $e';
    }
  }

  /// Anonymous Sign In
  static Future<String?> signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'operation-not-allowed':
          return 'Anonymous sign-in is not enabled.';
        case 'network-request-failed':
          return 'Network error. Check your connection.';
        default:
          return e.message ?? 'An unknown error occurred. Please try again.';
      }
    } catch (e) {
      return 'Unexpected error: $e';
    }
  }

  // / Google Mobile Sign In
  static Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return "Sign-in cancelled by user.";

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'account-exists-with-different-credential':
          return 'An account already exists with this email but different sign-in method.';
        case 'invalid-credential':
          return 'The credential is malformed or expired.';
        case 'operation-not-allowed':
          return 'Google sign-in is not enabled.';
        case 'user-disabled':
          return 'Account has been disabled.';
        case 'user-not-found':
          return 'No user found with these credentials.';
        case 'network-request-failed':
          return 'Network error. Check your internet connection.';
        default:
          return e.message ?? 'An unknown error occurred. Please try again.';
      }
    } catch (e) {
      return 'Unexpected error: $e';
    }
  }

  /// General Firebase error translator
  static String getFirebaseAuthErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'user-not-found':
        return 'No account found for this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'operation-not-allowed':
        return 'This sign-in method is not enabled.';
      case 'invalid-credential':
        return 'The credential is invalid or expired.';
      case 'too-many-requests':
        return 'Too many unsuccessful login attempts. Try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';
      case 'requires-recent-login':
        return 'Please sign in again to continue.';
      case 'account-exists-with-different-credential':
        return 'Account exists with different sign-in method.';
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }
}
