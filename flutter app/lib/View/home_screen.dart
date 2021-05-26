import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/pc/app_bar_pc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 800) {
        return PcHome();
      } else {
        return MobHome();
      }
    });
  }
}

class PcHome extends StatefulWidget {
  @override
  _PcHomeState createState() => _PcHomeState();
}

class _PcHomeState extends State<PcHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: tbibAppbarPc(context, 1),
      body: Container(
        height:MediaQuery.of(context).size.height ,
        
        decoration:BoxDecoration(
          image: DecorationImage(image:NetworkImage(""),),
          
        ) ,
      ),
    );
  }
}

class MobHome extends StatefulWidget {
  @override
  _MobHomeState createState() => _MobHomeState();
}

class _MobHomeState extends State<MobHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Michelle Raouf',
            style: GoogleFonts.getFont('Kaushan Script'),
          ),
        ),
        endDrawer: Drawer(
            child: ListView(
          children: [
            Container(
              color: Color.fromRGBO(217, 135, 17, 1),
              child: ListTile(
                title: Text(
                  'home',
                  style: GoogleFonts.getFont('Montserrat',
                      fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'about',
                style: GoogleFonts.getFont(
                  'Montserrat',
                  fontSize: 20,
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
