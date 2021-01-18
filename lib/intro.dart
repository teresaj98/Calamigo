import 'dart:io';
import 'package:calamigo/contact.dart';
import 'package:calamigo/data/data.dart';
import 'package:flutter/material.dart';


class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Introscreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Introscreen extends StatefulWidget {
  @override
  _IntroscreenState createState() => _IntroscreenState();
}

class _IntroscreenState extends State<Introscreen> {

  List<SliderModel> mySLides = new List<SliderModel>();
  int slideIndex = 0;
  PageController controller;

  Widget _buildPageIndicator(bool isCurrentPage){
    return Container(
     margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {

    super.initState();
    mySLides = getSlides();
    controller = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [const Color(0xff3C8CE7), const Color(0xff00EAFF)])),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height - 100,
          child: PageView(
            controller: controller,
              onPageChanged: (index) {
                setState(() {
                  slideIndex = index;
                });
              },
          children: <Widget>[
            SlideTile(
              imagePath: mySLides[0].getImageAssetPath(),
              title: mySLides[0].getTitle(),
              desc: mySLides[0].getDesc(),
            ),
            SlideTile(
              imagePath: mySLides[1].getImageAssetPath(),
              title: mySLides[1].getTitle(),
              desc: mySLides[1].getDesc(),
            ),

          ],
          ),
        ),
        bottomSheet: slideIndex != 1 ? Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                onPressed: (){
                  controller.animateToPage(1, duration: Duration(milliseconds: 400), curve: Curves.linear);
                },
                splashColor: Colors.blue[50],
                child: Text(
                  "SKIP",
                  style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    for (int i = 0; i < 2 ; i++) i == slideIndex ? _buildPageIndicator(true): _buildPageIndicator(false),
                  ],),
              ),
              FlatButton(
                onPressed: (){
                  print("this is slideIndex: $slideIndex");
                  controller.animateToPage(slideIndex + 1, duration: Duration(milliseconds: 500), curve: Curves.linear);
                },
                splashColor: Colors.blue[50],
                child: Text(
                  "NEXT",
                  style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ): InkWell(
          onTap: (){
            Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new AccessContacts()));
          },
          child: Container(
            height: Platform.isIOS ? 70 : 60,
            color: Colors.grey[900],
            alignment: Alignment.center,
            child: Text(
              "GET STARTED NOW",
              style: TextStyle(color: Colors.teal[600], fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

class SlideTile extends StatelessWidget {
   final String imagePath, title, desc;

  SlideTile({this.imagePath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imagePath),
          SizedBox(
            height: 40,
          ),
          Text(title, textAlign: TextAlign.center,style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20
          ),),
          SizedBox(
            height: 20,
          ),
          Text(desc, textAlign: TextAlign.center,style: TextStyle(
          fontWeight: FontWeight.w500,
              fontSize: 14))
        ],
      ),
    );
  }
}