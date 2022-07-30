import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_app/layout/social_app/cubit/states.dart';
import 'package:social_app/models/social_app/message_model.dart';
import 'package:social_app/models/social_app/post_model.dart';
import 'package:social_app/models/social_app/social_user_model.dart';
import 'package:social_app/modules/social_app/chats/chats_screen.dart';
import 'package:social_app/modules/social_app/feeds/feeds_screen.dart';
import 'package:social_app/shared/components/constants.dart';

import '../../../modules/social_app/new_post/new_post_screen.dart';
import '../../../modules/social_app/settings/settings_screen.dart';
import '../../../modules/social_app/users/users_screen.dart';


class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);


  SocialUserModel? userModel;
  void getUserData()
  {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.
    collection('users').
    doc(uId).
    get().
    then((value) {

      userModel = SocialUserModel.fromJson(value.data());
      //print(userModel!.uId);
      //print(userModel!.email);

      emit(SocialGetUserSuccessState());

    }).catchError((error){
      //print(userModel);
      //print(userModel!.uId);
      //print(userModel!.email);

      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  List<Widget> screens =
  [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles =
  [
    'Homa',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  int currentIndex = 0;
  void changeBottomNav(int index) {
    if (index == 1) getUsers();
    if (index == 2)
      emit(SocialNewPostState());
    else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File? profileImage;
  ImagePicker? picker = ImagePicker();

  Future? getProfileImage() async {
    final pickedFile = await picker?.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future getCoverImage() async {
    final pickedFile = await picker?.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }


  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
})
  {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance.
    ref().
    child('users/${Uri.file(profileImage!.path).pathSegments.last}').
    putFile(profileImage!).
    then((value) {
      print(value);
      value.ref.getDownloadURL().
      then((value) {
        print(value);
        updateUser(
            name: name,
            phone: phone,
            bio: bio,
            profileImage: value,
        );
      }).catchError((error){
        emit(SocialUploadProfileImageErrorState());
        //print(error.toString());
      });
    }).catchError((error){
      emit(SocialUploadProfileImageErrorState());
      //print(error.toString());
    });


  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  })
  {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance.
    ref().
    child('users/${Uri.file(coverImage!.path).pathSegments.last}').
    putFile(coverImage!).
    then((value) {
      value.ref.getDownloadURL().
      then((value) {
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error){
        emit(SocialUploadCoverImageErrorState());
        //print(error.toString());
      });
    }).catchError((error){
      emit(SocialUploadCoverImageErrorState());
      //print(error.toString());
    });


  }


  void updateUser({
  required String name,
    required String phone,
    required String bio,
    String? cover,
    String? profileImage,
  })
  {
    SocialUserModel model =  SocialUserModel(
      name: name,
      phone: phone,
      isEmailVerified: false,
      bio: bio,
      email: userModel!.email,
      uId: userModel!.uId,
      cover: cover??userModel!.cover,
      image: profileImage??userModel!.image,
    );
    FirebaseAuth.instance.currentUser!.delete();

    FirebaseFirestore.instance.
    collection('users').
    doc(userModel!.uId).
    update(model.toMap()).
    then((value) {
      getUserData();
    }).catchError((error){
      emit(SocialUserUpdateErrorState(error));
      print(error.toString());
    });

  }

  File? postImage;

  Future getPostImage() async {
    final pickedFile = await picker?.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage()
  {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
})
{
  emit(SocialCreatePostLoadingState());

  firebase_storage.FirebaseStorage.instance.
  ref().
  child('posts/${Uri.file(postImage!.path).pathSegments.last}').
  putFile(postImage!).
  then((value) {
    value.ref.getDownloadURL().
    then((value) {
      creatPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
      );
    }).catchError((error){
      emit(SocialCreatePostErrorState());
    });

  }).catchError((error){
    emit(SocialCreatePostErrorState());
  });

}

  void creatPost({
  required String dateTime,
    required String text,
    String? postImage,
})
  {
    emit(SocialCreatePostLoadingState());
     PostModel model = PostModel(
       image: userModel!.image,
       uId: userModel!.uId,
       name: userModel!.name,
       text: text,
       dataTime: dateTime,
       postImage: postImage??'',
     );

     FirebaseFirestore.instance.
     collection('posts').
     add(model.toMap()).
     then((value)
     {
       getPosts();
       //emit(SocialCreatePostSuccessState());
     }).catchError((error){
       emit(SocialCreatePostErrorState());
     });

  }
  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        posts.add(PostModel.fromJson(element.data()));
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
        }).catchError((error) {
          print(error.toString());
        });
      });
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users = [];

  void getUsers() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId)
            users.add(SocialUserModel.fromJson(element.data()));
        });

        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      text: text,
      senderId: userModel!.uId!,
      receiverId: receiverId,
      dateTime: dateTime,
    );

    // set my chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    // set receiver chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];

      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });

      emit(SocialGetMessagesSuccessState());
    });
  }



}