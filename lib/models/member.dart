import 'package:flutter/material.dart';

class Member {
  final String name;
  final String role;
  final String altRole;
  final Color altColor;
  final String imgURL;
  final String desc;

  Member(
      {required this.name,
      required this.role,
      required this.altRole,
      required this.altColor,
      required this.imgURL,
      required this.desc});
}
