import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/display_empty.dart';
import '../model/character.dart';
import '../widgets/character_card.dart';
import '../responsive.dart';
import '../constants.dart';
import '../Screens/detail_screen.dart';
import '../provider/character_provider.dart';

class ListOfCharacter extends StatefulWidget {
  const ListOfCharacter({Key? key}) : super(key: key);

  @override
  State<ListOfCharacter> createState() => _ListOfCharacterState();
}

class _ListOfCharacterState extends State<ListOfCharacter>
    with SingleTickerProviderStateMixin {
  late Future<List<Character>> _charactersFuture = Future.value([]);
  String searchText = '';
  String? appName;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      appName = prefs.getString('appName');
      final characterProvider = Provider.of<CharacterProvider>(
        context,
        listen: false,
      );
      characterProvider.prefs = prefs;
      characterProvider.httpClient = http.Client();
      _charactersFuture = characterProvider.getCharacters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(kDefaultPadding - 4),
        color: kBgDarkColor,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                appName ?? 'Character Viewer',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold, color: kPrimaryColor),
              ),
              const SizedBox(height: kDefaultPadding),
              TextField(
                onChanged: (text) {
                  searchText = text;
                  setState(() {});
                },
                decoration: const InputDecoration(
                  hintText: "Search",
                  fillColor: kBgLightColor,
                  filled: true,
                  prefixIcon: Padding(
                      padding: EdgeInsets.all(kDefaultPadding * 0.75), //15
                      child: Icon(Icons.search, color: Colors.grey)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: kDefaultPadding),
              _buildCharactersList(),
            ],
          ),
        ),
      ),
    );
  }

  void cardPressHandler(Character character) {
    if (Responsive.isMobile(context)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsScreen(character: character),
        ),
      );
    } else {
      Provider.of<CharacterProvider>(context, listen: false)
          .setActive(character.id);
    }
  }

  Widget _buildCharactersList() {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: _initializeData,
        child: FutureBuilder<List<Character>>(
          future: _charactersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return DisplayEmpty(
                onButtonPress: _initializeData,
                image: 'images/error.jpg',
                message: 'Oops! Something went wrong',
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return DisplayEmpty(
                onButtonPress: _initializeData,
                image: 'images/empty.webp',
                message: 'Oops! No characters to display',
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final character = snapshot.data![index];
                  final matchesSearch = searchText.isEmpty ||
                      character.title
                          .toLowerCase()
                          .contains(searchText.toLowerCase()) ||
                      character.description
                          .toLowerCase()
                          .contains(searchText.toLowerCase());
                  return matchesSearch
                      ? Consumer<CharacterProvider>(
                          builder: (context, characterProvider, child) {
                          return CharacterCard(
                              character: character,
                              press: () {
                                cardPressHandler(character);
                              });
                        })
                      : const SizedBox(height: 0);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
