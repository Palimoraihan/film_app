import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BottomNavbarItem extends StatelessWidget {
  ///This is BottomNavbar
  final int indext;
  final bool isSelected;
  final String title;
  final String image;
  final String selectedImage;
  

  const BottomNavbarItem({super.key, required this.indext, required this.isSelected, required this.title, required this.image, required this.selectedImage});

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 25,width: 25,child: Image.asset(isSelected?selectedImage :image),),
        Text(title, style: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600),)
      ],
    );
  }
}
