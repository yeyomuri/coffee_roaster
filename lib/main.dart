import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mm_app/connection.dart';
import 'package:mm_app/pages/dispensador.dart';
import 'package:mm_app/pages/coffee_info.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.white70,
          selectionColor: Colors.white70,
          selectionHandleColor: Colors.white70,
        ),
        backgroundColor: Colors.brown,
        colorScheme: ColorScheme.dark(),
        scaffoldBackgroundColor: Colors.brown,
        accentColor: Colors.lightGreen.shade400,
        unselectedWidgetColor: Colors.brown[700],
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(Colors.white),
        ),
      ),
      home: FutureBuilder(
        future: FlutterBluetoothSerial.instance.requestEnable(),
        builder: (context, future) {
          if (future.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Container(
                height: double.infinity,
                child: Center(
                  child: Icon(
                    Icons.bluetooth_disabled,
                    size: 200.0,
                    color: Colors.blue,
                  ),
                ),
              ),
            );
          } else if (future.connectionState == ConnectionState.done) {
            // return MyHomePage(title: 'Flutter Demo Home Page');
            return GridPage();
          } else {
            return GridPage();
          }
        },
        // child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

//------------------------------------------GRID PAGE------------------------------------------------

class GridPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: StaggeredGridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            staggeredTiles: staggeredTiles,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            padding: const EdgeInsets.all(4),
            children: tiles,
          ),
        ),
      ),
    );
  }
}

//-----------------------------------------HOME--------------------------------------------------------------

class Home extends StatelessWidget {
  final List<FlSpot> perfilSpots;

  Home({this.perfilSpots});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: Text(
            'Conexión Bluetooth',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
        ),
        backgroundColor: Colors.brown,
        elevation: 0,
      ),
      body: SelectBondedDevicePage(
        onCahtPage: (device1) {
          BluetoothDevice device = device1;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChatPage(server: device, perfilSpots: perfilSpots);
              },
            ),
          );
        },
      ),
    ));
  }
}
