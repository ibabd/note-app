// ignore: file_names
// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:note/model/data_model.dart';
class DataCard extends StatelessWidget {
  final DataModel dataModel;
  final Function edit;
  final Function delete;
   final int index;
  const DataCard({Key? key,required this.dataModel,required this.edit,required this.delete,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: IconButton(
            onPressed: (){
              edit(index);
            },
            icon: Icon(Icons.edit,color: Colors.white,),
          )
        ),
        title: Text(dataModel.title),
        subtitle: Text(dataModel.subTitle),
        trailing: CircleAvatar(
          backgroundColor: Colors.redAccent,
          child:IconButton(
            onPressed: (){
              delete(index);
            },
            icon: Icon(Icons.delete,color: Colors.white,),
          ),
        ),
      ),
    );
  }
}
