import 'package:flutter/material.dart';

Map model = {};
const titleInputDecoration = InputDecoration(
  label: Text('Task title'),
  prefixIcon: Icon(Icons.title),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(4.0),
    ),
  ),
);
const timeInputDecoration = InputDecoration(
  label: Text('Task Time'),
  prefixIcon: Icon(Icons.watch),
  border:
      OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
);
const dateInputDecoration = InputDecoration(
  label: Text('Task Time'),
  prefixIcon: Icon(Icons.calendar_today),
  border:
      OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
);
