import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quote_app/decorations/styles.dart';
import 'package:quote_app/pages/Favourites/controller/favourite_controller.dart';
import 'package:quote_app/pages/utils/details.dart';

class FavouritesCard extends StatefulWidget {
  final String authorName, content, authorId;
  final List<String> tags;
  const FavouritesCard(
      {Key? key,
      required this.authorName,
      required this.content,
      required this.authorId,
      required this.tags})
      : super(key: key);

  @override
  State<FavouritesCard> createState() => _FavouritesCardState();
}

class _FavouritesCardState extends State<FavouritesCard> {
  final FavouriteController _controller = Get.put(FavouriteController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() {
          return DetailsPage(
            authorName: widget.authorName,
            authorId: widget.authorId,
            context: widget.content,
            tags: widget.tags,
            grad: LinearGradient(
              colors: [
                Colors.pink.shade400,
                Colors.pinkAccent,
                Colors.pink.shade100,
                Colors.white
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          );
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200.withOpacity(0.5),
        ),
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.7),
                blurRadius: 15,
                spreadRadius: 10,
                offset: const Offset(-15, -15),
              ),
              BoxShadow(
                color: Colors.black54.withOpacity(0.2),
                blurRadius: 6,
                spreadRadius: 2,
                offset: const Offset(5, 5),
              ),
            ],
            borderRadius: BorderRadius.circular(
              12,
            ),
            gradient: LinearGradient(
              colors: [
                Colors.pink.shade400,
                Colors.pinkAccent,
                Colors.pink.shade100,
                Colors.white
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                FontAwesomeIcons.quoteLeft,
                size: 35,
              ),
              Text(
                widget.content,
                style: TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                  shadows: [
                    Shadow(
                      color: Colors.white.withOpacity(0.4),
                      blurRadius: 2,
                    )
                  ],
                ),
                softWrap: true,
              ),
              const Align(
                alignment: Alignment.bottomRight,
                child: const Icon(
                  FontAwesomeIcons.quoteRight,
                  size: 20,
                ),
              ),
              Text(
                widget.authorName,
                style: normalText,
              ),
              const SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  onPressed: () {
                    _controller.deleteFromDatabase(widget.authorId);
                  },
                  icon: const Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Icon(
                      FontAwesomeIcons.trashCan,
                      color: Colors.redAccent,
                      size: 30,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
