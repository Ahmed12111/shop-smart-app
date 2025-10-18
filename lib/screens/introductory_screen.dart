import 'package:flutter/material.dart';
import 'package:shop_smart/screens/create_account_screen.dart';
import 'package:shop_smart/screens/home_screen.dart';
import 'package:shop_smart/widgets/custom_text_button.dart';

class IntroductoryScreen extends StatelessWidget {
  const IntroductoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color.fromARGB(255, 191, 171, 252),
              Color(0xFF9775FA),
              Color.fromARGB(255, 136, 98, 250),
              Color.fromARGB(255, 131, 92, 250),
              Color.fromARGB(255, 121, 78, 252),
            ],
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Column(
              children: <Widget>[
                Image.asset(
                  "assets/smiling-pretty-girl-with-wavy-hairstyle-standing-one-leg-purple-wall-cheerful-brunette-female-model-dancing-white-sneakers-removebg 1.png",
                ),
              ],
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.width * 0.1,
              left: MediaQuery.of(context).size.width * 0.05,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.90,
                height: 244,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "Look Good, Feel Good",
                        style: TextStyle(
                          color: Color(0xFF1D1E20),
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        "Create your individual & unique style and look amazing everyday.",
                        style: TextStyle(
                          color: Color(0xFF8F959E),
                          fontSize: 15,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            width: 152,
                            height: 60,
                            child: CustomTextButton(
                              onPressed: (){
                                Navigator.push(context,
                                MaterialPageRoute(builder: (context) => HomeScreen()));
                              },
                              backGroundColor: Color(0xFFF5F6FA),
                              text: "Men",
                              textColor: Color(0xFF8F959E),
                            ),
                          ),
                          SizedBox(
                            width: 152,
                            height: 60,
                            child: CustomTextButton(
                              onPressed: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => HomeScreen()));
                              },
                              backGroundColor: Color(0xFF9775FA),
                              text: "Women",
                              textColor: Color(0xFFFFFFFF),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return CreateAccountScreen();
                              },
                            ),
                          );
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            color: Color(0xFF8F959E),
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
