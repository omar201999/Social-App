import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/cubit/cubit.dart';
import 'package:social_app/layout/social_app/social_layout.dart';
import 'modules/social_app/social_login/social_login_screen.dart';
import 'shared/bloc_observer.dart';
import 'shared/components/constants.dart';
import 'shared/cubit/cubit.dart';
import 'shared/cubit/states.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/styles/themes.dart';


void main() async
{
  BlocOverrides.runZoned(
        () async {
          //بيتأكد ان كل حاجة هنا في الميثود  خلصت وبعدين يفتح الابلليكيشن
          WidgetsFlutterBinding.ensureInitialized();
          await Firebase.initializeApp();
          //DioHelper.init();
          await CacheHelper.init();
          //bool? isDark = CasheHelper.getData(key: 'isDark');
          Widget widget;
           uId = CacheHelper.getData(key: 'uId');
          print(uId);
          if(uId != null)
          {
            widget = SocialLayout();

          }else{
            widget =  SocialLoginScreen();
          }
          runApp( Myapp(
              startWidget: widget,
          )); //isDark!




        },
      blocObserver: MyBlocObserver(),
  );


}

class Myapp extends StatelessWidget
{
  //final bool isDark;
  //Myapp(this.isDark);
  final Widget? startWidget;
  Myapp({
    this.startWidget,
});

  @override
  Widget build(BuildContext context)
  {
    return  MultiBlocProvider(
      providers: [

        BlocProvider(create: (BuildContext context) => AppCubit()),

        BlocProvider(create: (context) => SocialCubit()..getUserData()..getPosts()),

  //fromShared: isDark)
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context, state)
        {

        },
        builder: (context,state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:lightTheme,
            darkTheme: darkTheme,
            themeMode:ThemeMode.light /* AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light*/ ,
            home: startWidget,
          );
        },

      ),
    );
  }
}