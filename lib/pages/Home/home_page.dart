import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quote_app/decorations/colors.dart';
import 'package:quote_app/decorations/styles.dart';
import 'package:quote_app/pages/API/models/random_quote.dart';
import 'package:quote_app/pages/API/random_quote.api.dart';
import 'package:quote_app/pages/Home/controller/home_controller.dart';
import 'package:quote_app/pages/SearchPage/search_page.dart';
import 'package:quote_app/pages/utils/quote_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late RandomQuote quotes;
  TextEditingController searchController = TextEditingController();
  HomeController controller = Get.put(HomeController());
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    //API get quotes
    getQuotes();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> getQuotes() async {
    quotes = await RandomQuoteAPI.getQuotes();
    //change loading
    controller.changeLoading();
  }

  void _onRefresh() async {
    controller.changeLoading();
    quotes = await RandomQuoteAPI.getQuotes();
    controller.changeLoading();
    _refreshController.refreshCompleted();
  }

  Widget quoteCard() {
    //quotes builder
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      enablePullDown: true,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(parent: BouncingScrollPhysics()),
        itemCount: quotes.count,
        itemBuilder: (context, index) {
          return QuoteCard(
            authorName: quotes.results![index].author!,
            content: quotes.results![index].content!,
            authorId: quotes.results![index].sId!,
            tags: quotes.results![index].tags!,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        elevation: 0,
        leading: IconButton(
          splashRadius: 100,
          splashColor: Colors.transparent,
          onPressed: () {
            Get.to(() {
              return SearchPage();
            });
          },
          icon: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Icon(
              FontAwesomeIcons.magnifyingGlass,
              color: greyColor,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                'Find your "Quotes"',
                style: header,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              //state management
              child: Obx(
                () => controller.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : quoteCard(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
