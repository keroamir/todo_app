import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_plus/share_plus.dart';
import 'package:todo_app/component/customText.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/controller/helpNote.dart';
import 'package:todo_app/view/addNote.dart';
import 'package:todo_app/view/secScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    HelpNote().db.then((value) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
            text: "ToDo 🤟",
            color: darkBlue,
            size: 30,
            weight: FontWeight.w600),
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
      body: FutureBuilder(
        future: HelpNote().getDB(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return (snapshot.data.length == 0)
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: CustomText(
                        align: TextAlign.center,
                        text: 'Your Todo list is Empty 🙄😒',
                        color: darkBlue,
                        size: 30,
                        weight: FontWeight.w600,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        child: Slidable(
                          key: const ValueKey(0),
                          endActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (val) {
                                  setState(() {
                                    HelpNote()
                                        .delete_By_Id(snapshot.data[index].id);
                                  });
                                },
                                backgroundColor: Colors.transparent,
                                foregroundColor: darkBlue,
                                icon: Icons.delete,
                                label: 'Delete',
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)),
                              ),
                              SlidableAction(
                                onPressed: (val) {
                                  Share.share("""From Todo App ❤
                                  ${snapshot.data[index].title} ,${snapshot.data[index].date}
                                  ${snapshot.data[index].description} 
                                  """);
                                },
                                backgroundColor: Colors.transparent,
                                foregroundColor: darkBlue,
                                icon: Icons.share,
                                label: 'Share',
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15)),
                              ),
                            ],
                          ),

                          // The child of the Slidable is what the user sees when the
                          // component is not dragged.

                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15)),
                            ),
                            color: cyan,
                            child: ListTile(
                              onTap: () {
                                Navigator.push(context, CupertinoPageRoute(
                                    builder: (BuildContext context) {
                                  return SecondScreen(
                                    description:
                                        snapshot.data[index].description,
                                    title: snapshot.data[index].title,
                                    date: snapshot.data[index].date,
                                    id: snapshot.data[index].id,
                                    done: snapshot.data[index].done,
                                  );
                                }));
                              },
                              title: CustomText(
                                  text: "${snapshot.data[index].title}",
                                  color: darkBlue,
                                  size: 18,
                                  weight: FontWeight.w600),
                              subtitle: CustomText(
                                  text:
                                      "${snapshot.data[index].description}\n${snapshot.data[index].date}",
                                  color: darkBlue,
                                  size: 14,
                                  weight: FontWeight.w500),
                              leading: Icon(
                                Icons.note_alt_sharp,
                                color: darkBlue,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
          } else {
            return CircularProgressIndicator(
              backgroundColor: darkBlue,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              CupertinoPageRoute(builder: (BuildContext context) {
            return AddNote();
          }));
        },
        elevation: 5,
        backgroundColor: lightBlue,
        child: Icon(
          Icons.add,
          color: darkBlue,
          size: 30,
        ),
      ),
    );
  }
}
