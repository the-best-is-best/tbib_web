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
            flex: 2,
            child: Container(
              child: Text(
                'Michelle Raouf',
                style: GoogleFonts.getFont('Kaushan Script'),
              ),
            ),
          ),
          Expanded(
            flex: 9,
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
                      'Home',
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
                      'About',
                      style: GoogleFonts.getFont('Montserrat',
                          fontSize: 20,
                          color: (page == 2)
                              ? Colors.white
                              : Color.fromRGBO(217, 135, 17, 1)),
                    ),
                  ),
                ),
                SizedBox(width: 50),
                Container(
                  width: 100,
                  color: (page == 3)
                      ? Color.fromRGBO(217, 135, 17, 1)
                      : Colors.white,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Services',
                      style: GoogleFonts.getFont('Montserrat',
                          fontSize: 20,
                          color: (page == 3)
                              ? Colors.white
                              : Color.fromRGBO(217, 135, 17, 1)),
                    ),
                  ),
                ),
                SizedBox(width: 50),
                Container(
                  width: 100,
                  color: (page == 4)
                      ? Color.fromRGBO(217, 135, 17, 1)
                      : Colors.white,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Products',
                      style: GoogleFonts.getFont('Montserrat',
                          fontSize: 20,
                          color: (page == 4)
                              ? Colors.white
                              : Color.fromRGBO(217, 135, 17, 1)),
                    ),
                  ),
                ),
                SizedBox(width: 50),
                Container(
                  width: 100,
                  color: (page == 5)
                      ? Color.fromRGBO(217, 135, 17, 1)
                      : Colors.white,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Contact',
                      style: GoogleFonts.getFont('Montserrat',
                          fontSize: 20,
                          color: (page == 5)
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
