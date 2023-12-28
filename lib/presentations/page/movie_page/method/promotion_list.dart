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
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: promotionImageFile
              .map(
                (fileImage) => Container(
                  width: 240,
                  height: 160,
                  margin: EdgeInsets.only(left: fileImage==promotionImageFile.first?24:10, right: fileImage==promotionImageFile.last?24:0),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/image/$fileImage')),
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
              )
              .toList(),
        ),
      ),
    ];
