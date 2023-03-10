import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A widget that displays the big Pokeball
/// in the middle of the HomeView
class PokeballWidget extends StatelessWidget {
  final bool isColored;

  const PokeballWidget({Key? key, required this.isColored}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Center(
        child: SvgPicture.asset(isColored
            ? 'assets/pokeball-rouge.svg'
            : 'assets/pokeball-grisee.svg'),
      ),
    );
  }
}
