import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:shop_smart/screens/new_password_screen.dart';
import 'package:shop_smart/widgets/custom_text_button.dart';

class VerificationCodeScreen extends StatelessWidget {
  const VerificationCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          backgroundColor: Color.fromARGB(159, 241, 241, 241),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_outlined, color: Color(0xFf1D1E20)),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Verification Code',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1D1E20),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.04),

              Image.asset("assets/IMG.png"),

              SizedBox(height: MediaQuery.of(context).size.height * 0.08),

              OtpTextField(
                numberOfFields: 4,
                showFieldAsBox: true,
                contentPadding: EdgeInsets.all(32),
                fieldWidth: 77,
                fieldHeight: 100,
                textStyle: TextStyle(
                  color: Color(0xFF1D1E20),
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
                borderRadius: BorderRadius.circular(10),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.20),

              SizedBox(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16.0,
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "00:20",
                          style: TextStyle(
                            color: Color(0xFF1D1E20),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: " resend confirmation code.",
                          style: TextStyle(
                            color: Color(0xFF8F959E),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                height: MediaQuery.of(context).size.height * 0.07,
                child: CustomTextButton(
                  onPressed: () {
                    // Logic Of Confirmation
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return NewPasswordScreen();
                        },
                      ),
                    );
                  },
                  backGroundColor: Color(0xFF9775FA),
                  textColor: Color(0xFFFEFEFE),
                  text: "Confirm Code",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
