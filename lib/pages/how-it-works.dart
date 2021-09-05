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
    return RichText(
      overflow: TextOverflow.clip,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: 'Time Duration -',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          TextSpan(
            text:
                'Since this is a platform where people help, in this mode there is no boundation of time limit. a requester can mention the time-limit according to their work. It can be 30 minutes, 3 hours or a day etc.',
            style: TextStyle(),
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
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'How It Works',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                genralInfo(),
                moto(),
                timeDuration(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
