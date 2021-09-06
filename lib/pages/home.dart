import 'package:yaarhelp/pages/how-it-works.dart';
import 'package:yaarhelp/pages/main_tabs.dart';
import 'package:flutter/material.dart';
import 'package:yaarhelp/pages/profile/profile.dart';
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
    "https://prosesoft.com/images/e3.jpg",
    "https://shribalajiplacement.com/wp-content/uploads/2021/03/carpenter-sawing-wood-table_7496-936.jpg",
    "https://www.meiccymru.org/wp-content/uploads/2018/06/volunteer-2055042_1920-1024x706.png"
  ];
  Map<String, String> categories = {
    "Online Help":
        "https://cdn.pixabay.com/photo/2015/09/16/08/55/online-942406_1280.jpg",
    "Offline Help": "https://i.ytimg.com/vi/OBfLvqA_E4A/maxresdefault.jpg",
    "Learn English":
        "https://cdn2.vectorstock.com/i/1000x1000/67/01/its-time-to-learn-english-sign-or-stamp-vector-21476701.jpg",
    "Volunteering":
        "https://webgate.ec.europa.eu/fpfis/wikis/download/thumbnails/285091230/ESC_VoluPart_What.png?version=1&modificationDate=1530888095124&api=v2"
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
          height: 150.0,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          viewportFraction: 1.0),
      items: list.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Image(
                  image: NetworkImage(url),
                  fit: BoxFit.fill,
                ));
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
                height: 85,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (var item in categories.keys)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(categories[item]),
                            radius: 25,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            item,
                            style:
                                TextStyle(fontSize: 12, fontFamily: 'Roboto'),
                          )
                        ],
                      )
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
                      Text(
                        item,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
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
