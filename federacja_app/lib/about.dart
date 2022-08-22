import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  final String title = "About";

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50))),
        bottom: TabBar(
          controller: _tabController,
          indicatorWeight: 1.5,
          indicatorSize: TabBarIndicatorSize.label,
          automaticIndicatorColorAdjustment: true,
          indicatorColor: const Color.fromRGBO(255, 255, 255, 1.0),
          tabs: const <Widget>[
            Tab(
              text: "Federation",
            ),
            Tab(
              text: "Committee",
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Center(child: AboutFederation(title: 'Federation')),
          Center(child: AboutCommittee(title: 'Committee'))
        ],
      ),
    );
  }
}

class AboutFederation extends StatefulWidget {
  AboutFederation({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AboutFederationState createState() => _AboutFederationState();
}

class _AboutFederationState extends State<AboutFederation>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}

class AboutCommittee extends StatefulWidget {
  AboutCommittee({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AboutCommitteeState createState() => _AboutCommitteeState();
}

class _AboutCommitteeState extends State<AboutCommittee>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
