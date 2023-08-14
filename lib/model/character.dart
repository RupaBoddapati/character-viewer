import 'package:flutter/cupertino.dart';

class Character {
  final String title;
  final String? image;
  final String description;
  final String firstURL;
  bool isActive;
  final UniqueKey id;

  Character({
    required this.title,
    this.image,
    required this.description,
    required this.firstURL,
    required this.id,
    this.isActive = false,
  });

  factory Character.fromJson(Map<String, dynamic> json, int index) {
    return Character(
      id: UniqueKey(),
      title: json['Text'],
      image: json['Icon']?['URL'],
      description: json['Result'],
      firstURL: json['FirstURL'],
    );
  }
}
