import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/shared/styles/icon_broken.dart';


AppBar defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) => AppBar(
  leading: IconButton(
    onPressed: ()
    {
      Navigator.pop(context);
    },
    icon: Icon(
      IconBroken.Arrow___Left_2,
    ),
  ),
  titleSpacing: 5.0,
  title: Text(
    title!,
  ),
  actions: actions,
);

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUppercase = true,
  double radius = 5,
  required VoidCallback  function,
  required String text,
}) => Container(
  width: width,
  height: 40,
  child: MaterialButton (
    onPressed: function,
    child: Text(
      isUppercase ? text.toUpperCase() : text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background,

  ),
);
Widget defaultFormField(
{
  required TextEditingController controller,
  required TextInputType type,
  void Function(String?)? onSubmit,
  required String? Function(String?)? validate,
  required String label,
  bool isPassword = false,
  required IconData prefix,
   IconData? suffix,
   void Function()? suffixPressed,
   void Function()? ontap,
  void Function(String)? onChanged,
  bool isClickable = true,
}) => TextFormField(
  keyboardType: type,
  controller: controller,
  onFieldSubmitted: onSubmit,
  onChanged: onChanged ,
  obscureText: isPassword,
  validator: validate,
  onTap: ontap,
  enabled: isClickable,
  decoration: InputDecoration(
    labelText: label ,
    prefixIcon: Icon(
        prefix
    ),
    suffixIcon:  suffix !=null ? IconButton(
      onPressed: suffixPressed,
      icon: Icon(
          suffix
      ),
    ) : null,
    border: OutlineInputBorder(),
  ),
);


Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20,
  ),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ),
);



void navigateTo(context,widget) =>  Navigator.push(
  context
  , MaterialPageRoute(builder: (context) => widget
  ),
);

void navigateAndFinish(context,widget) =>  Navigator.pushAndRemoveUntil(context,
  MaterialPageRoute(builder: (context) => widget
),
    (route)
    {
      return false;
    }

);

Widget defaultTextButton({
  required void Function()? function,
  required String text,
}) =>
    TextButton(
     onPressed:function,
        child: Text(
            text.toUpperCase(),
        ),
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}