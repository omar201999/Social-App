import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/social_app/social_register/cubit/states.dart';

import '../../../layout/social_app/social_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';


class SocialRegisterScreen extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create:(context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context,state)
        {
          if (state is SocialCreateUserSuccessState)
          {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) async {
              uId = state.uId;
              navigateAndFinish(context, SocialLayout());

            }).catchError((error){
              print(error.toString());

            });
          }
        },
        builder:(context,state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text(
                            'REGISTER',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black
                          ),
                        ),
                        Text(
                          'Register now to communicate with friends',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'please enter your name';
                              }
                            },
                            label: 'User Name',
                            prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: SocialRegisterCubit.get(context).suffix,
                          suffixPressed: ()
                          {
                            SocialRegisterCubit.get(context).changePasswordVisibility();
                          },
                          isPassword: SocialRegisterCubit.get(context).isPassword ,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone number';
                            }
                          },
                          label: 'Phone',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                            condition: state is! SocialRegisterLoadingState,
                            builder: (context) => defaultButton(
                                function: ()
                                {
                                  if(formKey.currentState!.validate()){
                                    SocialRegisterCubit.get(context).userRegister(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        password: passwordController.text,
                                        email: emailController.text,
                                    );
                                  }
                                },
                                text: 'register',
                              isUppercase: true,

                            ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),




                      ],
                    ),
                  ),
                ),
              ),
            ),
          ); 
        } 
      ),
    );
  }
}
