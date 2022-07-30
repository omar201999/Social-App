
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/cubit/cubit.dart';
import 'package:social_app/layout/social_app/cubit/states.dart';
import 'package:social_app/models/social_app/post_model.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';


class FeedsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state)
      {

      },
      builder: (context,state)
      {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.isNotEmpty,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children:
              [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  margin: EdgeInsets.all(8),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children:
                    [
                      Image(
                        image: NetworkImage('https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg'),
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Communicate With Friends',
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Colors.white
                          ),
                        ),
                      ),

                    ],
                  ),

                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index) => buildPostItem(SocialCubit.get(context).posts[index],context,index),
                    separatorBuilder: (context,index) => SizedBox(
                      height: 8,
                    ) ,
                    itemCount: SocialCubit.get(context).posts.length
                ),
                SizedBox(
                  height: 8.0,
                ),

              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        ) ;
      },

    );
  }
  Widget buildPostItem(PostModel model,context,index) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5,
    margin: EdgeInsets.symmetric(
      horizontal: 8,
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Row(
            children:
            [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage('${SocialCubit.get(context).userModel!.image}'),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Row(
                        children:
                        [
                          Text(
                            '${model.name}',
                            style: TextStyle(
                              height: 1.4,
                            ),
                          ),
                          SizedBox( width:  5,),
                          Icon(
                              Icons.check_circle,
                            color: defaultColor,
                            size: 16,
                          ),
                        ],
                      ),
                      Text(
                          '${model.dataTime}',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
              ),
              SizedBox(
                width: 15,
              ),
              IconButton(
                  onPressed:(){},
                  icon: Icon(
                    Icons.more_horiz,
                    size: 16,
                  ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 15,
            ),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          Text(
            '${model.text}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
                end: 6,
            ),
            child: Container(
              width: double.infinity,
              child: Wrap(
                children:
                [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: 6,
                    ),
                    child: Container(
                      height: 25,
                      child: MaterialButton(
                        padding: EdgeInsets.zero,
                          minWidth:1,
                          onPressed: ()
                          {

                          },
                        child: Text(
                          '#software',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                            color:  defaultColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: 6,
                    ),
                    child: Container(
                      height: 25,
                      child: MaterialButton(
                        padding: EdgeInsets.zero,
                        minWidth:1,
                        onPressed: ()
                        {

                        },
                        child: Text(
                          '#flutter',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                            color:  defaultColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if(model.postImage != '')
            Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 15
            ),
            child: Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                  image: NetworkImage(
                    '${model.postImage}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            child:  Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            size: 16.0,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '5',//${SocialCubit.get(context).likes[index]}
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            size: 16.0,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '0 comment',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children:
            [
              Expanded(
                child: InkWell(
                  onTap: ()
                  {

                  },
                  child: Row(
                    children:
                    [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).userModel!.image}',
                        ),
                      ),
                      SizedBox(
                          width: 15,
                      ),
                      Text(
                          'write your commnent',
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:
                    [
                      Icon(
                          IconBroken.Heart,
                        size: 16,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ),

            ],

          ),

        ],
      ),
    ),
  );

}
