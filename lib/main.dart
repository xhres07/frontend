import 'package:aqua_store/screen/car_details.dart';
import 'package:aqua_store/screen/homepage.dart';
import 'package:aqua_store/screen/login_screen.dart';
import 'package:aqua_store/services/cartservices.dart';
import 'package:aqua_store/services/get_rent_services.dart';
import 'package:aqua_store/services/product_service.dart';
import 'package:aqua_store/services/searchProduct_api.dart';
import 'package:aqua_store/services/view_my_order_services.dart';
import 'package:aqua_store/utils/shared_preference.dart';
import 'package:aqua_store/utils/time_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: 'key1',
        channelName: 'Movieflix',
        channelDescription: "Notification example",
        defaultColor: Color.fromARGB(255, 235, 232, 238),
        ledColor: Colors.redAccent[700],
        playSound: true,
        enableLights: true,
        importance: NotificationImportance.High,
        enableVibration: true)
  ]);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => MyProduct()),
    ChangeNotifierProvider(create: (_) => TimeProvider()),
    ChangeNotifierProvider(create: (_) => GetAllOrders()),
    ChangeNotifierProvider(create: (_) => SearchProduct()),
    ChangeNotifierProvider(create: (_) => ViewMyOrders()),
    ChangeNotifierProvider(create: (_) => CartProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movieflix',
      theme: ThemeData(
        primaryColor: Colors.redAccent[700],
      ),
      home: LoginScreen(),
    );
  }
}
