// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todo_app/controller/helpNote.dart';
import 'package:todo_app/view/homeScreen.dart';
import '../component/customText.dart';
import '../constant.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var datetime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
            text: "Add Note",
            color: darkBlue,
            size: 30,
            weight: FontWeight.w600),
        centerTitle: true,
        backgroundColor: lightBlue,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: darkBlue,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
      backgroundColor: sky,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                style: const TextStyle(
                  fontSize: 16,
                  color: darkBlue,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                decoration: InputDecoration(
                    hintText: "Write your title",
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    border: OutlineInputBorder(
                        gapPadding: 3, borderRadius: BorderRadius.circular(15)),
                    label: Center(
                      child: CustomText(
                          text: "Title",
                          color: darkBlue,
                          size: 25,
                          weight: FontWeight.w600),
                    )),
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day),
                      maxTime: DateTime(2030, 12, 31), onChanged: (date) {
                    setState(() {
                      datetime = "${date.year}-${date.month}-${date.day}";
                    });
                  }, onConfirm: (date) {
                    setState(() {
                      datetime = "${date.day}-${date.month}-${date.year}";
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height / 18,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: lightBlue,
                      width: 1.5,
                    ),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                      child: CustomText(
                          text:
                              (datetime == null) ? "Pick a Date" : "$datetime",
                          color: darkBlue,
                          size: 20,
                          weight: FontWeight.w600)),
                ),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: descriptionController,
                style: const TextStyle(
                  fontSize: 16,
                  color: darkBlue,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 6,
                decoration: InputDecoration(
                    hintText: "Write your description",
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    border: OutlineInputBorder(
                        gapPadding: 3, borderRadius: BorderRadius.circular(15)),
                    label: Center(
                      child: CustomText(
                          text: "Description",
                          color: darkBlue,
                          size: 25,
                          weight: FontWeight.w600),
                    )),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightBlue,
                  elevation: 10,
                ),
                onPressed: () {
                  HelpNote().insertDB({
                    "description": descriptionController.text.toString(),
                    "title": titleController.text.toString(),
                    "date": datetime.toString(),
                    "done": "0"
                  }).then((value) {
                    print("value $value");
                    Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(builder: (BuildContext context) {
                        return HomeScreen();
                      }),
                        (Route<dynamic> route) => false
                    );
                  });
                },
                icon: const Icon(Icons.add, color: darkBlue),
                label: CustomText(
                    text: "Add",
                    color: darkBlue,
                    size: 20,
                    weight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
