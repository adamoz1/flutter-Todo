import 'package:flutter/material.dart';

class CusAppBar extends StatefulWidget {
  final String appbarTitle;
  const CusAppBar({super.key, required this.appbarTitle});

  @override
  State<CusAppBar> createState() => _CusAppBarState();
}

class _CusAppBarState extends State<CusAppBar> {
  String title = "";

  @override
  void initState() {
    super.initState();
    title = widget.appbarTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.black, fontSize: 35, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
