import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

import '../model/character.dart';
import '../widgets/details_image.dart';
import '../constants.dart';
import '../responsive.dart';

class DetailsScreen extends StatelessWidget {
  final Character character;
  const DetailsScreen({super.key, required this.character});

  Future<void> _launchURL() async {
    final Uri url = Uri.parse(character.firstURL);
    if (!await launchUrl(url)) {
      const AlertDialog(
        title: Text('Not opening'),
        content: Text('Can not open url'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<String> titleParts = character.title.split('-');
    String firstPart = titleParts.isNotEmpty ? titleParts[0] : '';
    String secondPart = titleParts.length > 1 ? titleParts[1].trimLeft() : '';
    return character.title.isNotEmpty
        ? Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: size.height / 2.5,
                    pinned: false,
                    elevation: 50,
                    backgroundColor: Colors.white,
                    leading: Responsive.isMobile(context)
                        ? IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: kSecondaryColor,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        : null,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        children: [
                          ClipPath(
                            clipper: MyClipper(),
                            child: Stack(
                              children: [
                                DetailsImage(
                                    imageUrl: character.image!,
                                    width: double.infinity,
                                    height: size.height - (size.height / 2.5)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Container(
                          padding: const EdgeInsets.only(
                              top: 10, left: 16, right: 16.0),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      firstPart,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: _launchURL,
                                      icon: const Icon(
                                        Icons.open_in_browser,
                                        color: kPrimaryColor,
                                        size: 35,
                                      ))
                                ],
                              ),
                              Text(
                                secondPart,
                                style: const TextStyle(
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: kDefaultPadding + 10),
                            ],
                          ),
                        );
                      },
                      childCount: 1,
                    ),
                  ),
                ],
              ),
            ))
        : const Center(child: CircularProgressIndicator());
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 50;
    double pi = 3.14;
    Path path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width, size.height - radius)
      ..arcTo(
        Rect.fromCircle(
          center: Offset(size.width - radius, size.height - radius),
          radius: radius,
        ),
        0,
        0.5 * pi,
        false,
      )
      ..lineTo(radius, size.height)
      ..lineTo(0, size.height - radius) // Adjusted to remove the slope line
      ..arcTo(
        Rect.fromCircle(
          center: Offset(radius, size.height - radius),
          radius: radius,
        ),
        0.5 * pi,
        0.5 * pi,
        false,
      )
      ..lineTo(0, radius) // Adjusted to start from top-left corner
      ..arcTo(
        Rect.fromCircle(
          center: Offset(radius, radius),
          radius: radius,
        ),
        1 * pi,
        0.5 * pi,
        false,
      )
      ..lineTo(size.width - radius, 0) // Adjusted to remove the slope line
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
