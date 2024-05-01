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
  List<String> favourites = <String>[
    'Bassendean',
    'Northbridge',
    'Innaloo',
    'Mundaring',
    'Fremantle'
  ];

  static const TextStyle optionStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  Widget _getNavigationBarItem(int index) {
    List<Widget> _widgetOptions = <Widget>[
      Padding(
        padding: const EdgeInsets.all(32),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Dark Mode',
                style: optionStyle,
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
              const Text('GPS Tracking', style: optionStyle),
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
                'Warning Radius (km)',
                style: optionStyle,
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
      const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.web_outlined)]),
      Padding(
        padding: const EdgeInsets.all(32),
        child: Column(children: [
          const Text(
            'FAVOURITES',
            style: optionStyle,
          ),
          Row(
            // TODO: Format favourites page to have locations and star icon side by side.
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ListView.builder(
                padding: const EdgeInsets.all(12),
                shrinkWrap: true,
                itemCount: favourites.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                      height: 50,
                      child: Center(child: Text(favourites[index])));
                },
              ),
              IconButton(
                onPressed: _toggleFavourite,
                icon: const Icon(Icons.star_outline),
              ),
            ],
          )
        ]),
      )
    ];

    // .map((e) => Container(padding: EdgeInsets.all(8.0), child: e).toList()

    return _widgetOptions[index];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _openSearch() {}

  void _toggleFavourite() {}

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
