import 'package:flutter/material.dart';
import 'package:wapp/constants.dart';

Card specialCard() {
  return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Container(
          height: 220,
          width: 69420,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1.15,
                child: Container(
                  decoration: BoxDecoration(
                      color: dark_blue,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15))),
                  child: Column(
                    children: [],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                ),
              )
            ],
          )));
}
