import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar tbibAppbarPc(BuildContext context, int page) {
  return AppBar(
    title: Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Container(
              child: Text(
                'Michelle Raouf',
                style: GoogleFonts.getFont('Kaushan Script'),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  color: (page == 1)
                      ? Color.fromRGBO(217, 135, 17, 1)
                      : Colors.white,
                  width: 100,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'home',
                      style: GoogleFonts.getFont('Montserrat',
                          fontSize: 20,
                          color: (page == 1)
                              ? Colors.white
                              : Color.fromRGBO(217, 135, 17, 1)),
                    ),
                  ),
                ),
                SizedBox(width: 50),
                Container(
                  width: 100,
                  color: (page == 2)
                      ? Color.fromRGBO(217, 135, 17, 1)
                      : Colors.white,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'about',
                      style: GoogleFonts.getFont('Montserrat',
                          fontSize: 20,
                          color: (page == 2)
                              ? Colors.white
                              : Color.fromRGBO(217, 135, 17, 1)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
