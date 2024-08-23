// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PageEntity {
  final String path;
  final Widget page;
  final String? title;
  final IconData? icon;
  PageEntity({
    required this.path,
    required this.page,
    this.title,
    this.icon,
  });
}
