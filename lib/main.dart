import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firewatch App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  bool darkMode = false;
  bool gps = true;
  double _defaultSliderValue = 25;
  bool isDark = false;
  List<String> favourites = <String>[
    'Bassendean',
    'Northbridge',
    'Innaloo',
    'Mundaring',
    'Fremantle',
  ];

  static const TextStyle headerStyle =
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  static const TextStyle bodyStyle = TextStyle(fontSize: 18);

  Widget _getNavigationBarItem(int index) {
    List<Widget> _widgetOptions = <Widget>[
      Padding(
        padding: const EdgeInsets.all(32),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const Text('SETTINGS', style: headerStyle),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Dark Mode',
                style: bodyStyle,
              ),
              Switch(
                  value: darkMode,
                  onChanged: (bool value) {
                    setState(() {
                      darkMode = value;
                    });
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'GPS',
                style: bodyStyle,
              ),
              Switch(
                  value: gps,
                  onChanged: (bool value) {
                    setState(() {
                      gps = value;
                    });
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Radius (km)',
                style: bodyStyle,
              ),
              Slider(
                value: _defaultSliderValue,
                max: 100,
                divisions: 100,
                label: _defaultSliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _defaultSliderValue = value;
                  });
                },
              ),
            ],
          )
        ]),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SearchAnchor(
                  builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  controller: controller,
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0)),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  leading: const Icon(Icons.search),
                  );
              }, suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                return List<ListTile>.generate(5, (int index) {
                  final String item = 'item $index';
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      setState(() {
                        controller.closeView(item);
                      });
                    },
                  );
                });
              }),
            ],
          )
        ]),
      ),
      Padding(
        padding: const EdgeInsets.all(32),
        child: Column(children: [
          const Text(
            'FAVOURITES',
            style: headerStyle,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 300,
                width: 300,
                child: ListView.builder(
                  padding: const EdgeInsets.all(4),
                  shrinkWrap: true,
                  itemCount: favourites.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: _openFavouriteLocation,
                              child: Text(
                                favourites[index],
                                style: bodyStyle,
                              )),
                          IconButton(
                            onPressed: _removeFavourite,
                            icon: const Icon(Icons.delete_forever_outlined),
                          ),
                        ]);
                  },
                ),
              ),
            ],
          )
        ]),
      )
    ];

    return _widgetOptions[index];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _openSearch() {}

  void _removeFavourite() {}

  void _openFavouriteLocation() {}

  void _darkMode() {
    final ThemeData themeData = ThemeData(
        useMaterial3: true,
        brightness: isDark ? Brightness.dark : Brightness.light);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: _getNavigationBarItem(_selectedIndex),
      ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: _openSearch, child: const Icon(Icons.search_outlined)),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined), label: 'Settings'),
            BottomNavigationBarItem(
                icon: Icon(Icons.fireplace_outlined), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.star_outline), label: 'Favourites'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped),
    );
  }
}
