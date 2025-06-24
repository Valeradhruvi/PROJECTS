import 'dart:ui';

import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('About Us' , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),
        backgroundColor: Color.fromRGBO(195, 126, 84, 0.8),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/image/img_2.png'),
                    fit: BoxFit.cover)),
          ),
          Container(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 5, sigmaY: 5), // Adjust blur intensity
              child: Container(
                color: Colors.black
                    .withOpacity(0.5), // Transparent to let blur show through
              ),
            ),
          ),
          Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border.all(),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        child: ClipOval(
                          child: Image.asset('assets/image/img_2.png',
                              fit: BoxFit.fill, height: 50.0, width: 50.0),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'MeetME',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Color.fromRGBO(70, 60, 43, 0.9)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                              child: Align(
                                child: Container(
                                  height: 30,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(76, 54, 43, 0.9),
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(3)),
                                  child: Text(
                                    'Meet Our Team',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                alignment: Alignment.topLeft,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(195, 126, 84, 0.5),
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text('Developed by : '),
                                        SizedBox(
                                          width: 25,
                                        ),
                                        Text('Dhruvi Valera (23010101290)'),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text('Mentored by : '),
                                        SizedBox(
                                          width: 25,
                                        ),
                                        Text(
                                          'Prof. Mehul Bhundiya (Computer \n Enginnering Department, \n School of Computer Science',
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text('Explored by : '),
                                        SizedBox(
                                          width: 25,
                                        ),
                                        Text(
                                          'ASWDC, \n School of Computer Science',
                                          style: TextStyle(fontSize: 13),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text('Eulogized by : '),
                                        SizedBox(
                                          width: 25,
                                        ),
                                        Text(
                                          'Darshan University, \n Rajkot,Gujarat - INDIA',
                                          style: TextStyle(fontSize: 13),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                              child: Align(
                                child: Container(
                                  height: 30,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(76, 54, 43, 0.9),
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(3)),
                                  child: Text(
                                    'About ASWDC',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                alignment: Alignment.topLeft,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(195, 126, 84, 0.5),
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            child: Image.asset(
                                              height: 80,
                                                width: 150,
                                                'assets/image/darshan_logo.png')
                                        ),
                                        SizedBox(width: 30,),
                                        Container(
                                            height: 80,
                                            width: 140,
                                            child: Image.asset(
                                                'assets/image/img_8.png')
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Text(
                                        'ASWDC is a Application , Software and Website Development Center Darshan University'
                                        'run by Students and Staff of School of Computer Science.'),
                                    SizedBox(height: 20,),
                                    Text(
                                         'Sole purpose of ASWDC is to bridge gap between university curriculum & industry demands '
                                             'Students learn cutting edge tecnnoligies , develop real world application & expreriences professtional environment @ '
                                             'ASWDC under guidance of industry experts & faculty members.'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                              child: Align(
                                child: Container(
                                  height: 30,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(76, 54, 43, 0.9),
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(3)),
                                  child: Text(
                                    'Contact US',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                alignment: Alignment.topLeft,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(195, 126, 84, 0.5),
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.email_rounded),
                                        SizedBox(width: 5,),
                                        Text('aswdc@darshan.ac.in')
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Icon(Icons.call),
                                        SizedBox(width: 5,),
                                        Text('+91-9727747317')
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Container(
                                            height: 20, width: 20,
                                            child: Image.asset('assets/image/img_10.png' ,fit: BoxFit.cover,)),
                                        SizedBox(width: 10,),
                                        Text('www.darshan.ac.in')
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25,),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(195, 126, 84, 0.5),
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.share),
                                        SizedBox(width: 5,),
                                        Text('Share App')
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Icon(Icons.apps_rounded),
                                        SizedBox(width: 5,),
                                        Text('More Apps')
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Icon(Icons.star_border_sharp),
                                        SizedBox(width: 10,),
                                        Text('Rate Us')
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Icon(Icons.thumb_up),
                                        SizedBox(width: 10,),
                                        Text('Like Us on Facebook')
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Icon(Icons.update),
                                        SizedBox(width: 10,),
                                        Text('Check For Update')
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('©️ 2025 Darshan University'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('All Rights Reserved - '),
                              Text('Private Policy')
                            ],
                          ),
                          Text('Made with ❤️ in India')
                        ],
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
      backgroundColor: const Color.fromRGBO(195, 120, 79, 0.8),
    );
  }
}
