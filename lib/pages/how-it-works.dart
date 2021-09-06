import 'package:flutter/material.dart';

class HowItWorks extends StatelessWidget {
  // const HowItWorks({ Key? key }) : super(key: key);

  Widget genralInfo() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: RichText(
        overflow: TextOverflow.clip,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: 'YAARHELP ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                  fontSize: 20),
            ),
            TextSpan(
              text:
                  'is a micro job freelance platform. the platform offers both online and offline help/work categories. This is the one platform for all the online and offline help/works. ask for help or do help and get paid for helping or completing a task.',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget moto() {
    return RichText(
      overflow: TextOverflow.clip,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: 'The platform\'s simple moto is : ',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: 'HELP EACH OTHER AND GROW TOGETHER',
            style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget timeDuration() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: RichText(
        overflow: TextOverflow.clip,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: 'Time Duration -',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black),
            ),
            TextSpan(
              text:
                  'Since this is a platform where people help, in this mode there is no boundation of time limit. a requester can mention the time-limit according to their work. It can be 30 minutes, 3 hours or a day etc.',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  List<String> services = [
    'ONLINE HELP',
    'OFFLINE HELP',
    'LEARN ENGLISH',
    'VOLUNTEERING'
  ];
  Widget servicesList() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Offered Service Categories :',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          ),
          Text(
            'There are four main categories the platform offers-',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
          ),
          SizedBox(
            height: 5,
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                services.length,
                (index) => Text(
                  services[index],
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ))
        ],
      ),
    );
  }

  Widget categoryDesc(String name, String desc, String example) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            desc,
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'For Example: ',
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            example,
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }

  Widget learnEnglish() {
    List<String> packages = [
      '1. Day concept',
      '2. Week concept',
      '3 Monthly concept'
    ];
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'C) Learn English',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            'The platform offers English learning courses. where one can learn English online on a video call with a tutor,. practical learning is the most effective way to learn English fast.',
            style: TextStyle(color: Colors.black),
          ),
          Text(
              'The platform offers flexible packages according to people\'s needs.'),
          Text('TYPES OF PACKAGES :'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              packages.length,
              (index) => Text(
                packages[index],
              ),
            ),
          ),
          categoryDesc(
              '1. Day Concept',
              'Day concept is based on daily learning where one can learn English on a daily basis. the person no need to pay for the entire month. in this category, learners can pay on daily basis for learning.',
              'Joy is a learner, he wants to learn english so he chooses "day concept". now joy is taking his classes on a daily basis so joy is paying on a daily basis. everyday joy takes a class joy pays for that day only.'),
          categoryDesc(
              '2. Week concept',
              'week concept is based on weekly learning where one can learn English on weekly basis. the person no need to pay for the entire month. in this category, learners can pay on a weekly basis( 6 days ) for learning.',
              'joy is a learner, he wants to learn English so he chooses "week concept". now joy is taking classes on a weekly basis. now joy pays for a week only where a week is of 6 days.'),
          categoryDesc(
              '3. Monthly concept',
              'the monthly concept is based on monthly learning where one can learn English on monthly basis. the person pays for the entire month. in this category, learners can pay on a monthly basis for learning.',
              'joy is a learner, he wants to learn English so he chooses "Monthly concept". now joy is taking classes on a Monthly basis. now joy pays for a Month only where a week is of 6 days.'),
        ],
      ),
    );
  }

  Widget volunteering() {
    var list = [
      '1)  Share your contact  so interested people can contact you.',
      '2)  Give them location where you are organizing your event or anything.',
      '3)  Give details and post .'
    ];
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'D) VOLUNTEERING -',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Volunteering allows you to connect to your community and make it a better place. Here you can post about the events  you are organizing in your city and ask people to join you and giving you a helping hand. It makes people to build strong connection and grow together. It is totally free to post here.',
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'How to Post- ',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            'Just simply give a brief about what you are organizing',
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
            height: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              list.length,
              (index) => Text(
                list[index],
                style: TextStyle(color: Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'How It Works',
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Rowdies'),
                ),
                Divider(),
                genralInfo(),
                moto(),
                Divider(),
                timeDuration(),
                Divider(),
                servicesList(),
                Divider(),
                categoryDesc(
                    'A) Online help',
                    'Online help/work is all about digital help where all the works can be done digitally by a personal computer.',
                    'Joy wants a logo for his store and riya is a logo designer, joy post a request to make a logo for his store during the post joy has to pay to the platform according to joy’s budget. Any helper who sees the request will apply for the help and if joy accepts the request , the work will be given to that person. For discussing further details there will be contact number of both the helper and the requester. After completing the work money will be transferred to the helper.'),
                Divider(),
                categoryDesc(
                    'B) Offline Help',
                    'Offline help/work is all about door-to-door help where all the works can be done physically by a person/helper. physical help can be professional and unprofessional.',
                    'Joy is throwing a party at his home tonight & joy is seeking help to prepare for the party. joy is looking for someone who can help him with decoration so joy puts a request for help.  Any helper who sees the request will apply for the help and if joy accepts the request, the work will be given to that person.  For discussing further details there will be contact number of both the helper and the requester. After completing the work money will be transferred to the helper.'),
                Divider(),
                learnEnglish(),
                Divider(),
                volunteering(),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
