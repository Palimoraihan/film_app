import 'package:flutter/material.dart';

Widget profileItem(String title, {VoidCallback? onTap}) => Padding(
  padding: const EdgeInsets.only(top: 20),
  child:   GestureDetector(
    onTap: onTap,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
      Text(title),
      Icon(Icons.arrow_forward_ios_rounded, size: 18,)
    ],),
  ),
);
