import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:hackathon/home_page/controller/bloc/home_bloc.dart';
import 'package:hackathon/home_page/controller/view/home_view.dart';
import 'package:hackathon/owned_pokemons/presentation/controller/owned_pokemons_bloc.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon_adapter.dart';
import 'package:hackathon/pokemon_at_stop/presentation/at_stop_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hackathon/pokemon_at_stop/presentation/controller/at_stop_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'owned_pokemons/presentation/view/owned_pokemons_view.dart';

/// The entry point of the app
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String appStorageDirectory =
      (await getApplicationDocumentsDirectory()).absolute.path;
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory:
          Directory("$appStorageDirectory/hydrated_bloc_storage"));
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

/// Some google sign in stuff
final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

/// Some google sign in stuff
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

/// Some google sign in stuff
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

  /// Some google sign in stuff
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

  /// Some google sign in stuff
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
            SignInButton(
              Buttons.GoogleDark,
              text: "Sign up with Google",
              onPressed: signIn,
            )
          ],
        ),
      );
    }
  }

  /// Some google sign in stuff
  void signOut() {
    _googleSignIn.disconnect();
  }

  /// Some google sign in stuff
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

/// The main app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // The MultiBlocProvider is used to provide multiple blocs to the app
    return MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(create: ((context) => HomeBloc())),
          BlocProvider<OwnedPokemonsBloc>(
              lazy: true, create: ((context) => OwnedPokemonsBloc())),
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
            return AtStopBloc(
              stopName: json["stop_name"].toString(),
              wildPokemon: PokemonAdapter.fromJson(json: json["pokemon_data"]),
            );
          }),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // The routes are used to navigate between the different views
          routes: {
            '/': (context) => const HomeView(),
            'pokemon_at_stop': (context) => const PokemonsAtStopView(),
            'owned_pokemons': (context) => OwnedPokemons(),
          },
        ));
  }
}
