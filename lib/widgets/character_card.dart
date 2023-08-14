import 'package:flutter/material.dart';
import '../responsive.dart';
import '../constants.dart';
import '../extensions.dart';
import '../model/character.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    Key? key,
    required this.character,
    required this.press,
  }) : super(key: key);

  final Character character;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    List<String> titleParts = character.title.split('-');
    String firstPart = titleParts.isNotEmpty ? titleParts[0] : '';
    String secondPart = titleParts.length > 1 ? titleParts[1].trimLeft() : '';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: InkWell(
        onTap: press,
        child: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          decoration: BoxDecoration(
            color: (Responsive.isMobile(context))
                ? kBgDarkColor
                : character.isActive
                    ? kPrimaryColor
                    : kBgDarkColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                firstPart,
                style: TextStyle(
                  fontSize: (Responsive.isMobile(context)) ? 16 : 18,
                  fontWeight: FontWeight.w600,
                  color: (Responsive.isMobile(context))
                      ? kTextColor
                      : character.isActive
                          ? Colors.white
                          : kTextColor,
                ),
              ),
              const SizedBox(height: kDefaultPadding / 2),
              Text(
                secondPart,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption!.copyWith(
                      height: 1.5,
                      color: (Responsive.isMobile(context))
                          ? null
                          : character.isActive
                              ? Colors.white70
                              : null,
                    ),
              )
            ],
          ),
        ).addNeumorphism(
          blurRadius: 15,
          borderRadius: 15,
          offset: const Offset(5, 5),
          topShadowColor: Colors.white38,
          bottomShadowColor: const Color(0xFF212763).withOpacity(0.15),
        ),
      ),
    );
  }
}
