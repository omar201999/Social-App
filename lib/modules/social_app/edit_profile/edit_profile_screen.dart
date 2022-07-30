import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/cubit/cubit.dart';
import 'package:social_app/layout/social_app/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';


class EditProfileScreen extends StatelessWidget
{
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state)
        {

        },
        builder: (context,state)
        {
          var userModel = SocialCubit.get(context).userModel;
          var profileImage = SocialCubit.get(context).profileImage;
          var coverImage = SocialCubit.get(context).coverImage;


          nameController.text = userModel!.name!;
          print(userModel.name!);
          phoneController.text = userModel.phone!;
          bioController.text = userModel.bio!;


          return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: 'Edit Profile',
              actions: [
                defaultTextButton(
                    function: ()
                    {
                      SocialCubit.get(context).updateUser(
                          name: nameController.text,
                          phone: phoneController.text,
                          bio: bioController.text,
                      );
                    },
                    text: 'Update',
                ),
                SizedBox(
                  width: 15,
                ),
              ],
            ),

            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children:
                  [
                    if(state is SocialUserUpdateLoadingState)
                      LinearProgressIndicator(),
                    if(state is SocialUserUpdateLoadingState)
                      SizedBox(
                        height: 10,
                      ),
                    Container(
                      height: 190,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children:
                        [
                          Align(
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
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
                                      image: coverImage == null ? NetworkImage('${userModel.cover}') : FileImage(coverImage) as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: ()
                                    {
                                      SocialCubit.get(context).getCoverImage();
                                    }, icon: CircleAvatar(
                                     radius: 20,
                                      child: Icon(
                                     IconBroken.Camera,
                                     size: 16,
                                    ),
                                    ),
                                ),
                              ],
                            ),
                            alignment: AlignmentDirectional.topCenter,
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 64,
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: profileImage == null ? NetworkImage('${userModel.image}') : FileImage(profileImage) as ImageProvider ,
                                ),
                              ),
                              IconButton(
                                onPressed: ()
                                {
                                  SocialCubit.get(context).getProfileImage();
                                }, icon: CircleAvatar(
                                radius: 20,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 16,
                                ),
                              ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if(SocialCubit.get(context).profileImage !=null ||
                        SocialCubit.get(context).coverImage !=null )
                      Row(
                        children:
                        [
                          if(SocialCubit.get(context).profileImage !=null)
                            Expanded(
                            child: Column(
                              children:
                              [
                                defaultButton(
                                  function: ()
                                  {
                                    SocialCubit.get(context).uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                    );
                                  },
                                    text: 'Upload profile',
                                ),
                                if(state is SocialUserUpdateLoadingState)
                                  SizedBox(
                                  height: 5,
                                ),
                                if(state is SocialUserUpdateLoadingState)
                                  LinearProgressIndicator()
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          if(SocialCubit.get(context).coverImage !=null)
                            Expanded(
                              child: Column(
                                children:
                                [
                                  defaultButton(
                                    function: ()
                                    {
                                      SocialCubit.get(context).uploadCoverImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                      );
                                    },
                                    text: 'Upload Cover',
                                  ),
                                  if(state is SocialUserUpdateLoadingState)
                                    SizedBox(
                                      height: 5,
                                    ),
                                  if(state is SocialUserUpdateLoadingState)
                                    LinearProgressIndicator()
                                ],
                              ),
                            ),

                        ],
                      ),
                    if(SocialCubit.get(context).profileImage !=null ||
                        SocialCubit.get(context).coverImage !=null )
                      SizedBox(
                        height: 20,
                      ),
                    defaultFormField(
                        controller: bioController,
                        type: TextInputType.text,
                        validate: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'bio must not be empty';
                          }
                          return null;

                        },
                        label: 'Bio',
                        prefix: IconBroken.Info_Circle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String? value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'name must not be empty';
                        }
                        return null;

                      },
                      label: 'Name',
                      prefix: IconBroken.User,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String? value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'phone number must not be empty';
                        }
                        return null;

                      },
                      label: 'Phone',
                      prefix: IconBroken.Call,
                    ),
                    SizedBox(
                      height: 10,
                    ),

                  ],
                ),
              ),
            ),
          );

        },

    );
  }
}
