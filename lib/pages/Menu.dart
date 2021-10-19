import 'package:flutter/material.dart';
import 'package:mm_app/pages/CoffeInfo.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - 24) / 2;
    final double itemWidth = size.width / 4;

    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Placeholder(),
            ),
            Flexible(
              flex: 3,
              child: GridView.count(
                crossAxisCount: 3,
                childAspectRatio: (itemWidth / itemHeight),
                children: tiles,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// class PaginaIntermedia extends StatefulWidget {
//   final BluetoothDevice server;
//   const PaginaIntermedia({required this.server});

//   @override
//   _PaginaIntermediaState createState() => _PaginaIntermediaState();
// }

// class _PaginaIntermediaState extends State<PaginaIntermedia> {
//   bool _status = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Pagina intermedia'), actions: <Widget>[
//         Switch(
//           value: _status,
//           onChanged: (value) {
//             setState(() {
//               _status = value;
//             });
//             value
//                 ? Icon(Icons.bluetooth, color: Colors.black)
//                 : Icon(Icons.bluetooth_disabled,
//                     color: Theme.of(context).primaryColor);
//           },
//         )
//       ]),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             'Esta es la página intermedia',
//             textAlign: TextAlign.center,
//           ),
//           ElevatedButton(
//             child: Text('Ir a pagina del programa'),
//             onPressed: () => Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => ChatPage(server: widget.server),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
