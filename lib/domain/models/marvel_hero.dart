import 'dart:convert';

import 'package:equatable/equatable.dart';

class MarvelHero extends Equatable {
  final String name;
  final int id;
  final String description;
  final String image;
  const MarvelHero({
    required this.name,
    required this.id,
    required this.description,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'description': description,
      'image': image,
    };
  }

  factory MarvelHero.fromMap(Map<String, dynamic> map) {
    return MarvelHero(
      name: map['name'],
      id: map['id'],
      description: map['description'],
      image: map['thumbnail']['path'] + '.' + map['thumbnail']['extension'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Hero(name: $name, id: $id, description: $description, image: $image)';
  }

  @override
  List<Object?> get props => [name, id, description, image];
}
