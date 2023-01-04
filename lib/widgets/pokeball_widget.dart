import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PokeballWidget extends StatelessWidget {
  final bool isColored;

  const PokeballWidget({Key? key, required this.isColored}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: SvgPicture.asset(isColored
            ? 'assets/pokeball-rouge.svg'
            : 'assets/pokeball-grisee.svg'),
      ),
    );
  }
}
