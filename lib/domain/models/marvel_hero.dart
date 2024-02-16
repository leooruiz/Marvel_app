// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// import 'package:floor/floor.dart';

// @entity
class MarvelHero {
  // @primaryKey
  String? name; //TODO mudar para não nullable
  int? id; //TODO mudar para não nullable
  String? description;
  String? image;
  MarvelHero({
    this.name,
    this.id,
    this.description,
    this.image,
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
      id: map['id'] as int,
      description: map['description'],
      image: map['thumbnail']['path'] + '.' + map['thumbnail']['extension'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MarvelHero.fromJson(String source) =>
      MarvelHero.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Hero(name: $name, id: $id, description: $description, image: $image)';
  }
}
