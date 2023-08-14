import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'detail_screen.dart';
import 'list_of_characters.dart';
import '../responsive.dart';
import '../provider/character_provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: const ListOfCharacter(),
        tablet: Row(
          children: [
            const Expanded(
              flex: 6,
              child: ListOfCharacter(),
            ),
            Expanded(
              flex: 9,
              child: Consumer<CharacterProvider>(
                builder: (context, characterData, child) {
                  final activeCharacter = characterData.findByActive();
                  if (activeCharacter != null) {
                    return DetailsScreen(character: activeCharacter);
                  } else {
                    return const Center(child: Text('No active character'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
