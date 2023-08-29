import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_mobile/providers/category_provider.dart';
import 'package:pokedex_mobile/providers/login_provider.dart';
import 'package:pokedex_mobile/providers/pokemon_provider.dart';
import 'package:pokedex_mobile/screens/pokemon_details.dart';
import 'package:pokedex_mobile/screens/pokemon_favorite_list.dart';
import 'package:pokedex_mobile/screens/pokemon_screen.dart';
import 'package:pokedex_mobile/treeWidget.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'screens/category_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CategoryProvider()),
          ChangeNotifierProvider(create: (context) => PokemonProvider()),
          ChangeNotifierProvider(create: (context) => LoginPk()),
        ],
        child: MaterialApp(
          title: 'Pokedex',
          //home: new MainWidget(),
          theme: ThemeData(primarySwatch: Colors.yellow),
          debugShowCheckedModeBanner: false,
          initialRoute:
              'category_screen', // Cambia 'login' por la ruta de inicio de sesión.
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case MainWidget.routeName:
                return MaterialPageRoute(
                  builder: (context) => const MainWidget(),
                );
              case PokemonDetailsScreen.routeName:
                return MaterialPageRoute(
                  builder: (context) => const PokemonDetailsScreen(),
                );
              default:
                return MaterialPageRoute(
                  builder: (context) =>
                      WidgetTree(), // Cambia 'LoginScreen' por tu pantalla de inicio de sesión.
                );
            }
          },
        ));
  }
}

class MainWidget extends StatefulWidget {
  static const routeName = '/';

  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  int _selectedIndex = 0;

  final List<Widget> _mainWidgets = const [
    CategoryScreen(),
    PokemonScreenWidget(),
    PokemonFavoriteListScreen()
  ];

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mainWidgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorias',
            backgroundColor: Colors.yellow,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.details),
            label: 'Pokemons',
            backgroundColor: Colors.yellow,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
            backgroundColor: Colors.yellow,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onTapItem,
      ),
    );
  }
}
