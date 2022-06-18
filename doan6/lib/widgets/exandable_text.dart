
import 'package:doan6/utils/color.dart';
import 'package:doan6/utils/dimensions.dart';
import 'package:doan6/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExandableText extends StatefulWidget {
  final String text;
  const ExandableText({Key? key, required this.text}) : super(key: key);

  @override
  _ExandableTextState createState() => _ExandableTextState();
}

class _ExandableTextState extends State<ExandableText> {
  late String firsttext;
  late String secondtext;

  bool hidetext=true;
  double textheight=Dimensions.screenHeight/5.63;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.text.length>textheight){
      firsttext=widget.text.substring(0,textheight.toInt());
      secondtext=widget.text.substring(textheight.toInt()+1,widget.text.length);
    }else{
      firsttext=widget.text;
      secondtext="";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondtext.isEmpty?SmallText(height:1.8,color:AppColors.paraColor,size:Dimensions.font16,text: firsttext):Column(
        children: [
          SmallText(height:1.8,color:AppColors.paraColor,size:Dimensions.font16,text: hidetext ? firsttext+"...":(firsttext+secondtext)),
          InkWell(
            onTap: (){
              setState(() {
                hidetext=!hidetext;// nếu false thì quay về(firsttext+secondtext)
              });

            },
            child: Row(
              children: [
                SmallText(text: 'Xem thêm',color: AppColors.mainColor,),
                Icon(hidetext?Icons.arrow_drop_down: Icons.arrow_drop_up,color: AppColors.mainColor,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
