import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/cubit/cubit.dart';
import 'package:social_app/layout/social_app/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';

import '../../../shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget
{
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context,state)
      {
        var now = DateTime.now();
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Creat Post',
            actions: [
              defaultTextButton(
                  function: ()
                  {
                    if(SocialCubit.get(context).postImage == null)
                    {
                      SocialCubit.get(context).creatPost(
                          dateTime: now.toString(),
                          text: textController.text,
                      );
                    } else
                    {
                      SocialCubit.get(context).uploadPostImage(
                          dateTime: now.toString(),
                          text: textController.text,
                      );
                    }

                  },
                  text: 'Post',
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children:
              [
                if(state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(
                    height: 10,
                  ),
                Row(
                  children:
                  [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage('${SocialCubit.get(context).userModel!.image}',
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                     '${SocialCubit.get(context).userModel!.name}',
                        style: TextStyle(
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: 'what is on your mind ...',
                        border: InputBorder.none,
                      ),
                    ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image: FileImage(SocialCubit.get(context).postImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: ()
                      {
                        SocialCubit.get(context).removePostImage();
                      }, icon: CircleAvatar(
                      radius: 20,
                      child: Icon(
                        Icons.close,
                        size: 16,
                      ),
                    ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children:
                  [
                    Expanded(
                      child: TextButton(
                          onPressed: ()
                          {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                              Icon(
                                IconBroken.Image,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  'add photo',
                              ),
                            ],
                          ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: ()
                        {
                        },
                        child: Text(
                          '# tags',
                        ),
                      ),
                    ),
                  ],
                ),


              ],
            ),
          ),
        );
      },
    );
  }
}
