import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
        title: 'My Custom Title',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController pageController = PageController();
  int pageCount = 3; // Set this to the number of slides

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      int nextPage = (pageController.page!.round() + 1) % pageCount;
      pageController.animateToPage(nextPage,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.fastLinearToSlowEaseIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Container(
          child: SizedBox(
            width: 100,
            child: Image.asset(
              "assets/logo.png",
              color: Colors.blue,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      "Your Location",
                      style: TextStyle(color: Colors.black),
                    ),
                    Icon(
                      Icons.location_on,
                      size: 18,
                      color: Colors.black,
                    ),
                  ],
                ),
                Text(
                  "CURRENT LOCATION",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        child: ListView(children: [
          LimitedBox(
            maxHeight: 250,
            child: Stack(
              children: [
                PageView(
                  controller: pageController,
                  children: const [
                    AdsSlideCard(slideImage: "assets/f1.jpg"),
                    AdsSlideCard(slideImage: "assets/f3.jpg"),
                    AdsSlideCard(slideImage: "assets/f4.jpg"),
                  ],
                ),
                Positioned(
                  bottom: 18.0,
                  left: 0.0,
                  right: 0.0,
                  child: Center(child: SlideIndicator(pageController)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                MenuFeature(iconAsset: 'assets/m_tuktuk.png', name: "Taxi"),
                MenuFeature(iconAsset: 'assets/m_express.png', name: 'Express'),
                MenuFeature(iconAsset: 'assets/m_food.png', name: 'Food'),
                MenuFeature(iconAsset: 'assets/m_flower.png', name: 'Grocery'),
                MenuFeature(iconAsset: 'assets/m_grocery.png', name: 'Flower'),
                MenuFeature(iconAsset: 'assets/m_shop.png', name: 'Shop'),
                MenuFeature(iconAsset: 'assets/m_bakery.png', name: 'Bakery'),
                MenuFeature(iconAsset: 'assets/m_alcohol.png', name: 'Alcohol'),
              ],
            ),
          ),
          Container(color: Colors.grey[200], height: 8),
          const Text(
            "Trending Now",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LimitedBox(
              maxHeight: 202,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  TrandingCard(),
                  TrandingCard(),
                  TrandingCard()
                ],
              ),
            ),
          ),
          Container(color: Colors.grey[200], height: 8),
          const PromotoShopCard(image: 'assets/f8.jpg'),
          const PromotoShopCard(image: 'assets/f9.jpg'),
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Track",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox),
            label: "Inbox",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Account",
          ),
        ],
      ),
    );
  }
}

class AdsSlideCard extends StatelessWidget {
  const AdsSlideCard({required this.slideImage});
  final String slideImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              slideImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class MenuFeature extends StatelessWidget {
  final String iconAsset;
  final String name;
  const MenuFeature({super.key, required this.iconAsset, required this.name});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 50, height: 50, child: Image.asset(iconAsset)),
            Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class TrandingCard extends StatelessWidget {
  const TrandingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: 200,
        width: 200,
        child: ClipRRect(
          child: Image.asset(
            "assets/f6.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class SlideIndicator extends AnimatedWidget {
  final PageController pageController;

  SlideIndicator(this.pageController) : super(listenable: pageController);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List<Widget>.generate(3, buildIndicator),
    );
  }

  Widget buildIndicator(int index) {
    final currentPage =
        pageController.page ?? pageController.initialPage.toDouble();
    bool active = currentPage.round() == index;

    double select = max(0.0, 1.0 - (currentPage - index).abs());
    double decrease = 10 * select;

    return Container(
      width: 30,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Center(
        child: Container(
          width: 20 - decrease,
          height: 5,
          decoration: BoxDecoration(
            color: active ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class PromotoShopCard extends StatelessWidget {
  final String image;
  const PromotoShopCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width -
            MediaQuery.of(context).size.width / 3,
        child: ClipRRect(
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
