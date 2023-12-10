import 'package:flutter/material.dart';

extension ListColorX on List<String> {
  List<Color> toListColor() {
    final List<Color> colors = [];

    for (var color in this) {
      colors.add(nameToColor(color));
    }

    return colors;
  }
}

Color nameToColor(String colorName) {
  colorName = colorName.toLowerCase();
  switch (colorName) {
    case 'red':
      return Colors.red;
    case 'blue':
      return Colors.blue;
    case 'green':
      return Colors.green;
    case 'yellow':
      return Colors.yellow;
    case 'purple':
      return Colors.purple;
    case 'orange':
      return Colors.orange;
    case 'pink':
      return Colors.pink;
    case 'brown':
      return Colors.brown;
    case 'cyan':
      return Colors.cyan;
    case 'teal':
      return Colors.teal;
    case 'amber':
      return Colors.amber;
    case 'indigo':
      return Colors.indigo;
    case 'lime':
      return Colors.lime;
    case 'black':
      return Colors.black;
    case 'white':
      return const Color(0xFFF1EFF0);
    case 'grey':
      return Colors.grey;
    case 'deepPurple':
      return Colors.deepPurple;
    case 'deepOrange':
      return Colors.deepOrange;
    case 'lightBlue':
      return Colors.lightBlue;
    case 'lightGreen':
      return Colors.lightGreen;
    case 'amberAccent':
      return Colors.amberAccent;
    case 'lightGreenAccent':
      return Colors.lightGreenAccent;
    case 'indigoAccent':
      return Colors.indigoAccent;
    case 'pinkAccent':
      return Colors.pinkAccent;
    case 'purpleAccent':
      return Colors.purpleAccent;
    case 'tealAccent':
      return Colors.tealAccent;
    case 'blueAccent':
      return Colors.blueAccent;
    case 'redAccent':
      return Colors.redAccent;
    case 'yellowAccent':
      return Colors.yellowAccent;
    case 'cyanAccent':
      return Colors.cyanAccent;
    case 'lightBlueAccent':
      return Colors.lightBlueAccent;
    // Add more colors as needed
    default:
      return Colors
          .black; // Default to black if the color name is not recognized
  }
}
