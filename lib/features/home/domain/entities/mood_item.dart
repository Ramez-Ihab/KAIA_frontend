import 'package:flutter/material.dart';
import 'package:kaia/core/entities/look.dart';

class MoodItem {
  final String title;
  final Color color; // fallback while image loads / on error
  final List<Look> looks;

  const MoodItem({
    required this.title,
    required this.color,
    required this.looks,
  });
}
