import 'package:fiverr_clone/pages/gig.dart';
import 'package:fiverr_clone/pages/helperCard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with TickerProviderStateMixin {
  TabController _tabController;
  var currentMode;
  var currentCat;
  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
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
        "Questions Help"
      ]
    },
    {
      "name": "Offline Help",
      "domains": [
        "General Help",
        "Technical Help",
        "Organise/Decor Help",
        "Interior Help"
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

  var gigs = [
    {
      "username": "Madan Mohan",
      "online": true,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2L-Zfe-iYizglLDH55UD3wXBJre7V98QwKfsBCfR_8YfvXPnN&s",
      "gigTitle": "Create a react application",
      "date": "20 Jan 2020",
      "price": "₹5"
    },
    {
      "username": "Munshi Desai",
      "online": false,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2L-Zfe-iYizglLDH55UD3wXBJre7V98QwKfsBCfR_8YfvXPnN&s",
      "gigTitle": "Create an angular application",
      "date": "18 Jan 2020",
      "price": "₹35"
    },
    {
      "username": "Deep Jandu",
      "online": true,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2L-Zfe-iYizglLDH55UD3wXBJre7V98QwKfsBCfR_8YfvXPnN&s",
      "gigTitle": "Create an amazing flutter app",
      "date": "12 Jan 2020",
      "price": "₹150"
    },
    {
      "username": "Alex Willber",
      "online": false,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2L-Zfe-iYizglLDH55UD3wXBJre7V98QwKfsBCfR_8YfvXPnN&s",
      "gigTitle": "Create a prototype with adobe xd",
      "date": "15 Jan 2020",
      "price": "₹15"
    },
    {
      "username": "Nanny Poswal",
      "online": false,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2L-Zfe-iYizglLDH55UD3wXBJre7V98QwKfsBCfR_8YfvXPnN&s",
      "gigTitle": "Create a nodejs rest api",
      "date": "15 Jan 2020",
      "price": "₹5"
    },
  ];

  var helpers = [
    {
      "username": "Mohan Malviya",
      "online": true,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2L-Zfe-iYizglLDH55UD3wXBJre7V98QwKfsBCfR_8YfvXPnN&s",
      "gigTitle": "Interior designer, modular kitchen expert",
      "date": "02 Dec 2019",
      "price": "₹25"
    },
    {
      "username": "source",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2L-Zfe-iYizglLDH55UD3wXBJre7V98QwKfsBCfR_8YfvXPnN&s",
      "gigTitle": "Web Application Designer, Experienced Graphic Designer",
      "date": "15 Dec 2019",
      "price": "₹5"
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
        height: 100,
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
            )
          ],
        ),
      ),
    );
  }

  Widget tabBar() {
    return TabBar(
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

  Widget tabs() {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        ListView.builder(
          itemCount: gigs.length,
          itemBuilder: (context, int index) {
            return Gig(gig: gigs[index]);
          },
        ),
        ListView.builder(
          itemCount: helpers.length,
          itemBuilder: (context, int index) {
            return HelperCard(helper: helpers[index]);
          },
        ),
      ],
    );
  }

  // Widget gig(String name, St) {
  //   return Card(
  //     child: Container(
  //       width: double.infinity,
  //       child: Text(gig['username']),
  //     ),
  //   );
  // }
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
                Gig(gig: doc.data() as Map<String, dynamic>, id: doc.reference.id, source: 'explore',)
            ],
          );
        },
      ),
    );
  }

  Widget helperList() {
    return Column(
      children:
          List.generate(helpers.length, (i) => HelperCard(helper: helpers[i])),
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
            // tabBar(),
            gigList(context)
          ],
        ),
      ),
    ));
  }
}
