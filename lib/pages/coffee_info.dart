import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:mm_app/main.dart';
import 'package:mm_app/my_flutter_app_icons.dart';
import 'package:mm_app/pages/personalized_coffee.dart';

const List<StaggeredTile> staggeredTiles = [
  StaggeredTile.count(1, 2), //0
  StaggeredTile.count(1, 1),
  StaggeredTile.count(1, 1),
  StaggeredTile.count(1, 1), //3
  StaggeredTile.count(1, 1),
  StaggeredTile.count(1, 1),
  StaggeredTile.count(1, 1), //6
];

List<Widget> tiles = [
  _Example01Tile(
    //0
    backgroundColor: Colors.yellow[300],
    iconData: Icons.coffee,
    beanColor: Colors.brown,
    title: 'Perfiles',
  ),
  _Example01Tile(
    backgroundColor: Colors.yellow[400],
    iconData: MyFlutterApp.coffe_bean,
    beanColor: Colors.brown[300],
    title: 'Claro',
    humidity1: '8',
    density1: '600',
    humidity2: '10',
    density2: '670',
    humidity3: '11',
    density3: '750',
    perfilSpots1: [
      FlSpot(0, 200), //a
      FlSpot(60, 100), //b
      FlSpot(200, 140), //c
      FlSpot(400, 170), //d
      FlSpot(720, 193), //e
    ],
    perfilSpots2: [
      FlSpot(0, 200), //a
      FlSpot(60, 200), //b
      FlSpot(200, 100), //c
      FlSpot(400, 50), //d
      FlSpot(720, 100), //e
    ],
    perfilSpots3: [
      FlSpot(0, 0), //a
      FlSpot(60, 100), //b
      FlSpot(200, 50), //c
      FlSpot(400, 200), //d
      FlSpot(720, 40), //e
    ],
  ),
  _Example01Tile(
    backgroundColor: Colors.yellow[400],
    iconData: MyFlutterApp.coffe_bean,
    beanColor: Colors.brown[500],
    title: 'Medio',
    humidity1: '8',
    density1: '600',
    humidity2: '10',
    density2: '670',
    humidity3: '11',
    density3: '750',
    perfilSpots1: [
      FlSpot(0, 200), //a
      FlSpot(60, 100), //b
      FlSpot(200, 140), //c
      FlSpot(400, 170), //d
      FlSpot(720, 193), //e
    ],
    perfilSpots2: [
      FlSpot(0, 200), //a
      FlSpot(60, 100), //b
      FlSpot(200, 140), //c
      FlSpot(400, 170), //d
      FlSpot(720, 193), //e
    ],
    perfilSpots3: [
      FlSpot(0, 200), //a
      FlSpot(60, 100), //b
      FlSpot(200, 140), //c
      FlSpot(400, 170), //d
      FlSpot(720, 193), //e
    ],
  ),
  _Example01Tile(
    //3
    backgroundColor: Colors.yellow,
    iconData: MyFlutterApp.coffe_bean,
    beanColor: Colors.deepOrange,
    title: 'Config',
  ),
  _Example01Tile(
    backgroundColor: Colors.yellow[400],
    iconData: MyFlutterApp.coffe_bean,
    beanColor: Colors.brown[700],
    title: 'Medio Oscuro',
    humidity1: '8',
    density1: '600',
    humidity2: '10',
    density2: '670',
    humidity3: '11',
    density3: '750',
    perfilSpots1: [
      FlSpot(0, 200), //a
      FlSpot(60, 100), //b
      FlSpot(200, 140), //c
      FlSpot(400, 170), //d
      FlSpot(720, 193), //e
    ],
    perfilSpots2: [
      FlSpot(0, 200), //a
      FlSpot(60, 100), //b
      FlSpot(200, 140), //c
      FlSpot(400, 170), //d
      FlSpot(720, 193), //e
    ],
    perfilSpots3: [
      FlSpot(0, 200), //a
      FlSpot(60, 100), //b
      FlSpot(200, 140), //c
      FlSpot(400, 170), //d
      FlSpot(720, 193), //e
    ],
  ),
  _Example01Tile(
    backgroundColor: Colors.yellow[400],
    iconData: MyFlutterApp.coffe_bean,
    beanColor: Colors.brown[900],
    title: 'Oscuro',
    humidity1: '8',
    density1: '600',
    humidity2: '10',
    density2: '670',
    humidity3: '11',
    density3: '750',
    perfilSpots1: [
      FlSpot(0, 200), //a
      FlSpot(60, 100), //b
      FlSpot(200, 140), //c
      FlSpot(400, 170), //d
      FlSpot(720, 193), //e
    ],
    perfilSpots2: [
      FlSpot(0, 200), //a
      FlSpot(60, 100), //b
      FlSpot(200, 140), //c
      FlSpot(400, 170), //d
      FlSpot(720, 193), //e
    ],
    perfilSpots3: [
      FlSpot(0, 200), //a
      FlSpot(60, 100), //b
      FlSpot(200, 140), //c
      FlSpot(400, 170), //d
      FlSpot(720, 193), //e
    ],
  ),
  _Example01Tile(
    //6
    backgroundColor: Colors.yellow,
    iconData: MyFlutterApp.coffe_bean,
    beanColor: Colors.purpleAccent,
    title: 'Personalizado',
  ),
];

class _Example01Tile extends StatelessWidget {
  const _Example01Tile(
      {this.backgroundColor,
      this.iconData,
      this.beanColor,
      this.title,
      this.humidity1,
      this.density1,
      this.humidity2,
      this.density2,
      this.humidity3,
      this.density3,
      this.perfilSpots1,
      this.perfilSpots2,
      this.perfilSpots3});

  final String title;
  final Color beanColor;
  final Color backgroundColor;
  final IconData iconData;
  final String humidity1;
  final String density1;
  final String humidity2;
  final String density2;
  final String humidity3;
  final String density3;
  final List<FlSpot> perfilSpots1;
  final List<FlSpot> perfilSpots2;
  final List<FlSpot> perfilSpots3;

  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
      blurSize: 8,
      blurBackgroundColor: Colors.white,
      menuWidth: MediaQuery.of(context).size.width * 0.25,
      menuItemExtent: 50,
      duration: Duration(seconds: 0),
      animateMenuItems: false,
      menuOffset: 12,
      openWithTap:
          title == 'Personalizado' || title == 'Perfiles' || title == 'Config'
              ? false
              : true,
      onPressed: () {
        if (title == 'Personalizado') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PersonalizedCoffee(),
            ),
          );
        }
      },
      menuItems: [
        FocusedMenuItem(
          backgroundColor: Colors.brown,
          title: Container(
            child: Column(
              children: [
                Text('Humedad: $humidity1%'),
                Text('Densidad: $density1 g/L'),
              ],
            ),
          ),

          /* Row(
            children: [Icon(Icons.alarm), Text('data')],
          ), */
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home(perfilSpots: perfilSpots1)),
          ),
        ),
        FocusedMenuItem(
          backgroundColor: Colors.brown,
          title: Container(
            child: Column(
              children: [
                Text('Humedad: $humidity2%'),
                Text('Densidad: $density2 g/L'),
              ],
            ),
          ),

          /* Row(
            children: [Icon(Icons.alarm), Text('data')],
          ), */
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home(perfilSpots: perfilSpots2)),
          ),
        ),
        FocusedMenuItem(
          backgroundColor: Colors.brown,
          title: Container(
            child: Column(
              children: [
                Text('Humedad: $humidity3%'),
                Text('Densidad: $density3 g/L'),
              ],
            ),
          ),

          /* Row(
            children: [Icon(Icons.alarm), Text('data')],
          ), */
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home(perfilSpots: perfilSpots3)),
          ),

          //Utils.showSnackbar(context, 'hola');
        ),
      ],
      child: Card(
        color: backgroundColor,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  color: beanColor,
                  size: 40,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.brown[700],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
