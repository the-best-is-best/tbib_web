import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tbib_app/models/header_content.dart';
import '../widgets/pc/app_bar_pc.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 1100) {
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
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.dstATop),
              image: NetworkImage(HeaderContent.bg),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 250,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 25),
                      child: Text(
                        HeaderContent.title,
                        style: GoogleFonts.getFont(
                          'Droid Serif',
                          fontSize: 40,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 50),
                      child: Text(
                        HeaderContent.des,
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 75,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                child: AnimatedTextKit(
                  animatedTexts: [
                    ...HeaderContent.content.map(
                      (val) {
                        return TyperAnimatedText(
                          val,
                          speed: Duration(milliseconds: 120),
                          textStyle: (GoogleFonts.getFont('Montserrat',
                              fontWeight: FontWeight.w700, fontSize: 32)),
                        );
                      },
                    ).toList(),
                  ],
                  isRepeatingAnimation: true,
                  repeatForever: true,
                ),
              ),
            ],
          ),
        ),
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
