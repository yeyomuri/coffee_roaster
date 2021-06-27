import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:mm_app/main.dart';
import 'package:mm_app/pages/edit_note_page.dart';
import 'package:mm_app/utils/note.dart';
import 'package:mm_app/utils/notes_database.dart';
import 'package:mm_app/widget/note_card_widget.dart';

class PersonalizedCoffee extends StatefulWidget {
  @override
  _PersonalizedCoffeeState createState() => _PersonalizedCoffeeState();
}

class _PersonalizedCoffeeState extends State<PersonalizedCoffee> {
  List<Note> notes;
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
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Perfiles',
            style: TextStyle(fontSize: 24),
          ),
          backgroundColor: Colors.brown,
          elevation: 0,
          actions: [Icon(Icons.search), SizedBox(width: 12)],
        ),
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : notes.isEmpty
                  ? Text(
                      'Sin Perfiles',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : buildNotes(),
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

  Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes[index];

          /*  return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Home(
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
                    //NoteDetailPage(noteId: note.id),
                  ),
                ),
              );

              refreshNotes();
            }, */
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
                      builder: (context) => Home(
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
