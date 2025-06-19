import 'dart:async';

import 'package:ai_home/core/theme/app_theme.dart';
import 'package:ai_home/features/dishes/presentation/bloc/dishes_bloc.dart';
import 'package:ai_home/injection/injection.dart';
import 'package:ai_home/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = getIt<AppRouter>();

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<DishesBloc>(
              create: (context) => getIt<DishesBloc>(),
            ),
          ],
          child: MaterialApp.router(
            title: 'Food App',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            routerConfig: appRouter.router,
          ),
        );
      },
    );
  }
}
