import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';

import '../component/customText.dart';
import '../constant.dart';
import '../controller/helpNote.dart';
import 'homeScreen.dart';

class SecondScreen extends StatefulWidget {
  var description;
  var title;
  var date;
  var id;
  var done;

  SecondScreen(
      {required this.description,
      required this.title,
      required this.date,
      required this.id,
      required this.done});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  HawkFabMenuController hawkFabMenuController = HawkFabMenuController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
            text: "Notes 🤟",
            color: darkBlue,
            size: 30,
            weight: FontWeight.w600),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: darkBlue,
          ),
        ),
        centerTitle: true,
        backgroundColor: lightBlue,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
      backgroundColor: sky,
      body: HawkFabMenu(
        icon: AnimatedIcons.menu_arrow,
        fabColor: lightBlue,
        iconColor: darkBlue,
        hawkFabMenuController: hawkFabMenuController,
        items: [
          HawkFabMenuItem(
              label: 'Delete',
              ontap: () {
                setState(() {
                    HelpNote()
                        .delete_By_Id(widget.id);
                    Navigator.of(context).pushAndRemoveUntil(
                        CupertinoPageRoute(builder: (BuildContext context) {
                          return HomeScreen();
                        }),
                            (Route<dynamic> route) => false
                    );
                  });
              },
              icon: Icon(Icons.delete_forever),
              color: Colors.red,
              labelColor: darkBlue,
              labelBackgroundColor: sky),
          HawkFabMenuItem(
            label: 'Share',
            ontap: () {},
            icon: const Icon(Icons.share),
            labelColor: darkBlue,
            labelBackgroundColor: sky,
          ),
          HawkFabMenuItem(
            label: 'Edit',
            ontap: () {},
            icon: const Icon(Icons.edit),
            labelColor: darkBlue,
            labelBackgroundColor: sky,
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  text: "Title : ${widget.title}",
                  color: darkBlue,
                  size: 30,
                  align: TextAlign.start,
                  weight: FontWeight.w600),CustomText(
                  text: "Description : ${widget.description}",
                  color: darkBlue,
                  size: 16,
                  weight: FontWeight.w500),
              CustomText(
                  text: "Date : ${widget.date}",
                  color: darkBlue,
                  size: 16,
                  weight: FontWeight.w500)
            ],
          ),
        ),
      ),
    );
  }
}
