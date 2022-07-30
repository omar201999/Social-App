class SocialUserModel
{
  String? name;
   String?  email;
   String? phone;
   String? uId;
  bool? isEmailVerified;
  String? image;
  String? cover;
  String? bio;
  SocialUserModel({
     this.email,
    this.phone,
     this.uId,
   this.name,
     this.isEmailVerified,
    this.image,
    this.bio,
    this.cover,
});

  // named constructor

  SocialUserModel.fromJson(Map<String,dynamic>? json)
  {
    uId=json!['uId'];
    email=json['email'];
    name=json['name'];
    phone=json['phone'];
    isEmailVerified=json['isEmailVerified'];
    image=json['image'];
    bio=json['bio'];
    cover=json['cover'];
  }

  Map<String,dynamic> toMap()
  {
    return {
      'name' : name,
      'email' : email,
      'phone' : phone,
      'uId' : uId,
      'isEmailVerified': isEmailVerified,
      'image' : image,
      'bio' : bio,
      'cover' : cover,



    };

  }

}