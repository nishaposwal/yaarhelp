import 'package:fiverr_clone/pages/profile/profile.dart';
import 'package:fiverr_clone/pages/profile/profile_about.dart';
import 'package:flutter/material.dart';

class HelperCard extends StatelessWidget {
  // const HelperCard({ Key? key }) : super(key: key);

  final Map<String, dynamic> helper;

  HelperCard({this.helper});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(
              uid: this.helper['userId'],
              index: 0,
            ),
          ),
        );
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(this.helper['imageUrl']),
                radius: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      this.helper['displayName'],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      this.helper['description'],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
