import 'package:flutter/material.dart';
import 'package:shop_smart/screens/verification_code_screen.dart';
import 'package:shop_smart/widgets/custom_text_button.dart';
import 'package:shop_smart/widgets/custom_text_field.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

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
                'Forgot Password',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1D1E20),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.04),

              Image.asset("assets/IMG.png"),

              SizedBox(height: MediaQuery.of(context).size.height * 0.08),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomTextField(text: 'Email'),
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
                          text:
                              "Please write your email to receive a confirmation code to set a new password.",
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
                          return VerificationCodeScreen();
                        },
                      ),
                    );
                  },
                  backGroundColor: Color(0xFF9775FA),
                  textColor: Color(0xFFFEFEFE),
                  text: "Confirm Mail",
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
