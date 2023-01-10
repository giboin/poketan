import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/home_page/controller/bloc/home_bloc.dart';
import 'package:hackathon/home_page/controller/view/home_view.dart';
import 'package:hackathon/pokemon_at_stop/presentation/controller/at_stop_bloc.dart';
import 'package:hackathon/pokemon_at_stop/presentation/at_stop_view.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String temporaryPath = (await getTemporaryDirectory()).absolute.path;
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: Directory("${temporaryPath}/hydrated_bloc_storage"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(create: ((context) => HomeBloc())),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            '/': (context) => const HomeView(),
            'pokemon_at_stop': (context) => BlocProvider(
                create: (context) => AtStopBloc(
                      stopName: context
                          .read<HomeBloc>()
                          .state
                          .responseJson!["pokemon_data"],
                      wildPokemon: context
                          .read<HomeBloc>()
                          .state
                          .responseJson!["stop_name"],
                    ),
                child: const PokemonsAtStopView()),
          },
        ));
  }
}
