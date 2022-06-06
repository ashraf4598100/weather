import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherInfoBox extends StatelessWidget {
  final double height;
  final double width;
  final String hint;
  final double value;
  final String unit;
  const WeatherInfoBox({Key? key, required this.height, required this.width, required this.hint, required this.value, required this.unit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return          Container(height:height,
                     width: width,
                       decoration: BoxDecoration(color: Colors.grey[50],borderRadius: const BorderRadius.all(Radius.circular(5))),child: Padding(
                         padding:  EdgeInsets.all(8.0.h),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             Text(
                               hint,style: TextStyle(color: Colors.black,fontSize:  13.sp,fontStyle: FontStyle.italic),
                               overflow: TextOverflow.ellipsis,
                               ),
                              Text("${value.toInt()}""$unit",style: TextStyle(color: Colors.black,fontSize: 16.sp))
                           ],
                         ),
                       ),);
  }
}