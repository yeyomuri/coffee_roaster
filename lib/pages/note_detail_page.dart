import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mm_app/pages/edit_note_page.dart';
import 'package:mm_app/utils/note.dart';
import 'package:mm_app/utils/notes_database.dart';

class NoteDetailPage extends StatefulWidget {
  final int noteId;
  const NoteDetailPage({
    Key key,
    @required this.noteId,
  }) : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  Note note;
  bool isLoading = false;
  List<FlSpot> persolizedSpots;
  @override
  void initState() {
    super.initState();

    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    this.note = await NotesDatabase.instance.readNote(widget.noteId);

    setState(() => isLoading = false);
  }

/*
  @override
  Widget build(BuildContext context) {
    persolizedSpots = [
      FlSpot(double.parse(note.ax), double.parse(note.ay)),
      FlSpot(double.parse(note.bx), double.parse(note.by)),
      FlSpot(double.parse(note.cx), double.parse(note.cy)),
      FlSpot(double.parse(note.dx), double.parse(note.dy)),
      FlSpot(double.parse(note.ex), double.parse(note.ey))
    ];
     return Scaffold(
      appBar: AppBar(
        actions: [editButton(), deleteButton()],
      ),
      body: Column(
        children: [Expanded(child: LineChartWidget(persolizedSpots))],
      ),
    );
  }  */
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [editButton(), deleteButton()],
          backgroundColor: Colors.brown,
          elevation: 0,
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(12),
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      note.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      DateFormat.yMMMd().format(note.createdTime),
                      style: TextStyle(color: Colors.white38),
                    ),
                    SizedBox(height: 8),
                    Text(
                      note.description,
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Text(
                      note.ax.toString(),
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    )
                  ],
                ),
              ),
      );

  Widget editButton() => IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditNotePage(note: note),
        ));

        refreshNote();
      });

  Widget deleteButton() => IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          await NotesDatabase.instance.delete(widget.noteId);

          Navigator.of(context).pop();
        },
      );
}
