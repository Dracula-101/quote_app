import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:quote_app/decorations/styles.dart';
import 'package:quote_app/pages/Favourites/controller/favourite_controller.dart';
import 'package:quote_app/pages/utils/favourites_quote_card.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  FavouriteController _controller = Get.put(FavouriteController());

  List<String> getData(String data) {
    return data.split(', ').toList();
  }

  List<String> getTags(String tags) {
    tags = tags.removeAllWhitespace;
    tags.replaceAll('[', '');
    tags.replaceAll(']', '');
    return tags.split(',').toList();
  }

  Widget showNoFav(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 100),
        Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.6,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    FontAwesomeIcons.quoteLeft,
                    size: 100,
                    color: Colors.deepPurple,
                  ),
                  Text(
                    "Add Favourites to see your quotes here",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "lorabold700",
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                      // decorationThickness: 10,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ]),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.deleteAll();
        },
        child: Icon(
          FontAwesomeIcons.trashCanArrowUp,
          color: Colors.red.shade700,
        ),
        backgroundColor: Colors.white60,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'F A V O U R I T E S',
                style: header,
              ),
            ),
            Obx(
              () => _controller.favourites.isNotEmpty
                  ? Expanded(
                      child: GetX<FavouriteController>(
                        init: FavouriteController(),
                        initState: (_) {},
                        builder: (_) {
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            itemCount: _controller.favourites.length,
                            itemBuilder: ((context, index) {
                              List<String> data = getData(
                                  _.favourites.elementAt(index).toString());
                              return Obx(() => _controller.favourites.isEmpty
                                  ? showNoFav(context)
                                  : FavouritesCard(
                                      authorName: _controller.favourites
                                          .elementAt(index)['authorName'],
                                      content: _controller.favourites
                                          .elementAt(index)['content']
                                          .replaceAll('_', " "),
                                      authorId: _controller.favourites
                                          .elementAt(index)['authorId'],
                                      tags: _controller.favourites
                                          .elementAt(index)['tags']
                                          .split(',')
                                          .toList(),
                                    ));
                            }),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: showNoFav(context),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
