import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/social_app/social_register/cubit/states.dart';

import '../../../../models/social_app/social_user_model.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);


  void userRegister({
    required String name,
    required String phone,
    required String password,
    required String email,
  })
  {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword
      (
        email: email.trim(),
        password: password,
    ).then((value){
      //print(value.user!.email);
      //print(value.user!.uid);
      userCreate(
          uId: value.user!.uid,
          name: name,
          email: email.trim(),
          phone: phone,

      );
    }).catchError((error){
          print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
  required String name,
    required String email,
    required String phone,
    required String uId,
  })
  {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      uId: uId,
      email: email.trim(),
      image: 'https://image.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg',
      cover: 'https://image.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg',
      bio: 'write your bio',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance.
    collection('users').
    doc(uId).
    set(model.toMap()).
    then((value) {
      emit(SocialCreateUserSuccessState(uId));
    }).catchError((error){
      print(error.toString());
      emit(SocialCreateUserErrorState(error.toString()));

    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordVisibilityState());
  }



}