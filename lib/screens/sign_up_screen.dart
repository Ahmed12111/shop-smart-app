import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_smart/cubit/active_cubit.dart';
import 'package:shop_smart/cubit/active_state.dart';
import 'package:shop_smart/screens/login_screen.dart';
import 'package:shop_smart/widgets/custom_text_button.dart';
import 'package:shop_smart/widgets/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ActiveCubit activeController = context.read<ActiveCubit>();
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
                'Sign Up',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              ),
    
              SizedBox(height: MediaQuery.of(context).size.height * 0.22),
    
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomTextField(text: 'Username'),
              ),
    
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
    
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomTextField(text: 'Email'),
              ),
    
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
    
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomTextField(text: 'Password'),
              ),
    
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
    
              BlocBuilder<ActiveCubit, ActiveState>(
                builder: (context, state) {
                  return SwitchListTile(
                    inactiveTrackColor: Color(0xFFE7E8EA),
                    activeThumbColor: Colors.white,
                    activeTrackColor: Color(0xFF34C559),
                    title: Text(
                      'Remember me',
                      style: TextStyle(
                        color: Color(0xFF1D1E20),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    value: activeController.state.isActive,
                    onChanged: (val) {
                      activeController.changeStatus();
                    },
                  );
                },
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.14),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                height: MediaQuery.of(context).size.height * 0.07,
                child: CustomTextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (contex) {
                          return LoginScreen();
                        },
                      ),
                    );
                  },
                  backGroundColor: Color(0xFF9775FA),
                  textColor: Color(0xFFFEFEFE),
                  text: "Sign Up",
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
