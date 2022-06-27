import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:quote_app/decorations/styles.dart';
import 'package:typewritertext/typewritertext.dart';

class DetailsPage extends StatefulWidget {
  final String authorName, authorId, context;
  final List<String> tags;
  final LinearGradient grad;
  const DetailsPage(
      {Key? key,
      required this.authorName,
      required this.authorId,
      required this.context,
      required this.tags,
      required this.grad})
      : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool play = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(gradient: widget.grad),
          child: ListView(
            physics:
                const BouncingScrollPhysics(parent: BouncingScrollPhysics()),
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      play = false;
                    });
                    Get.back();
                  },
                  icon: const Icon(FontAwesomeIcons.arrowLeft),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    FontAwesomeIcons.quoteLeft,
                    size: 100,
                    color: Colors.black54,
                  ),
                ),
              ),
              if (mounted)
                (Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TypeWriterText(
                    text: Text(
                      widget.context,
                      style: const TextStyle(
                        fontSize: 40,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true,
                    ),
                    play: play,
                    duration: const Duration(milliseconds: 50),
                  ),
                )),
              const Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    FontAwesomeIcons.quoteRight,
                    size: 50,
                    color: Colors.black54,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  widget.authorName,
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Wrap(
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
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
