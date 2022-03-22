import 'package:flutter/material.dart';
import 'package:global_conference/const.dart';

class ProfileBottomNav extends StatelessWidget {
  const ProfileBottomNav({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.primary,
      unselectedItemColor: Colors.white,
      selectedItemColor: AppColors.orange,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), label: 'Profile'),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month), label: 'Something'),
      ],
    );
  }
}
