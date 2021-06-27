import 'package:flutter/foundation.dart';

final String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    /// Add all fields
    id, title, description, time, ax, ay, bx, by, cx, cy,
    dx, dy, ex, ey
  ];

  static final String id = '_id';
  static final String title = 'title';
  static final String description = 'description';
  static final String time = 'time';
  static final String ax = 'ax';
  static final String ay = 'ay';
  static final String bx = 'bx';
  static final String by = 'by';
  static final String cx = 'cx';
  static final String cy = 'cy';
  static final String dx = 'dx';
  static final String dy = 'dy';
  static final String ex = 'ex';
  static final String ey = 'ey';
}

class Note {
  final int id;
  final String title;
  final String description;
  final DateTime createdTime;
  final String ax;
  final String ay;
  final String bx;
  final String by;
  final String cx;
  final String cy;
  final String dx;
  final String dy;
  final String ex;
  final String ey;

  const Note({
    this.id,
    @required this.title,
    @required this.description,
    @required this.createdTime,
    @required this.ax,
    @required this.ay,
    @required this.bx,
    @required this.by,
    @required this.cx,
    @required this.cy,
    @required this.dx,
    @required this.dy,
    @required this.ex,
    @required this.ey,
  });

  Note copy({
    int id,
    String title,
    String description,
    DateTime createdTime,
    String ax,
    String ay,
    String bx,
    String by,
    String cx,
    String cy,
    String dx,
    String dy,
    String ex,
    String ey,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
        ax: ax ?? this.ax,
        ay: ay ?? this.ay,
        bx: bx ?? this.bx,
        by: by ?? this.by,
        cx: cx ?? this.cx,
        cy: cy ?? this.cy,
        dx: dx ?? this.dx,
        dy: dy ?? this.dy,
        ex: ex ?? this.ex,
        ey: ey ?? this.ey,
      );

  static Note fromJson(Map<String, Object> json) => Note(
        id: json[NoteFields.id] as int,
        title: json[NoteFields.title] as String,
        description: json[NoteFields.description] as String,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
        ax: json[NoteFields.ax] as String,
        ay: json[NoteFields.ay] as String,
        bx: json[NoteFields.bx] as String,
        by: json[NoteFields.by] as String,
        cx: json[NoteFields.cx] as String,
        cy: json[NoteFields.cy] as String,
        dx: json[NoteFields.dx] as String,
        dy: json[NoteFields.dy] as String,
        ex: json[NoteFields.ex] as String,
        ey: json[NoteFields.ey] as String,
      );

  Map<String, Object> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.description: description,
        NoteFields.time: createdTime.toIso8601String(),
        NoteFields.ax: ax,
        NoteFields.ay: ay,
        NoteFields.bx: bx,
        NoteFields.by: by,
        NoteFields.cx: cx,
        NoteFields.cy: cy,
        NoteFields.dx: dx,
        NoteFields.dy: dy,
        NoteFields.ex: ex,
        NoteFields.ey: ey,
      };
}
