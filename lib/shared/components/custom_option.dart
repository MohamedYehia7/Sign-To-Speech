import 'package:flutter/material.dart';

class CustomOption extends StatelessWidget {
  const CustomOption({super.key, required this.icon, required this.text, this.onPressed});

  final IconData icon;
  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child:  Icon(
          icon,
          size: 18,
        ),
      ),
      const SizedBox(
        width: 10,
      ),
       Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      const Spacer(),
      IconButton(
          onPressed: () => onPressed!(),
          icon: const Icon(
            Icons.arrow_forward_ios,
            size: 18,
          ))
    ]);
  }
}
