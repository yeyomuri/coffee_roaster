import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:mm_app/widget/line_chart_widget.dart';

class ChatPage extends StatefulWidget {
  final BluetoothDevice server;
  final List<FlSpot>? perfilSpots;
  const ChatPage({required this.server, this.perfilSpots});

  @override
  _ChatPage createState() => new _ChatPage();
}

class _ChatPage extends State<ChatPage> {
  late BluetoothConnection? connection;

  List<String> messages = [];
  List<double> messagesDouble = [0];
  String _messageBuffer = '';
  double _currentSliderValueVelocity = 60;
  double _currentSliderValueGas = 60;
  double _currentSliderValueEscape = 0;

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;
  bool get isConnected => connection != null && connection!.isConnected;

  bool isDisconnecting = false;
  //Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection!.input!.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection!.dispose();
      connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LineChartWidget(
              messagesDouble.last, widget.perfilSpots ?? [FlSpot(0, 0)]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Slider(
                activeColor: Colors.red,
                inactiveColor: Colors.grey,
                value: _currentSliderValueGas,
                min: 10,
                max: 100,
                divisions: 9,
                label: '${_currentSliderValueGas.round()}%',
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValueGas = value;
                  });
                },
              ),
              Slider(
                activeColor: Colors.orange,
                inactiveColor: Colors.grey,
                value: _currentSliderValueEscape,
                min: 0,
                max: 100,
                divisions: 10,
                label: '${_currentSliderValueEscape.round()}%',
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValueEscape = value;
                  });
                },
              ),
              Slider(
                activeColor: Colors.blue,
                inactiveColor: Colors.grey,
                value: _currentSliderValueVelocity,
                min: 40,
                max: 160,
                divisions: 24,
                label: '${_currentSliderValueVelocity.round()} RPM',
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValueVelocity = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        messages.add(
          backspacesCounter > 0
              ? _messageBuffer.substring(
                  0, _messageBuffer.length - backspacesCounter)
              : _messageBuffer + dataString.substring(0, index),
        );
        messagesDouble = messages.map(double.parse).toList();
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

  void _sendMessage(String text) async {
    text = text.trim();
    textEditingController.clear();

    if (text.length > 0) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode(text + "\r\n")));
        await connection!.output.allSent;

        /* setState(() {
          //messages.add(_Message(clientID, text));
        }); */

        Future.delayed(Duration(milliseconds: 333)).then((_) {
          listScrollController.animateTo(
              listScrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 333),
              curve: Curves.easeOut);
        });
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }
}
