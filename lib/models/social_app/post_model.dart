class PostModel
{
  String? name;
  String? uId;
  String? image;
  String? dataTime;
  String? text;
  String? postImage;


  PostModel({
    this.dataTime,
    this.postImage,
    this.uId,
    this.name,
    this.image,
    this.text,
  });

  // named constructor

  PostModel.fromJson(Map<String,dynamic>? json)
  {
    uId=json!['uId'];
    dataTime=json['dataTime'];
    name=json['name'];
    text=json['text'];
    postImage=json['postImage'];
    image=json['image'];

  }

  Map<String,dynamic> toMap()
  {
    return {
      'name' : name,
      'dataTime' : dataTime,
      'text' : text,
      'uId' : uId,
      'postImage': postImage,
      'image' : image,

    };

  }

}