// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../../features/home_page/presentation/pages/home_page.dart' as _i1;
import '../../features/weather_details/presentation/pages/weather.dart' as _i2;

class Routes extends _i3.RootStackRouter {
  Routes([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    HomePage.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    Weather.name: (routeData) {
      final args = routeData.argsAs<WeatherArgs>();
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i2.Weather(key: args.key, date: args.date));
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(HomePage.name, path: '/'),
        _i3.RouteConfig(Weather.name, path: '/Weather')
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomePage extends _i3.PageRouteInfo<void> {
  const HomePage() : super(HomePage.name, path: '/');

  static const String name = 'HomePage';
}

/// generated route for
/// [_i2.Weather]
class Weather extends _i3.PageRouteInfo<WeatherArgs> {
  Weather({_i4.Key? key, required DateTime date})
      : super(Weather.name,
            path: '/Weather', args: WeatherArgs(key: key, date: date));

  static const String name = 'Weather';
}

class WeatherArgs {
  const WeatherArgs({this.key, required this.date});

  final _i4.Key? key;

  final DateTime date;

  @override
  String toString() {
    return 'WeatherArgs{key: $key, date: $date}';
  }
}
