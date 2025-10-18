import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_smart/screens/sign_up_screen.dart';
import 'package:shop_smart/widgets/custom_text_button.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

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
                'Let’s Get Started',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
            
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                height: 50,
                child: CustomTextButton(
                  onPressed: () {},
                  backGroundColor: Color(0xFF4267B2),
                  textColor: Color(0xFFFEFEFE),
                  text: "Facebook",
                  iconData: Icon(
                    FontAwesomeIcons.facebookF,
                    color: Colors.white,
                  ),
                ),
              ),
            
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                height: 50,
                child: CustomTextButton(
                  onPressed: () {},
                  backGroundColor: Color(0xFF1DA1F2),
                  textColor: Color(0xFFFEFEFE),
                  text: "Twitter",
                  iconData: Icon(FontAwesomeIcons.twitter, color: Colors.white),
                ),
              ),
            
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                height: 50,
                child: CustomTextButton(
                  onPressed: () {},
                  backGroundColor: Color(0xFFEA4335),
                  textColor: Color(0xFFFEFEFE),
                  text: "Google",
                  iconData: Icon(FontAwesomeIcons.google, color: Colors.white),
                ),
              ),
            
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Already have an account? ",
                    style: TextStyle(color: Color(0xFF8F959E), fontSize: 15),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Signin",
                      style: TextStyle(
                        color: Color(0xFF1D1E20),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                height: MediaQuery.of(context).size.height * 0.07,
                child: CustomTextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (contex) {
                          return SignUpScreen();
                        },
                      ),
                    );
                  },
                  backGroundColor: Color(0xFF9775FA),
                  textColor: Color(0xFFFEFEFE),
                  text: "Create an Account",
                ),
              ),
        
              
            ],
          ),
        ),
      ),
    );
  }
}
