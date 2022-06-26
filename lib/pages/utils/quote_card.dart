import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:quote_app/decorations/decoration.dart';
import 'package:quote_app/decorations/styles.dart';
import 'package:quote_app/pages/Favourites/controller/favourite_controller.dart';
import 'package:quote_app/pages/utils/details.dart';

class QuoteCard extends StatefulWidget {
  final String authorName, content, authorId;
  final List<String> tags;
  QuoteCard({
    Key? key,
    required this.authorName,
    required this.content,
    required this.authorId,
    required this.tags,
  }) : super(key: key);

  @override
  State<QuoteCard> createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  bool isLiked = false;
  final FavouriteController _controller = Get.put(FavouriteController());
  LinearGradient grad = pickRandom();

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
            grad: grad,
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
            color: Colors.red,
            borderRadius: BorderRadius.circular(
              12,
            ),
            gradient: grad,
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
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    'Tags:  ',
                    style: normalText,
                  ),
                  for (int i = 0; i < widget.tags.length; i++)
                    Container(
                      margin: const EdgeInsets.all(2),
                      child: Chip(
                        backgroundColor: Colors.white30,
                        label: Text(widget.tags[i]),
                      ),
                    ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                    if (isLiked) {
                      _controller.addtoDatabase(widget.authorId,
                          widget.authorName, widget.content, widget.tags);
                    } else {
                      _controller.deleteFromDatabase(widget.authorId);
                    }
                  },
                  icon: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Icon(
                      isLiked
                          ? FontAwesomeIcons.solidHeart
                          : FontAwesomeIcons.heart,
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
