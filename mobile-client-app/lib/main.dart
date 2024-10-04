
import 'package:desiroo/core/app_config.dart';
import 'package:desiroo/core/injections.dart';
import 'package:desiroo/features/wishlist/bloc/product_cubit.dart';
import 'package:desiroo/features/wishlist/bloc/products_cubit.dart';
import 'package:desiroo/core/theme/dark_theme.dart';
import 'package:desiroo/core/theme/light_theme.dart';
import 'package:desiroo/features/wishlist/bloc/wishlist_cubit.dart';
import 'package:desiroo/features/wishlist/bloc/wishlists_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:light_sensor/light_sensor.dart';

import 'core/navigation/router.dart';

main() async {
  DotEnv instance = DotEnv();
  await instance.load(fileName: '.env');
  final env = instance.env;
  AppConfig.create(baseUrl: env['BASE_URL'].toString());

  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode mode = ThemeMode.light;
  final threshold = 10;

  @override
  void initState() {
    LightSensor.hasSensor().then((hasSensor) {
      var count = 0;
      if (hasSensor) {
        LightSensor.luxStream().timeout(const Duration(seconds: 15),
            onTimeout: (lux) {
          count = 100;
          setTheme(count);
        }).listen((lux) {
          if (lux < threshold && count < 100) {
            count++;
          } else if (lux >= threshold && count > 0) {
            count--;
          }
          setTheme(count);
        });
      }
    });
    super.initState();
  }

  void setTheme(count) {
    if (count > 80 && mode == ThemeMode.light) {
      setState(() {
        mode = ThemeMode.dark;
      });
    }
    if (count < 20 && mode == ThemeMode.dark) {
      setState(() {
        mode = ThemeMode.light;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.instance.get<WishlistsCubit>(),
        ),
        BlocProvider(
          create: (context) => GetIt.instance.get<WishlistCubit>(),
        ),
        BlocProvider(
          create: (context) => GetIt.instance.get<ProductsCubit>(),
        ),
        BlocProvider(
          create: (context) => GetIt.instance.get<ProductCubit>(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: publicRoutes,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: mode,
        scrollBehavior: ScrollConfiguration.of(context).copyWith(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
        ),
      ),
    );
  }
}
