class DataModel{
  final int? id;
   String title;
   String subTitle;

  DataModel({this.id,required this.title,required this.subTitle});

  factory DataModel.fromJson(Map<String,dynamic >json)=>
      DataModel(
          id: json['id'],
          title: json['title'],
          subTitle: json['subTitle'],
      );

  Map<String,dynamic>toMap()=> {
    'id':id,
    'title':title,
    'subTitle':subTitle
  };


}