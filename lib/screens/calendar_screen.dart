import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:table_calendar/table_calendar.dart';

DateTime focusedDay = DateTime.now();
DateTime? selectedDate = DateTime.now();

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

Map<String, dynamic> mySelectedEvents = {};
bool espChecked = false;
bool isSelected = false;
bool extraSelected = false;
bool normalSelected = false;
bool leveSelected = false;
bool graveSelected = false;
bool moderadaSelected = false;

bool medChecked = false;

List listDays(DateTime dateTime) {
  if (mySelectedEvents[DateFormat('MM-dd-yyyy').format(dateTime)] != null) {
    return mySelectedEvents[DateFormat('MM-dd-yyyy').format(dateTime)]!;
  } else {
    return [];
  }
}

CalendarFormat format = CalendarFormat.month;

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 247, 244, 244),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Olá, Yago!',
                style: TextStyle(color: Color(0xFF202C39), fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Como você está hoje?',
                style: TextStyle(color: Color(0xFFBABABA), fontSize: 15),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TableCalendar(
                      focusedDay: focusedDay,
                      firstDay: DateTime(2020),
                      lastDay: DateTime(2025),
                      onDaySelected: (newSelectedDay, newFocusedDay) {
                        if (!isSameDay(selectedDate, newSelectedDay)) {
                          setState(() {
                            selectedDate = newSelectedDay;
                            focusedDay = newFocusedDay;
                          });
                        }
                      },
                      eventLoader: listDays,
                      selectedDayPredicate: (day) {
                        return isSameDay(selectedDate, day);
                      },
                      locale: 'pt_BR',
                      calendarFormat: format,
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        leftChevronIcon: Icon(Icons.chevron_left),
                        rightChevronIcon: Icon(Icons.chevron_right),
                        rightChevronPadding: EdgeInsets.only(right: 80),
                        leftChevronPadding: EdgeInsets.only(left: 80),
                      ),
                      calendarStyle: CalendarStyle(
                        selectedDecoration: BoxDecoration(
                          color: Color(0xFF202C39),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    ...listDays(selectedDate!).map((myEvents) => Slidable(
                          endActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                  label: 'Deletar',
                                  backgroundColor: Colors.red,
                                  icon: Icons.delete,
                                  onPressed: (context) {
                                    _deleteEvent(myEvents);
                                  })
                            ],
                          ),
                          child: Card(
                            child: ListTile(
                              title: Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (myEvents['sangramento'] != null &&
                                        myEvents['sangramento'].isNotEmpty)
                                      Text(
                                        "Lesão: ${myEvents['sangramento']}",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    if (myEvents['fator'] != null &&
                                        myEvents['fator'].isNotEmpty)
                                      Text("Fator: ${myEvents['fator']}"),
                                    if (myEvents['espontaneo'] != null &&
                                        myEvents['espontaneo'].isNotEmpty)
                                      Text(
                                        "Lesão Espontânea:  ${myEvents['espontaneo']}",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    if (myEvents['medicação'] != null &&
                                        myEvents['medicação'].isNotEmpty)
                                      Text(
                                          "Fez uso de medicamento:  ${myEvents['medicação']}")
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: () {
              modal();
            },
            backgroundColor: Color(0xFF202C39),
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Future<void> modal() async {
    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: 500,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Row(
                        children: const [
                          Text(
                            "Gravidade da lesão",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: espacoLesao()),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text(
                            "Leve",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text('    Moderada',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          Text('Grave',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          SizedBox(width: 50),
                          SizedBox(width: 50),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return Checkbox(
                              fillColor:
                                  MaterialStatePropertyAll(Color(0xFF202C39)),
                              checkColor: Colors.white,
                              value: espChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  espChecked = value!;
                                });
                              },
                            );
                          },
                        ),
                        Text(
                          'Lesão Espontânea',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
                      child: Row(
                        children: const [
                          Text(
                            "Fator",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: espaco()),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 95, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text(
                            'Profilaxia',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text('Dose Extra',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          SizedBox(width: 50),
                          SizedBox(width: 50),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Row(
                        children: const [],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return Checkbox(
                              fillColor:
                                  MaterialStatePropertyAll(Color(0xFF202C39)),
                              checkColor: Colors.white,
                              value: medChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  medChecked = value!;
                                });
                              },
                            );
                          },
                        ),
                        Text(
                          'Fez uso de algum outro medicamento?',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Color(0xFF202C39),
                            ),
                          ),
                          child: Text("Cancelar"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              String sangramento = '';

                              if (leveSelected) {
                                sangramento = 'Leve';
                              } else if (moderadaSelected) {
                                sangramento = 'Moderada';
                              } else if (graveSelected) {
                                sangramento = 'Grave';
                              }
                              addEvent(sangramento);
                              Navigator.pop(context);

                              leveSelected = false;
                              moderadaSelected = false;
                              graveSelected = false;
                              normalSelected = false;
                              extraSelected = false;
                              espChecked = false;
                              medChecked = false;
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Color(0xFF202C39),
                            ),
                          ),
                          child: Text('Salvar'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void addEvent(String sangramento) {
    setState(() {
      if (mySelectedEvents[DateFormat('MM-dd-yyyy').format(selectedDate!)] !=
          null) {
        mySelectedEvents[DateFormat('MM-dd-yyyy').format(selectedDate!)]?.add({
          "sangramento": sangramento,
          "fator": normalSelected
              ? "Profilaxia"
              : (extraSelected ? "Dose extra" : ""),
          "espontaneo": espChecked ? "Sim" : "Não",
          "medicação": medChecked ? "Sim" : ""
        });
      } else {
        mySelectedEvents[DateFormat('MM-dd-yyyy').format(selectedDate!)] = [
          {
            "sangramento": sangramento,
            "fator": normalSelected
                ? "Profilaxia"
                : (extraSelected ? "Dose extra" : ""),
            "espontaneo": espChecked ? "Sim" : "",
            "medicação": medChecked ? "Sim" : ""
          }
        ];
      }
    });
    print('Selected events: ${json.encode(mySelectedEvents)}');
  }

  void _deleteEvent(Map<String, String> event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Excluir'),
          content: Text('Tem certeza de que deseja excluir?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o alerta
              },
            ),
            TextButton(
              child: Text('Excluir'),
              onPressed: () {
                setState(() {
                  final selectedDateKey =
                      DateFormat('MM-dd-yyyy').format(selectedDate!);
                  mySelectedEvents[selectedDateKey]?.remove(event);
                  if (mySelectedEvents[selectedDateKey]?.isEmpty ?? false) {
                    mySelectedEvents.remove(selectedDateKey);
                  }
                });
                print('Selected events: ${json.encode(mySelectedEvents)}');
                Navigator.of(context).pop(); // Fecha o alerta
              },
            ),
          ],
        );
      },
    );
  }
}
