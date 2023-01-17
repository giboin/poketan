import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/home_page/controller/bloc/home_bloc.dart';
import 'package:hackathon/home_page/controller/view/home_view.dart';
import 'package:hackathon/owned_pokemons/presentation/controller/owned_pokemons_bloc.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';
import 'package:hackathon/pokemon_at_stop/presentation/at_stop_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hackathon/pokemon_at_stop/presentation/controller/at_stop_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'owned_pokemons/presentation/view/owned_pokemons_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String temporaryPath = (await getTemporaryDirectory()).absolute.path;
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: Directory("$temporaryPath/hydrated_bloc_storage"));
  runApp(const MaterialApp(
    home: Login(),
  ));
}

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        alignment: Alignment.center,
        child: _buildWidget(),
      ),
    );
  }

  AppBar _buildAppBar() {
    GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return AppBar(
        leading: const Icon(Icons.person_rounded),
        title: Text(
          user.displayName ?? '',
          style: const TextStyle(fontSize: 18),
        ),
        actions: [
          ElevatedButton(onPressed: signOut, child: const Text('Sign out'))
        ],
      );
    } else {
      return AppBar(
        title: const Text('Login'),
      );
    }
  }

  Widget _buildWidget() {
    GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return const MyApp();
    } else {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'You are not signed in',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: signIn,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Sign in', style: TextStyle(fontSize: 30)),
                )),
          ],
        ),
      );
    }
  }

  void signOut() {
    _googleSignIn.disconnect();
  }

  Future<void> signIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (e) {
      if (kDebugMode) {
        print('Error signing in $e');
      }
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(create: ((context) => HomeBloc())),
          BlocProvider<OwnedPokemonsBloc>(
              lazy: false, create: ((context) => OwnedPokemonsBloc())),
          BlocProvider<AtStopBloc>(create: (context) {
            Map<String, dynamic> json =
                context.read<HomeBloc>().state.responseJson ??
                    {
                      "pokemon_data": {
                        'name': 'pokemon_name',
                        'lvl': 0,
                        'sprite_url':
                            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/0.png'
                      },
                      'stop_name': 'tan_stop'
                    };
            List<Pokemon> pokelist =
                context.read<OwnedPokemonsBloc>().state.pokeTeam;
            return AtStopBloc(
              stopName: json["stop_name"].toString(),
              wildPokemon: Pokemon(
                  pokedexId: json["pokemon_data"]["pokedex_id"],
                  name: json["pokemon_data"]["name"].toString(),
                  level: json["pokemon_data"]["lvl"],
                  pictureUrl: json["pokemon_data"]["sprite_url"].toString()),
              pokelist: pokelist,
            );
          }),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            '/': (context) => const HomeView(),
            'pokemon_at_stop': (context) => const PokemonsAtStopView(),
            'owned_pokemons': (context) => const OwnedPokemons(),
          },
        ));
  }
}
