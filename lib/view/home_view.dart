// ignore_for_file: prefer_const_consts, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:note/model/data_model.dart';
import 'package:note/sqlite/database.dart';
import 'package:note/view/dataCard.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();
   DatabaseHelper? databaseHelper;
  List<DataModel> notes=[];
  bool fetching=true;
  int currentIndex=0;
  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
    getData1();
  }

  void getData1()async{
    notes=await databaseHelper!.getData();
    setState(() {
      fetching=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Note',
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: fetching
      ?const Center(child: CircularProgressIndicator(),)
          :ListView.builder(
           itemCount: notes.length,
           itemBuilder: (context,index){
            return DataCard(
              dataModel: notes[index],
              edit: edit,
              index: index,
                delete:delete,
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showingDialog();
        },
      ),
    );
  }

  void showingDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(14),
            content: Container(
              height: 150,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title *',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: subTitleController,
                    decoration: const InputDecoration(
                      labelText: 'SubTitle *',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('save'),
                onPressed: () {
                  DataModel dataLocal=DataModel(
                      title: titleController.text,
                      subTitle: subTitleController.text);
                  databaseHelper!.insertData(dataLocal);
                 // dataLocal.id!=(notes[notes.length-1].id!+1);
                 setState(() {
                   notes.add(dataLocal);
                 });
                  titleController.clear();
                  subTitleController.clear();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
  void showingDialogUpdate() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(14),
            content: Container(
              height: 150,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title *',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: subTitleController,
                    decoration: const InputDecoration(
                      labelText: 'SubTitle *',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('update'),
                onPressed: () {
                  DataModel myData=notes[currentIndex];
                  myData.title=titleController.text;
                  myData.subTitle=subTitleController.text;
                  // databaseHelper.update(myData, myData.id!);

                  setState(() {
                    // Navigator.pop(context);
                    databaseHelper!.update(myData, myData.id!);
                    Navigator.pop(context);
                  });


                },
              ),
            ],
          );
        });
  }

  void edit(index){
    currentIndex=index;
    titleController.text=notes[index].title;
    subTitleController.text=notes[index].subTitle;
    showingDialogUpdate();
  }
  void delete(int index){
  databaseHelper!.delete(notes[index].id!);
  setState(() {
    notes.removeAt(index);
  });
  }

}
