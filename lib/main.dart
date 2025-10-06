import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_smart/cubit/active_cubit.dart';
import 'package:shop_smart/screens/home_screen.dart';
import 'package:shop_smart/screens/introductory_screen.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => ActiveCubit(),
      child: const ShopSmart(),
    ),
  );
}

class ShopSmart extends StatelessWidget {
  const ShopSmart({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroductoryScreen(),
    );
  }
}
