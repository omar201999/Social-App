import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/social_app/social_login/cubit/cubit.dart';
import 'package:social_app/modules/social_app/social_login/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';

import '../../../layout/social_app/social_layout.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../social_register/social_register_screen.dart';


class SocialLoginScreen extends StatelessWidget
{
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context,state)
        {
          if(state is SocialLoginErrorState)
          {
            showToast(
                text: state.error,
                state: ToastStates.ERROR,
            );
          }
          if ( state is SocialLoginSuccessState)
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
        builder: (context,state)
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
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                          'LOGIN now to communicate with friends',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller:emailController ,
                          type: TextInputType.emailAddress,
                          validate: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'please enter your email address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller:passwordController ,
                          type: TextInputType.visiblePassword,
                          suffix: SocialLoginCubit.get(context).suffix ,
                          validate: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'password is too short';
                            }
                          },
                          onSubmit: (value)
                          {
                            /*if(formKey.currentState!.validate())
                            {
                              SocialLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }*/
                          },
                          isPassword: SocialLoginCubit.get(context).isPassword,
                          suffixPressed: ()
                          {
                            SocialLoginCubit.get(context).changePasswordVisibility();

                          },

                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                           builder: (context) => defaultButton(
                             function: ()
                             {
                               if(formKey.currentState!.validate())
                               {
                                 SocialLoginCubit.get(context).userLogin(
                                   email: emailController.text,
                                   password: passwordController.text,
                                 );
                               }


                             },
                             text: 'login',
                             isUppercase: true,

                           ),
                          fallback:(context) => Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextButton(
                              text: 'Register Now',
                              function: ()
                              {
                                navigateTo(
                                  context,
                                  SocialRegisterScreen(),
                                );
                              },

                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
