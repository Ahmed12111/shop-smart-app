import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconly/iconly.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => IconButton(
            icon: SvgPicture.asset("assets/menu (1).svg"),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {}, 
              icon: SvgPicture.asset("assets/Bag.svg"),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        shape: LinearBorder(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 32,
                horizontal: 4.0,
              ),
              child: Builder(
                builder: (context) {
                  return IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Color(0xFFF5F5F5),
                    ),
                    onPressed: (){
                      Scaffold.of(context).closeDrawer();
                    }, 
                    icon: SvgPicture.asset(
                      "assets/menu.svg",
                    ),
                  );
                }
              ),
            )
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hello',
              style: TextStyle(
                color: Color(0xFF1D1E20),
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Welcome to Laza.',
              style: TextStyle(
                color: Color(0xFF8F959E),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(
                      color: Color(0xFF8F959E),
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF5F6FA),
                      prefixIcon: Icon(
                        IconlyLight.search,
                        color: Color(0xFF8F959E),
                      ),
                      border: InputBorder.none,
                      hintText: "Search...",
                      hintStyle: TextStyle(
                        color: Color(0xFF8F959E),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
