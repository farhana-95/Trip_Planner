
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//for expense category list
class Cat {
  int id;
  String name;
  int icon;

  Cat({required this.id, required this.name, required this.icon});

  factory Cat.fromMap(map) {
    return Cat(
      id: map['id'],
      name: map['name'],
      icon: map['icon'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon':icon,
    };
  }
}
