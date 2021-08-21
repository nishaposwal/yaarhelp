import 'package:flutter/material.dart';

class ReviewsPage extends StatefulWidget {
  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  @override
  void initState() {
    super.initState();
  }

  var reviews = [
    {
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2L-Zfe-iYizglLDH55UD3wXBJre7V98QwKfsBCfR_8YfvXPnN&s",
      "username": "jaden",
      "country": "United States",
      "review":
          "Lorem Ipsum is a lorem ipsum Lorem Ipsum is a lorem ipsum",
      "portfolio": "https://semantic-ui.com/images/wireframe/image.png",
      "rating": 5.0,
      "date": "2 days ago"
    },
    {
      "image":
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2L-Zfe-iYizglLDH55UD3wXBJre7V98QwKfsBCfR_8YfvXPnN&s",
      "username": "subirotz",
      "country": "Norway",
      "review":
      "Lorem Ipsum is a lorem ipsum Lorem Ipsum is a lorem ipsum",
      "portfolio": "https://semantic-ui.com/images/wireframe/image.png",
      "rating": 5.0,
      "date": "1 week ago"
    },
    {
      "image":
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2L-Zfe-iYizglLDH55UD3wXBJre7V98QwKfsBCfR_8YfvXPnN&s",
      "username": "jademoz",
      "country": "Germany",
      "review":
      "Lorem Ipsum is a lorem ipsum Lorem Ipsum is a lorem ipsum",
      "portfolio": "https://semantic-ui.com/images/wireframe/image.png",
      "rating": 5.0,
      "date": "2 weeks ago"
    },
    {
      "image":
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2L-Zfe-iYizglLDH55UD3wXBJre7V98QwKfsBCfR_8YfvXPnN&s",
      "username": "alex",
      "country": "United States",
      "review":
      "Lorem Ipsum is a lorem ipsum Lorem Ipsum is a lorem ipsum",
      "portfolio": "https://semantic-ui.com/images/wireframe/image.png",
      "rating": 5.0,
      "date": "2 weeks ago"
    },
    {
      "image":
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2L-Zfe-iYizglLDH55UD3wXBJre7V98QwKfsBCfR_8YfvXPnN&s",
      "username": "eric",
      "country": "Mexico",
      "review":
      "Lorem Ipsum is a lorem ipsum Lorem Ipsum is a lorem ipsum",
      "portfolio": "https://semantic-ui.com/images/wireframe/image.png",
      "rating": 5.0,
      "date": "1 month ago"
    },
    {
      "image":
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2L-Zfe-iYizglLDH55UD3wXBJre7V98QwKfsBCfR_8YfvXPnN&s",
      "username": "kased",
      "country": "United Kingdom",
      "review":
      "Lorem Ipsum is a lorem ipsum Lorem Ipsum is a lorem ipsum",
      "portfolio": "https://semantic-ui.com/images/wireframe/image.png",
      "rating": 5.0,
      "date": "2 months ago"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Overall Rating",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          size: 18.0,
                          color: Colors.yellow[800],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            "4.9",
                            style: TextStyle(color: Colors.yellow[800], fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Ratings",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Column(
                children: new List.generate(
                  reviews.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 22.0,
                            backgroundImage: AssetImage(
                              'assets/images/nouser.jpeg',
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                reviews[index]["username"],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                reviews[index]["country"],
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  reviews[index]["review"],
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                height: 30.0,
                                width: 60.0,
                                child: Image.network(
                                  reviews[index]["portfolio"],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    size: 12.0,
                                    color: Colors.yellow[800],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Text(
                                      reviews[index]["rating"].toString(),
                                      style: TextStyle(
                                        color: Colors.yellow[800],
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                reviews[index]["date"],
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
