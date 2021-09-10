import 'package:firebase_auth/firebase_auth.dart';

import 'package:yaarhelp/pages/gig.dart';
import 'package:yaarhelp/pages/helperCard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yaarhelp/pages/loginPage.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
  int currentMode;
  ExplorePage({this.currentMode});
}

int selected = 0;

class _ExplorePageState extends State<ExplorePage>
    with TickerProviderStateMixin {
  TabController _tabController;
  var currentMode;
  var currentCat;
  @override
  void initState() {
    _tabController = new TabController(initialIndex: 0, length: 2, vsync: this);
    currentMode = widget.currentMode != null ? widget.currentMode : 0;
    currentCat = "Assignment Help";
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      FirebaseFirestore.instance
          .collection('englishLearners')
          .where('userId', isEqualTo: currentUser.uid)
          .get()
          .then((value) {
        for (var doc in value.docs) {
          var docData = doc.data();
          var str = docData['subtype'];
          var subtype = str.substring(7, str.length);
          setState(() {
            typesMap[subtype + ".png"] = false;
          });
        }
      });
    }
    selected = 0;
    super.initState();
  }

  var modes = [
    {
      "name": "Online Help",
      "domains": [
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
      ]
    },
    {
      "name": "Offline Help",
      "domains": [
        'Personal Assistant Help',
        'Organize/Decor Help',
        'Health/Therapy Help',
        'Technical Help',
        'Drop-ship/Moving Help',
        'Baby/Pet Care Help',
        'Cafe/Hotel',
        'Repairing Help',
        'House Help',
        'Other Help '
      ]
    },
    {"name": "Learn English", "domains": []},
    {
      "name": "Volunteering",
      "domains": [
        'Donate Blood',
        'Clean Your City',
        'Feed poor',
        'Educate underprivileged'
      ]
    },
  ];

  var imagesMap = [
    {
      "Online Help": "assets/images/image 24.png",
      "Assignment Help": "assets/images/image 2.png",
      "Social Media Help": "assets/images/image 9.png",
      "Art & Design Help": "assets/images/image 3.png",
      'Presentations Help': "assets/images/image 8.png",
      'Programming Help': "assets/images/image 10.png",
      'Question solving Help': "assets/images/image 11.png",
      'Writing Help': "assets/images/image 12.png",
      'Tech Help': "assets/images/image 28.png",
      'Content research Help': "assets/images/image 13.png",
      'Other Help': "assets/images/image 1.png",
      "Offline Help": "assets/images/image 25.png",
      'Personal Assistant Help': "assets/images/image 15.png",
      'Organize/Decor Help': "assets/images/image 16.png",
      'Health/Therapy Help': "assets/images/image 23.png",
      'Technical Help': "assets/images/image 17.png",
      'Drop-ship/Moving Help': "assets/images/image 18.png",
      'Baby/Pet Care Help': "assets/images/image 19.png",
      'Cafe/Hotel': "assets/images/image 20.png",
      'Repairing Help': "assets/images/image 22.png",
      'House Help': "assets/images/image 21.png",
      'Other Help ': "assets/images/image 14.png",
      "Learn English": "assets/images/image 26.png",
      "Volunteering": "assets/images/image 27.png",
      'Donate Blood': "assets/images/image 29.jpeg",
      'Clean Your City': "assets/images/image 30.jpeg",
      'Feed poor': "assets/images/image 32.jpeg",
      'Educate underprivileged': "assets/images/image 31.jpeg"
    },
  ];

  Widget exploreHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Explore",
            style: TextStyle(
                fontFamily: 'Rowdies', color: Color(0xff7ED8D8), fontSize: 25),
          ),
          Image(
            image: AssetImage('assets/images/fashion.png'),
            height: 60,
          )
        ],
      ),
    );
  }

  Widget categoryTab(Object mode, int i) {
    return InkWell(
      onTap: () {
        setState(() {
          currentMode = i;
          currentCat = modes[currentMode]['domains'];
          if (currentCat.length != 0) currentCat = currentCat[0];
        });
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(11))),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11.0),
              child: Image.asset(
                imagesMap[0][modes[i]["name"]],
                fit: BoxFit.fill,
              ),
            ),
            height: 60,
            width: 75,
            margin: EdgeInsets.all(14),
          ),
          Text(
            modes[i]["name"],
            style: TextStyle(
                color: currentMode == i
                    ? Theme.of(context).accentColor
                    : Colors.black),
          )
        ],
      ),
    );
  }

  Widget categories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          modes.length,
          (index) => categoryTab(modes[index], index),
        ),
      ),
    );
  }

  Widget subcategories() {
    List<dynamic> list = modes[currentMode]['domains'];
    return Material(
        elevation: 5,
        child: list.length > 0
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    list.length,
                    (index) => subCategoryTab(list[index]),
                  ),
                ),
              )
            : SizedBox(
                height: 0,
              ));
  }

  Widget top() {
    return Material(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            exploreHeader(),
            categories(),
          ],
        ),
      ),
    );
  }

  Widget subCategoryTab(String item) {
    return InkWell(
      onTap: () {
        setState(() {
          currentCat = item;
        });
      },
      child: Container(
        // height: 100,
        width: 75,
        margin: EdgeInsets.all(14),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(11)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(11.0),
                child: Image.asset(
                  imagesMap[0][item],
                  fit: BoxFit.fill,
                ),
              ),
              margin: EdgeInsets.only(bottom: 5),
              height: 60,
              width: 75,
            ),
            Text(
              item,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: currentCat == item
                      ? Theme.of(context).accentColor
                      : Colors.black),
            )
          ],
        ),
      ),
    );
  }

  Widget tabBar() {
    return TabBar(
      onTap: (val) {
        setState(() {
          selected = val;
        });
      },
      labelColor: Theme.of(context).accentColor,
      unselectedLabelColor: Colors.black,
      controller: _tabController,
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: <Widget>[
        Tab(
          text: "Gigs",
        ),
        Tab(
          text: "Helpers",
        ),
      ],
    );
  }

  Widget gigList(BuildContext context) {
    var subCat = currentCat;
    if (subCat == 'Other Help ') {
      subCat = 'Other Help';
    }
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('gigs')
            .where('category', isEqualTo: modes[currentMode]['name'])
            .where('subCategory', isEqualTo: subCat)
            .orderBy('timeStamp', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              padding: EdgeInsets.all(100),
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).accentColor,
                ),
              ),
            );
          }
          return Column(
            children: [
              for (DocumentSnapshot doc in snapshot.data.docs)
                Gig(
                  gig: doc.data() as Map<String, dynamic>,
                  id: doc.reference.id,
                  source: 'explore',
                )
            ],
          );
        },
      ),
    );
  }

  Widget helperList(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              padding: EdgeInsets.all(100),
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).accentColor,
                ),
              ),
            );
          }
          return Column(
            children: [
              for (DocumentSnapshot doc in snapshot.data.docs)
                HelperCard(
                  helper: doc.data() as Map<String, dynamic>,
                )
            ],
          );
        },
      ),
    );
  }

  var englishProgrammes = {
    "day": [
      "assets/images/day.png",
      "assets/images/40.png",
      "assets/images/50.png",
      "assets/images/60.png"
    ],
    "week": [
      "assets/images/week.png",
      "assets/images/240.png",
      "assets/images/300.png",
      "assets/images/360.png"
    ],
    "month": [
      "assets/images/month.png",
      "assets/images/1200.png",
      "assets/images/1500.png",
      "assets/images/1800.png"
    ]
  };

  var typesMap = {
    "40.png": true,
    "50.png": true,
    "60.png": true,
    "240.png": true,
    "300.png": true,
    "360.png": true,
    "1200.png": true,
    "1500.png": true,
    "1800.png": true
  };

  var types = [
    "day",
    "month",
    "week",
    "40",
    "50",
    "60",
    "240",
    "300",
    "360",
    "1200",
    "1500",
    "1800"
  ];

  String getType(String str) {
    for (var item in types) {
      if (str.contains(item)) return item;
    }
    return "";
  }

  Widget englishProgram() {
    return Container(
      child: Column(
        children: [
          for (var item in englishProgrammes.values)
            for (var i = 0; i < item.length; i++)
              i == 0
                  ? Container(
                      padding: EdgeInsets.all(8),
                      height: 180,
                      width: double.infinity,
                      child: Image.asset(
                        item[0],
                        fit: BoxFit.fill,
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.all(8),
                      height: 300,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Image.asset(
                            item[i],
                            fit: BoxFit.fill,
                          ),
                          Container(
                            width: double.infinity,
                            height: 45,
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor:
                                      typesMap[item[i].substring(14)]
                                          ? Theme.of(context).accentColor
                                          : Colors.grey[200],
                                ),
                                onPressed: typesMap[item[i].substring(14)]
                                    ? () {
                                        if (FirebaseAuth.instance.currentUser ==
                                            null) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => LoginPage(),
                                            ),
                                          );
                                        }

                                        var currentUser =
                                            FirebaseAuth.instance.currentUser;
                                        var uid = currentUser.uid;
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(uid)
                                            .get()
                                            .then((value) {
                                          if (value.data() != null) {
                                            var data = value.data();
                                            FirebaseFirestore.instance
                                                .collection("englishLearners")
                                                .add({
                                              "userId": currentUser.uid,
                                              "phoneNumber":
                                                  data['phoneNumber'],
                                              "userName": data['displayName'],
                                              "type": getType(item[0]),
                                              "subtype":
                                                  'rupees ' + getType(item[i])
                                            }).then((value) {
                                              setState(() {
                                                typesMap[item[i]
                                                    .substring(14)] = false;
                                              });
                                            });
                                          }
                                        });
                                      }
                                    : null,
                                child: Text(
                                  'R  E  G  I  S  T  E  R',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontFamily: 'Lato'),
                                )),
                          )
                        ],
                      ),
                    ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              top(),
              SizedBox(
                height: 5,
              ),
              subcategories(),
              modes[currentMode]['name'] != "Learn English"
                  ? tabBar()
                  : SizedBox(
                      height: 0,
                    ),
              modes[currentMode]['name'] != "Learn English"
                  ? selected == 0
                      ? gigList(context)
                      : helperList(context)
                  : englishProgram()
            ],
          ),
        ),
      )),
    );
  }
}
