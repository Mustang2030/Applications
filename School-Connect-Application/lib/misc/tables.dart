import 'package:flutter/material.dart';
import 'package:scs/consts/constans.dart';

TableRow tableMe(String? name, String? name2, String? name3) {
  return TableRow(
      decoration: BoxDecoration(
        border: Border.all(),
        color: const Color(0xFF0F2E34),
      ),
      children: [
        Center(
          child: Text(
            "$name",
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 18, color: kTextColor),
          ),
        ),
        Center(
          child: Text(
            "$name2",
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 18, color: kTextColor),
          ),
        ),
        Center(
          child: Text(
            "$name3",
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 18, color: kTextColor),
          ),
        ),
      ]);
}

TableRow tableMeInfo(
    String? name, String? name2, String? name3, Function()? onTap) {
  return TableRow(
    decoration: BoxDecoration(
      border: Border.all(),
    ),
    children: [
      Padding(
        padding: const EdgeInsets.all(3),
        child: GestureDetector(
          onTap: onTap,
          child: Center(
            child: Text(
              "$name",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(3),
        child: GestureDetector(
          onTap: onTap,
          child: Center(
            child: Text(
              "$name2",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(3),
        child: GestureDetector(
          onTap: onTap,
          child: Center(
            child: Text(
              "$name3",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ),
        ),
      ),
    ],
  );
}

TableRow tableMeInfoT(
    String? name, String? name2, bool isSelected, VoidCallback pressed) {
  return TableRow(
    decoration: BoxDecoration(
      border: Border.all(),
    ),
    children: [
      Padding(
        padding: const EdgeInsets.all(0),
        child: Center(
          child: Text(
            "$name",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(0),
        child: Center(
          child: Text(
            "$name2",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(0),
        child: GestureDetector(
          onTap: pressed,
          child: Center(
            child: Icon(
              isSelected ? Icons.check : Icons.close,
              color: isSelected ? Colors.green : Colors.red,
            ),
          ),
        ),
      ),
    ],
  );
}
