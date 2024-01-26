import 'package:flutter/material.dart';

class Item {
  String id;
  String name;

  Item({String id = '', required this.name}) : id = id.isEmpty ? UniqueKey().toString() : id;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Item && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
