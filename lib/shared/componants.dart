import 'package:flutter/material.dart';

Widget defaultTextForm({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required IconData icon,
  Function? onTap,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(
        icon,
      ),
    ),
    onTap: () {
      onTap!();
    },
  );
}
