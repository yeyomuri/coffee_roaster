import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:mm_app/pages/EditNotePage.dart';
import 'package:mm_app/pages/Graphics.dart';
import 'package:mm_app/utils/note.dart';
import 'package:mm_app/utils/notes_database.dart';
import 'package:mm_app/widget/note_card_widget.dart';
import 'package:provider/provider.dart';

class PersonalizedCoffee extends StatefulWidget {
  @override
  _PersonalizedCoffeeState createState() => _PersonalizedCoffeeState();
}

class _PersonalizedCoffeeState extends State<PersonalizedCoffee> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final server = Provider.of<BluetoothDevice>(context);
    return Scaffold(
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : notes.isEmpty
                ? Text(
                    'Sin Perfiles',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  )
                : Row(
                    children: [
                      Flexible(flex: 1, child: Placeholder()),
                      Flexible(
                        flex: 3,
                        child: buildNotes(server),
                      ),
                    ],
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white70,
        child: Icon(Icons.add, color: Colors.brown),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddEditNotePage()),
          );

          refreshNotes();
        },
      ),
    );
  }

  Widget buildNotes(BluetoothDevice server) => GridView.builder(
        //scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: (MediaQuery.of(context).size.width / 4) /
              ((MediaQuery.of(context).size.height - 24) / 2),
        ),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];

          return FocusedMenuHolder(
              blurSize: 8,
              blurBackgroundColor: Colors.white,
              menuWidth: MediaQuery.of(context).size.width * 0.25,
              menuItemExtent: 50,
              duration: Duration(seconds: 0),
              animateMenuItems: false,
              menuOffset: 12,
              openWithTap: true,
              onPressed: () {},
              menuItems: [
                FocusedMenuItem(
                  backgroundColor: Colors.brown,
                  title: Text('Ejecutar'),
                  trailingIcon: Icon(Icons.send),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(
                        server: server,
                        perfilSpots: [
                          FlSpot(
                            double.parse(note.ax),
                            double.parse(note.ay),
                          ),
                          FlSpot(
                            double.parse(note.bx),
                            double.parse(note.by),
                          ),
                          FlSpot(
                            double.parse(note.cx),
                            double.parse(note.cy),
                          ),
                          FlSpot(
                            double.parse(note.dx),
                            double.parse(note.dy),
                          ),
                          FlSpot(
                            double.parse(note.ex),
                            double.parse(note.ey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                FocusedMenuItem(
                    backgroundColor: Colors.brown,
                    title: Text('Editar'),
                    trailingIcon: Icon(Icons.edit),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddEditNotePage(note: note)),
                      );
                      refreshNotes();
                    }),
                FocusedMenuItem(
                    backgroundColor: Colors.brown,
                    title: Text('Eliminar'),
                    trailingIcon: Icon(Icons.delete),
                    onPressed: () async {
                      await NotesDatabase.instance.delete(note.id);
                      refreshNotes();
                    }),
              ],
              child: NoteCardWidget(note: note, index: index));
          // );
        },
      );
}
