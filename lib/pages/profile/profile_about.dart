import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30.0,
              backgroundImage: AssetImage("assets/images/nouser.jpeg"),
            ),
            title: Text(
              "Madan Mohan",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 10),
          child: Text(
            "User information",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text(
            "From",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          subtitle: Text(
            "Jaipur, India",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text(
            "Member since",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          subtitle: Text(
            "Jul 2018",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 15.0),
          child: Text(
            "Languages",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.globeAsia),
          title: Text(
            "English",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "Fluent",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.globeAsia),
          title: Text(
            "Hindi",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "Native, Fluent",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        Divider(),
        ListTile(
          title: Text(
            "Description\n",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "Hi. I'm Madan Mohan, Interior designer and latest designs expert "
            "working part time on Yaar Help. I have over 9 years of experience in the "
            "fields of Interior Design. I will guarantee a 100% customer satisfaction.",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        Divider(),
        ListTile(
          title: Text(
            "Skills\n",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 35.0,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Center(
                        child: Text(
                          "Interior Designing",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 35.0,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Center(
                        child: Text(
                          "Modular Kitchen",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
