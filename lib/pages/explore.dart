import 'package:fiverr_clone/pages/gig.dart';
import 'package:fiverr_clone/pages/helperCard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
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
    currentMode = 0;
    currentCat = "Assignment Help";
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
        'Other Help'
      ]
    },
    {"name": "Learn English", "domains": []},
    {
      "name": "Volunteering",
      "domains": [
        'Donate Blood',
        'Clean Your City',
        'Feed poor',
        'Educate girls'
      ]
    },
  ];

  Widget exploreHeader() {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "EXPLORE",
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
          currentCat = currentCat[0];
        });
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(11)),
              color: Colors.teal,
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
                color: Colors.teal,
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
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('gigs').snapshots(),
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            tabBar(),
            selected == 0 ? gigList(context) : helperList(context)
          ],
        ),
      ),
    ));
  }
}
