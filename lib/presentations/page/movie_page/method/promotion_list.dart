import 'package:flutter/material.dart';

List<Widget> promotionList(
        List<String> promotionImageFile, BuildContext context) =>
    [
      Padding(
        padding: EdgeInsets.only(left: 24, bottom: 15),
        child: Text(
          'Promotion',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(),)
    ];
