
import 'package:doan6/pages/cart/cart_history.dart';
import 'package:doan6/pages/food/heart_food.dart';
import 'package:doan6/pages/home/main_food_page.dart';
import 'package:doan6/pages/login/sign_up_page.dart';
import 'package:doan6/pages/profile/account_page.dart';
import 'package:doan6/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //late PersistentTabController _controller;



  int _selectIndex=0;
  List pages=[
    MainFoodPage(),
    HeartFood(),
    CartHistory(),
    AccountPage(),
  ];
  void onTapNavition(int index){
    setState(() {
      _selectIndex=index;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // _controller = PersistentTabController(initialIndex: 0);
  }
  // List<Widget> _buildScreens() {
  //   return [
  //     MainFoodPage(),
  //     Container(
  //       child: Text('next'),
  //     ),
  //     Container(
  //       child: Text('2next'),
  //     ),
  //     Container(
  //       child: Text('3next'),
  //     )
  //   ];
  // }
  // List<PersistentBottomNavBarItem> _navBarsItems() {
  //   return [
  //     PersistentBottomNavBarItem(
  //       icon: Icon(CupertinoIcons.home),
  //       title: ("Home"),
  //       activeColorPrimary: CupertinoColors.activeBlue,
  //       inactiveColorPrimary: CupertinoColors.systemGrey,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(CupertinoIcons.archivebox_fill),
  //       title: ("Settings"),
  //       activeColorPrimary: CupertinoColors.activeBlue,
  //       inactiveColorPrimary: CupertinoColors.systemGrey,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(CupertinoIcons.cart_fill),
  //       title: ("Home"),
  //       activeColorPrimary: CupertinoColors.activeBlue,
  //       inactiveColorPrimary: CupertinoColors.systemGrey,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(CupertinoIcons.person),
  //       title: ("Settings"),
  //       activeColorPrimary: CupertinoColors.activeBlue,
  //       inactiveColorPrimary: CupertinoColors.systemGrey,
  //     ),
  //   ];
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.deepOrangeAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0.0,
        unselectedFontSize:0.0 ,
        onTap: onTapNavition,
        currentIndex: _selectIndex,
        items: [
          const BottomNavigationBarItem(
               icon: Icon(Icons.home_outlined),
           label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border),
              label: "Favorite"),
          // BottomNavigationBarItem(icon: Icon(Icons.history_outlined),
          //     label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined),
              label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline),
              label: "User"),


        ],
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return PersistentTabView(
  //     context,
  //     controller: _controller,
  //     screens: _buildScreens(),
  //     items: _navBarsItems(),
  //     confineInSafeArea: true,
  //     backgroundColor: Colors.white, // Default is Colors.white.
  //     handleAndroidBackButtonPress: true, // Default is true.
  //     resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
  //     stateManagement: true, // Default is true.
  //     hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
  //     decoration: NavBarDecoration(
  //       borderRadius: BorderRadius.circular(10.0),
  //       colorBehindNavBar: Colors.white,
  //     ),
  //     popAllScreensOnTapOfSelectedTab: true,
  //     popActionScreens: PopActionScreensType.all,
  //     itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
  //       duration: Duration(milliseconds: 200),
  //       curve: Curves.ease,
  //     ),
  //     screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
  //       animateTabTransition: true,
  //       curve: Curves.ease,
  //       duration: Duration(milliseconds: 200),
  //     ),
  //     navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
  //   );
  // }
}
