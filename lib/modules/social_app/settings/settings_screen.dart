import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/cubit/cubit.dart';
import 'package:social_app/layout/social_app/cubit/states.dart';
import 'package:social_app/modules/social_app/edit_profile/edit_profile_screen.dart';
import 'package:social_app/shared/components/components.dart';

import '../../../shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>
      (
        listener: (context,state)
        {

        },
      builder: (context,state)
      {
        var userModel = SocialCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children:
            [
              Container(
                height: 190,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children:
                  [
                    Align(
                      child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                4,
                            ),
                            topRight: Radius.circular(
                              4,
                            ),
                          ),
                          image: DecorationImage(
                            image: NetworkImage('${userModel!.cover}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      alignment: AlignmentDirectional.topCenter,
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage('${userModel.image}'),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                  '${userModel.name}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                '${userModel.bio}',
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20
                ),
                child: Row(
                  children:
                  [
                    Expanded(
                      child: InkWell(
                        onTap: ()
                        {

                        },
                        child: Column(
                          children:
                          [
                            Text(
                                '100',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.caption,
                            ),

                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: ()
                        {

                        },
                        child: Column(
                          children:
                          [
                            Text(
                              '256',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Photos',
                              style: Theme.of(context).textTheme.caption,
                            ),

                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: ()
                        {

                        },
                        child: Column(
                          children:
                          [
                            Text(
                              '10k',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context).textTheme.caption,
                            ),

                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: ()
                        {

                        },
                        child: Column(
                          children:
                          [
                            Text(
                              '45',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Followings',
                              style: Theme.of(context).textTheme.caption,
                            ),

                          ],
                        ),
                      ),
                    ),


                  ],
                ),
              ),
              Row(
                children:
                [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: (){},
                      child: Text(
                        'Add Photos',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed: ()
                    {
                      navigateTo(context, EditProfileScreen());
                    },
                    child: Icon(
                      IconBroken.Edit,
                      size: 16,
                    ),
                  ),

                ],
              ),


            ],
          ),
        );

      },
    );
  }
}
