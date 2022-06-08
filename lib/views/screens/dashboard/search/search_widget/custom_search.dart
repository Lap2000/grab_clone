import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSearchBar extends StatelessWidget {
  //final String text;

  //final String hint;
  //final bool isLoading;

  final void Function()? onClick;

  //final FormFieldValidator<String>? validator;
  final TextEditingController? controller;

  CustomSearchBar({
    this.controller,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(1, 1), // changes position of shadow
                  ),
                ],
              ),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Search products',
                  labelStyle: const TextStyle(fontFamily: 'Comfortaa'),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(color: Colors.white24, width: 0.1),
                  ),
                  // enabledBorder: const OutlineInputBorder(
                  //   borderRadius: BorderRadius.all(
                  //     Radius.circular(10),
                  //   ),
                  //   borderSide: BorderSide(color: Colors.black26, width: 1),
                  // ),
                  fillColor: Colors.grey[100],
                  filled: true,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SvgPicture.asset(
                      'assets/photos/search.svg',
                      width: 20,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
            child: InkWell(
              onTap: onClick,
              child: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(1, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Icon(
                    Icons.search,
                    size: 25.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
