import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:quote_app/decorations/colors.dart';
import 'package:quote_app/decorations/styles.dart';
import 'package:quote_app/pages/API/models/search_quote.dart';
import 'package:quote_app/pages/API/search.api.dart';
import 'package:quote_app/pages/SearchPage/controller/search_controller.dart';
import 'package:quote_app/pages/utils/quote_card.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  final SearchController _controller = Get.put(SearchController());
  late SearchQuote _quote;
  bool hasSearched = false;
  bool _open = false;
  late String author;
  double _value = 10;

  void _toggle() {
    setState(() {
      _open = !_open;
    });
  }

  Future<void> getAuthor(String author, int limit) async {
    _controller.makeFalse();
    _quote = await SearchQuoteAPI.searchQuoteLimit(author, limit);
    this.author = author;
    _controller.makeTrue();
  }

  Widget quoteCard() {
    //quotes builder
    return _quote.results!.isNotEmpty
        ? ListView.builder(
            physics:
                const BouncingScrollPhysics(parent: BouncingScrollPhysics()),
            itemCount: _quote.count,
            itemBuilder: (context, index) {
              return QuoteCard(
                authorName: _quote.results![index].author!,
                content: _quote.results![index].content!,
                authorId: _quote.results![index].sId!,
                tags: _quote.results![index].tags!,
              );
            },
          )
        : const Center(
            child: Text(
              "Could not find any authors or quotes :(",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontStyle: FontStyle.normal,
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            splashRadius: 100,
            splashColor: Colors.transparent,
            onPressed: () {
              searchController.clear();
            },
            icon: Container(
              padding: const EdgeInsets.only(right: 18.0),
              child: const Icon(
                FontAwesomeIcons.circleXmark,
                color: Colors.grey,
              ),
            ),
          ),
        ],
        leading: IconButton(
          splashRadius: 1,
          splashColor: Colors.transparent,
          onPressed: () {
            Get.back();
          },
          icon: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: const Icon(
              FontAwesomeIcons.arrowLeftLong,
              color: Colors.grey,
            ),
          ),
        ),
        title: TextField(
          controller: searchController,
          style: const TextStyle(
            fontSize: 17,
            color: Colors.black,
          ),
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: "Search for Authors and Quotes...",
          ),
          onSubmitted: (text) {
            getAuthor(text.trim(), _value.toInt());
            if (!hasSearched) {
              setState(() {
                hasSearched = true;
              });
            }
            searchController.clear();
            FocusScope.of(context).requestFocus(FocusNode());
          },
        ),
      ),
      body: SafeArea(
        child: !hasSearched
            ? ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Famous Quotes by Authors',
                            softWrap: true,
                            style: normalText,
                          )),
                      IconButton(
                        onPressed: () {
                          _toggle();
                        },
                        icon: Icon(
                          FontAwesomeIcons.bars,
                          color: Colors.black54,
                        ),
                      )
                    ],
                  ),
                  if (_open)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Quotes Limit',
                            softWrap: true,
                            style: normalText,
                          ),
                        ),
                        Slider(
                          min: 0,
                          max: 100,
                          divisions: 10,
                          activeColor: primaryColor,
                          inactiveColor: Colors.grey.shade200,
                          value: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value;
                            });
                          },
                        ),
                      ],
                    ),
                  for (var val in _controller.sampleData.keys)
                    ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      title: Text(val),
                      subtitle: Text(_controller.sampleData[val]!),
                      onTap: () {
                        if (!hasSearched) {
                          setState(() {
                            hasSearched = true;
                          });
                        }
                        author = val;
                        getAuthor(val, _value.toInt());
                        searchController.clear();
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ),
                ],
              )
            : Obx(
                () => !_controller.isSearched.value
                    ? const Center(
                        child: const CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Quotes by ' + author,
                                  softWrap: true,
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _toggle();
                                },
                                icon: Icon(
                                  FontAwesomeIcons.bars,
                                  color: Colors.black54,
                                ),
                              )
                            ],
                          ),
                          if (_open)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Quotes Limit',
                                    softWrap: true,
                                    style: normalText,
                                  ),
                                ),
                                Slider(
                                  min: 0,
                                  max: 100,
                                  divisions: 10,
                                  activeColor: primaryColor,
                                  inactiveColor: Colors.grey.shade200,
                                  value: _value,
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          Expanded(child: quoteCard()),
                        ],
                      ),
              ),
      ),
    );
  }
}
