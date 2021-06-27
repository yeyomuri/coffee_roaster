import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final String ax, ay, bx, by, cx, cy, dx, dy, ex, ey;
  final ValueChanged<String> onChangedAx;
  final ValueChanged<String> onChangedAy;
  final ValueChanged<String> onChangedBx;
  final ValueChanged<String> onChangedBy;
  final ValueChanged<String> onChangedCx;
  final ValueChanged<String> onChangedCy;
  final ValueChanged<String> onChangedDx;
  final ValueChanged<String> onChangedDy;
  final ValueChanged<String> onChangedEx;
  final ValueChanged<String> onChangedEy;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  const NoteFormWidget({
    Key key,
    this.title = '',
    this.description = '',
    this.ax = '',
    this.ay = '',
    this.bx = '',
    this.by = '',
    this.cx = '',
    this.cy = '',
    this.dx = '',
    this.dy = '',
    this.ex = '',
    this.ey = '',
    @required this.onChangedTitle,
    @required this.onChangedDescription,
    @required this.onChangedAx,
    @required this.onChangedAy,
    @required this.onChangedBx,
    @required this.onChangedBy,
    @required this.onChangedCx,
    @required this.onChangedCy,
    @required this.onChangedDx,
    @required this.onChangedDy,
    @required this.onChangedEx,
    @required this.onChangedEy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              SizedBox(height: 8),
              buildDescription(),
              SizedBox(height: 16),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Puntos',
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              buildCoordinate(
                  point: 'a ',
                  initialXValue: ax,
                  initialYValue: ay,
                  onChangedX: onChangedAx,
                  onChangedY: onChangedAy),
              //SizedBox(height: 8),
              buildCoordinate(
                  point: 'b ',
                  initialXValue: bx,
                  initialYValue: by,
                  onChangedX: onChangedBx,
                  onChangedY: onChangedBy),
              //SizedBox(height: 8),
              buildCoordinate(
                  point: 'c ',
                  initialXValue: cx,
                  initialYValue: cy,
                  onChangedX: onChangedCx,
                  onChangedY: onChangedCy),
              //SizedBox(height: 8),
              buildCoordinate(
                  point: 'd ',
                  initialXValue: dx,
                  initialYValue: dy,
                  onChangedX: onChangedDx,
                  onChangedY: onChangedDy),
              //SizedBox(height: 8),
              buildCoordinate(
                  point: 'e ',
                  initialXValue: ex,
                  initialYValue: ey,
                  onChangedX: onChangedEx,
                  onChangedY: onChangedEy),
              //SizedBox(height: 8),
            ],
          ),
        ),
      );

  Widget buildCoordinate({
    String point,
    String initialXValue,
    String initialYValue,
    ValueChanged<String> onChangedX,
    ValueChanged<String> onChangedY,
  }) =>
      Row(children: [
        Expanded(
          child: Text(
            '$point: ',
            style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.number,
            maxLines: 1,
            initialValue: initialXValue,
            style: TextStyle(color: Colors.white60, fontSize: 18),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 's',
              hintStyle: TextStyle(color: Colors.white70),
            ),
            validator: (title) =>
                title != null && title.isEmpty ? 'No puede estar vacío' : null,
            onChanged: onChangedX,
          ),
        ),
        Expanded(
          flex: 1,
          child: TextFormField(
            keyboardType: TextInputType.number,
            maxLines: 1,
            initialValue: initialYValue,
            style: TextStyle(color: Colors.white60, fontSize: 18),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '°C',
              hintStyle: TextStyle(color: Colors.white70),
            ),
            validator: (title) =>
                title != null && title.isEmpty ? 'No puede estar vacío' : null,
            onChanged: onChangedY,
          ),
        ),
      ]);

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Título',
          hintStyle: TextStyle(color: Colors.white70),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'El título no puede estar vacío'
            : null,
        onChanged: onChangedTitle,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 2,
        initialValue: description,
        style: TextStyle(color: Colors.white60, fontSize: 18),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Descripción...',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'La descripción no puede estar vacía'
            : null,
        onChanged: onChangedDescription,
      );
}
