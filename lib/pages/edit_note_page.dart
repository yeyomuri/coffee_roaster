import 'package:flutter/material.dart';
import 'package:mm_app/utils/note.dart';
import 'package:mm_app/utils/notes_database.dart';
import 'package:mm_app/widget/chart.dart';
import 'package:mm_app/widget/note_form_widget.dart';

class AddEditNotePage extends StatefulWidget {
  final Note note;
  const AddEditNotePage({
    Key key,
    this.note,
  }) : super(key: key);
  @override
  _AddEditNotePageState createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final _formKey = GlobalKey<FormState>();
  String title;
  String description;
  String ax, ay, bx, by, cx, cy, dx, dy, ex, ey;

  @override
  void initState() {
    super.initState();

    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
    ax = widget.note?.ax ?? "";
    ay = widget.note?.ay ?? "";
    bx = widget.note?.bx ?? "";
    by = widget.note?.by ?? "";
    cx = widget.note?.cx ?? "";
    cy = widget.note?.cy ?? "";
    dx = widget.note?.dx ?? "";
    dy = widget.note?.dy ?? "";
    ex = widget.note?.ex ?? "";
    ey = widget.note?.ey ?? "";
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, left: 20, right: 35, bottom: 8),
                  child: Column(
                    children: [
                      Expanded(
                        child: Text(
                          'Curva S',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      LineChartSample5(),
                      SizedBox(
                        height: 20,
                      ),
                      buildButton(),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: NoteFormWidget(
                    title: title,
                    description: description,
                    ax: ax,
                    ay: ay,
                    bx: bx,
                    by: by,
                    cx: cx,
                    cy: cy,
                    dx: dx,
                    dy: dy,
                    ex: ex,
                    ey: ey,
                    onChangedAx: (ax) => setState(() => this.ax = ax),
                    onChangedAy: (ay) => setState(() => this.ay = ay),
                    onChangedBx: (bx) => setState(() => this.bx = bx),
                    onChangedBy: (by) => setState(() => this.by = by),
                    onChangedCx: (cx) => setState(() => this.cx = cx),
                    onChangedCy: (cy) => setState(() => this.cy = cy),
                    onChangedDx: (dx) => setState(() => this.dx = dx),
                    onChangedDy: (dy) => setState(() => this.dy = dy),
                    onChangedEx: (ex) => setState(() => this.ex = ex),
                    onChangedEy: (ey) => setState(() => this.ey = ey),
                    onChangedTitle: (title) =>
                        setState(() => this.title = title),
                    onChangedDescription: (description) =>
                        setState(() => this.description = description),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty &&
        description.isNotEmpty &&
        ax.isNotEmpty &&
        ay.isNotEmpty &&
        bx.isNotEmpty &&
        by.isNotEmpty &&
        cx.isNotEmpty &&
        cy.isNotEmpty &&
        dx.isNotEmpty &&
        dy.isNotEmpty &&
        ex.isNotEmpty &&
        ey.isNotEmpty;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          onPrimary: Colors.brown[400],
          primary: isFormValid
              ? Colors.yellow
              : Theme.of(context).unselectedWidgetColor),
      onPressed: addOrUpdateNote,
      child: Text('Guardar'),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }
      Navigator.pop(context);
    }
  }

  Future updateNote() async {
    final note = widget.note.copy(
      title: title,
      description: description,
      ax: ax,
      ay: ay,
      bx: bx,
      by: by,
      cx: cx,
      cy: cy,
      dx: dx,
      dy: dy,
      ex: ex,
      ey: ey,
    );

    await NotesDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = Note(
      title: title,
      description: description,
      createdTime: DateTime.now(),
      ax: ax,
      ay: ay,
      bx: bx,
      by: by,
      cx: cx,
      cy: cy,
      dx: dx,
      dy: dy,
      ex: ex,
      ey: ey,
    );
    await NotesDatabase.instance.create(note);
  }
}
