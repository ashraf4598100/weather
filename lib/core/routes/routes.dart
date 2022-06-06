


import 'package:auto_route/auto_route.dart';

import 'package:weather/features/weather_details/presentation/pages/weather.dart';

import '../../features/home_page/presentation/pages/home_page.dart';

@MaterialAutoRouter(routes: [

  MaterialRoute(page: HomePage ,initial: true),
    MaterialRoute(page: Weather ),

],
replaceInRouteName :'Page , Route'   )
class $Routes {

}

 