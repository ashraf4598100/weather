import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather/features/weather_details/presentation/bloc/weather_bloc.dart';
import 'package:weather/features/weather_details/presentation/widgets/weather_info_box.dart';
import '../../../../injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Weather extends StatefulWidget {
  final DateTime date;
  const Weather({Key? key, required this.date}) : super(key: key);

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  List<String> weatherStatus = ["Clouds", "Clear", "Rain"];

  late double wind;
  String? status;
  late double temp;
  late int humidity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WeatherBloc>()
        ..add(GetWeatherDetailsEvent(
          widget.date,
        )),
      child: Scaffold(
        body: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is Error) {
              Fluttertoast.showToast(
                  msg: state.error, gravity: ToastGravity.TOP);
            }
          },
          builder: (context, state) {
            if (state is GetWeatherDetailsState) {
              wind = state.weatherInfo.wind!.speed!;

              status = state.weatherInfo.weather![0].main!;
              temp = state.weatherInfo.main!.temp!;
              humidity = state.weatherInfo.main!.humidity!;
            }

            if (state is Loading) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              ));
            }
            return status != null
                ? Container(
                    color: status == "Clear"
                        ? const Color.fromARGB(255, 240, 187, 109)
                        : status == "Clouds"
                            ? const Color.fromARGB(255, 184, 234, 186)
                            : Colors.blue,
                    width: double.infinity,
                    height: 812.h,
                    child: Stack(
                      children: [
                        Center(
                            child: Image.asset(
                          status == "Clear"
                              ? 'assets/images/sun.png'
                              : status == "Clouds"
                                  ? "assets/images/cloud.png"
                                  : "assets/images/rain.png",
                          height: 200.h,
                          width: 200.w,
                        )),
                        Positioned(
                          bottom: 170.h,
                          left: 50.w,
                          child: Text("DUBAI",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic)),
                        ),
                        Positioned(
                          bottom: 140.h,
                          left: 130.w,
                          child: Container(
                            alignment: Alignment.center,
                            width: 20.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.white),
                                shape: BoxShape.circle),
                          ),
                        ),
                        Positioned(
                          bottom: 70.h,
                          width: 375.w,
                          child: SizedBox(
                            height: 100.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 30.w,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      (temp.toInt() - 273.15)
                                          .toInt()
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 70.sp,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 40.w,
                                ),
                                WeatherInfoBox(
                                  height: 80.h,
                                  width: 110.w,
                                  hint: 'Wind',
                                  unit: 'km/h',
                                  value: wind,
                                ),
                                WeatherInfoBox(
                                    height: 80.h,
                                    width: 70.w,
                                    hint: 'Humidity',
                                    value: humidity.toDouble(),
                                    unit: '%')
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                            top: 50.h,
                            left: 40.w,
                            child: Text(
                              status == "Clear"
                                  ? "Sunny\nDay\nWalk"
                                  : status == "Rain"
                                      ? "it's\nRainy\nDay"
                                      : "its's\nCloudy\nDay",
                              style: TextStyle(
                                color: Colors.grey[50],
                                fontSize: 50.sp,
                              ),
                            )),
                      ],
                    ))
                :const SizedBox();
          },
        ),
      ),
    );
  }
}
