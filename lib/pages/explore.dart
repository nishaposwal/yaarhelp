import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        "Spcial Media Help",
        "Art & Design Help",
        "Questions Help"
      ]
    },
    {
      "name": "Offline Help",
      "domains": [
        "General Help",
        "echnical Help",
        "Organise/Decor Help",
        "Interior Help"
      ]
    },
    {
      "name": "Learn English",
      "domains": [
        "Basic Grammar",
        "American English",
        "Advance English",
        "Native English"
      ]
    },
    {
      "name": "Volunteering",
      "domains": [
        "Donate Blood",
        "Clean India",
        "Feed India",
        "Educate Children"
      ]
    },
  ];

  var _completedOrders = [
    {
      "username": "brad",
      "online": true,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2L-Zfe-iYizglLDH55UD3wXBJre7V98QwKfsBCfR_8YfvXPnN&s",
      "gigTitle": "Create a react application",
      "date": "20 Jan 2020",
      "price": "₹5"
    },
    {
      "username": "femmertz",
      "online": false,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2L-Zfe-iYizglLDH55UD3wXBJre7V98QwKfsBCfR_8YfvXPnN&s",
      "gigTitle": "Create an angular application",
      "date": "18 Jan 2020",
      "price": "₹35"
    },
    {
      "username": "beep",
      "online": true,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2L-Zfe-iYizglLDH55UD3wXBJre7V98QwKfsBCfR_8YfvXPnN&s",
      "gigTitle": "Create an amazing flutter app",
      "date": "12 Jan 2020",
      "price": "₹150"
    },
    {
      "username": "alex",
      "online": false,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2L-Zfe-iYizglLDH55UD3wXBJre7V98QwKfsBCfR_8YfvXPnN&s",
      "gigTitle": "Create a prototype with adobe xd",
      "date": "15 Jan 2020",
      "price": "₹15"
    },
    {
      "username": "ninny",
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

  Future<void> _refreshMessages() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 180,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "EXPLORE",
              style: TextStyle(
                  fontFamily: 'Rowdies',
                  color: Color(0xff7ED8D8),
                  fontSize: 35),
            ),
            Image(image: AssetImage('assets/images/fashion.png'))
          ],
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                child: Row(
                  children: [
                    for (var i = 0; i < modes.length; i++)
                      InkWell(
                        onTap: () {
                          setState(() {
                            currentMode = i;
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(11)),
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
                      )
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                child: Row(
                  children: [
                    for (var item in modes[currentMode]["domains"])
                      InkWell(
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
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(11)),
                                  color: Colors.teal,
                                ),
                                margin: EdgeInsets.only(bottom: 5),
                                height: 60,
                                width: 75,
                              ),
                              Text(

                                item,
                                textAlign: TextAlign.center,
                                // style: TextStyle(
                                //     color: currentMode == i
                                //         ? Theme.of(context).accentColor
                                //         : Colors.black),
                              )
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
            TabBar(
              labelColor: Theme.of(context).accentColor,
              unselectedLabelColor: Colors.grey,
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
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  ListView.builder(
                    itemCount: _completedOrders.length,
                    itemBuilder: (context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Card(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: InkWell(
                              onTap: () {},
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: ListTile(
                                leading: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 20.0,
                                      backgroundImage: AssetImage(
                                          'assets/images/nouser.jpeg'),
                                    ),
                                  ],
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      _completedOrders[index]['username'],
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    Text(
                                      _completedOrders[index]['date'],
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: Container(
                                        height: 40.0,
                                        child: Text(
                                          _completedOrders[index]['gigTitle'],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1.0,
                                                  color: Theme.of(context).accentColor),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5.0),
                                              ),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  _completedOrders[index]['price'],
                                                  style: TextStyle(
                                                      color:
                                                      Theme.of(context).accentColor,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: helpers.length,
                    itemBuilder: (context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Card(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: InkWell(
                              onTap: () {},
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: ListTile(
                                leading: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 35.0,
                                      backgroundImage: AssetImage(
                                          'assets/images/nouser.jpeg'),
                                    ),
                                  ],
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        helpers[index]['username'],
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Roboto'
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.favorite, color: Colors.red, ),
                                          Text(" 11")
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: Container(
                                        height: 40.0,
                                        child: Text(
                                          helpers[index]['gigTitle'],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
