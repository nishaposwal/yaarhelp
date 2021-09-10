import 'package:yaarhelp/pages/explore.dart';
import 'package:yaarhelp/pages/how-it-works.dart';
import 'package:yaarhelp/pages/main_tabs.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'gig.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<String> list = [
    "assets/images/banner_01.png",
    "assets/images/banner_02.png",
    "assets/images/banner_03.png"
  ];
  Map<String, String> categories = {
    "Online Help": "assets/images/image 24.png",
    "Offline Help": "assets/images/image 25.png",
    "Learn English": "assets/images/image 26.png",
    "Volunteering": "assets/images/image 27.png"
  };

  Map<String, List> subCategories = {
    "Online Help": [
      "Assignment Help",
      "Social Media Help",
      "Art & Design Help",
      'Presentations Help',
      'Programming Help',
      'Question solving Help',
      'Writing Help',
      'Tech Help',
      'Content research Help',
      'Other Help',
    ],
    "Offline Help": [
      'Personal Assistant Help',
      'Organize/Decor Help',
      'Health/Therapy Help',
      'Technical Help',
      'Drop-ship/Moving Help',
      'Baby/Pet Care Help',
      'Cafe/Hotel',
      'Repairing Help',
      'House Help',
      'Other Help'
    ],
  };

  var times = 6;
  Widget subcat(String name) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Text(
        name,
        style: TextStyle(color: Colors.white),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }

  Widget carousel(List<dynamic> list) {
    return CarouselSlider(
      options: CarouselOptions(
          height: 180.0,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          viewportFraction: 1.0),
      items: list.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Image(
                  image: AssetImage(url),
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "yaarhelp",
          style: TextStyle(
              fontFamily: 'Rowdies', color: Color(0xff7ED8D8), fontSize: 24),
        ),
        actions: <Widget>[
          Container(
            height: double.infinity,
            // alignment: AlignmentGeometry(),
            padding: EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HowItWorks(),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.engineering_rounded,
                    color: Theme.of(context).accentColor,
                    size: 30,
                  ),
                  Text(
                    'How It Works',
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 7),
          child: Column(
            children: [
              carousel(list),
              Container(
                // height: 85,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(11),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 4), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                            categories.keys.length,
                            (index) => InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MainTabs(
                                          selectedIndex: 1,
                                          catInExplore: index,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: AssetImage(categories[
                                            categories.keys.elementAt(index)]),
                                        radius: 25,
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        categories.keys.elementAt(index),
                                        style: TextStyle(
                                            fontSize: 12, fontFamily: 'Roboto'),
                                      )
                                    ],
                                  ),
                                ))),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              for (var item in subCategories.keys)
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            item,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            subCategories[item].length,
                            (index) => subcat(
                              subCategories[item][index],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Featured Gigs',
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MainTabs(selectedIndex: 1)));
                              },
                              child: Text(
                                'See All',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('gigs')
                            .orderBy('timeStamp', descending: true)
                            .where('category', isEqualTo: item)
                            .limit(5)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              padding: EdgeInsets.all(100),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            );
                          }
                          return CarouselSlider(
                            options: CarouselOptions(
                                height: 190.0,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 3),
                                viewportFraction: 1.0),
                            items: snapshot.data.docs.map((doc) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Gig(
                                        gig: doc.data() as Map<String, dynamic>,
                                        id: doc.reference.id,
                                        source: 'explore',
                                        subsource: 'home'),
                                  );
                                },
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
