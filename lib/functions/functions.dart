import 'package:flutter/material.dart';

import '../screens/calendar_screen.dart';

class Event {
  final String sangramento;
  final String fator;

  Event(this.sangramento, this.fator);
}

Widget buildModerada() {
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Expanded(
        child: GestureDetector(
          onTap: () {
            setState(() {
              moderadaSelected = !moderadaSelected;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: moderadaSelected ? Color(0xFF202C39) : Colors.transparent,
              border: moderadaSelected
                  ? null
                  : Border.all(color: Color(0xFF202C39), width: 3.0),
            ),
            alignment: Alignment.center,
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/sangue.png',
                  height: 30,
                  color: moderadaSelected ? Colors.white : Color(0xFF202C39),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget buildGrave() {
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Expanded(
        child: GestureDetector(
          onTap: () {
            setState(() {
              graveSelected = !graveSelected;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: graveSelected ? Color(0xFF202C39) : Colors.transparent,
              border: graveSelected
                  ? null
                  : Border.all(color: Color(0xFF202C39), width: 3.0),
            ),
            alignment: Alignment.center,
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/grave.png',
                  height: 30,
                  color: graveSelected ? Colors.white : Color(0xFF202C39),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget buildLeve() {
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Expanded(
        child: GestureDetector(
          onTap: () {
            setState(() {
              leveSelected = !leveSelected;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: leveSelected ? Color(0xFF202C39) : Colors.transparent,
              border: leveSelected
                  ? null
                  : Border.all(color: Color(0xFF202C39), width: 3.0),
            ),
            alignment: Alignment.center,
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/leve.png',
                  height: 30,
                  color: leveSelected ? Colors.white : Color(0xFF202C39),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget buildNormal() {
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Expanded(
        child: GestureDetector(
          onTap: () {
            setState(() {
              normalSelected = !normalSelected;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: normalSelected ? Color(0xFF202C39) : Colors.transparent,
              border: normalSelected
                  ? null
                  : Border.all(color: Color(0xFF202C39), width: 3.0),
            ),
            alignment: Alignment.center,
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/normal.png',
                  height: 30,
                  color: normalSelected ? Colors.white : Color(0xFF202C39),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget buildExtra() {
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Expanded(
        child: GestureDetector(
          onTap: () {
            setState(() {
              extraSelected = !extraSelected;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: extraSelected ? Color(0xFF202C39) : Colors.transparent,
              border: extraSelected
                  ? null
                  : Border.all(color: Color(0xFF202C39), width: 3.0),
            ),
            alignment: Alignment.center,
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/extra.png',
                  height: 30,
                  color: extraSelected ? Colors.white : Color(0xFF202C39),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget espaco() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      buildNormal(),
      SizedBox(width: 10),
      SizedBox(width: 10),
      buildExtra(),
      SizedBox(width: 10),
      SizedBox(width: 50),
      SizedBox(width: 50),
      SizedBox(width: 50),
      SizedBox(width: 50),
      SizedBox(width: 35)
    ],
  );
}

Widget espacoLesao() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      buildLeve(),
      SizedBox(width: 10),
      buildModerada(),
      SizedBox(width: 10),
      buildGrave(),
      SizedBox(width: 10),
      SizedBox(width: 50),
      SizedBox(width: 50),
      SizedBox(width: 50),
    ],
  );
}
