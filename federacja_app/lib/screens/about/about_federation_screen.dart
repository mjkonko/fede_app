import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AboutFederation extends StatefulWidget {
  const AboutFederation({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  AboutFederationState createState() => AboutFederationState();
}

class AboutFederationState extends State<AboutFederation>
    with TickerProviderStateMixin {
  final String textTitle = "Our mission";
  final String textParagraph1 = "To foster cooperation between Polish student "
      "Societies in the UK by providing guidance to local and nationwide initiatives "
      "and representing the interest of Polish students in the UK on the national "
      "and international level.";
  final String textParagraph2 =
      "There are currently tens of thousands Polish students in the UK. "
      "Through the establishment of Polish Societies at universities across the country, "
      "they create small local communities organising celebrations, social meetings,"
      "and networking opportunities. The Federation serves as an integrating body providing support and knowledge,"
      "helping consecutive generations continue the work of PolSocs."
      "It is the primary body responsible for defending the interests"
      "of Polish Students in the United Kingdom. Through flagship projects such "
      "as annual Congress of Polish Student Societies, international pro-European"
      "students campaign SaveEU Students, and a mentoring scheme EmpowerPL run in"
      "cooperation with The Boston Consulting Group, The Federation continues to grow"
      "and flourish, promoting Polish culture and influence on international affairs.";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Flex(direction: Axis.vertical, children: [
              Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Text(textTitle,
                            style:
                                Theme.of(context).textTheme.headline3!.copyWith(
                                      color: Colors.black87,
                                      wordSpacing: 1,
                                      overflow: TextOverflow.fade,
                                      height: 1.2,
                                    )),
                        Text(textParagraph1,
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      color: Colors.black87,
                                      wordSpacing: 1,
                                      overflow: TextOverflow.fade,
                                      height: 1.5,
                                    )),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(textParagraph2,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: Colors.black87,
                                    wordSpacing: 1,
                                    overflow: TextOverflow.fade,
                                    height: 1.5,
                                  )),
                        )
                      ],
                    ),
                  ))
            ])));
  }
}
