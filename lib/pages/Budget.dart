import 'package:flutter/material.dart';

class Budget extends StatelessWidget {
  const Budget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Araku Valley Plans'),
      ),
      body: ListView(
        children: [
          PlanCard(
            title: 'Silver Plan',
            places: [
              'Borra Caves',
              'Ananthagiri',
              'Chaparai Waterfall',
              'Tribal Museum',
            ],
          ),
          PlanCard(
            title: 'Golden Plan',
            places: [
              'Borra Caves',
              'Ananthagiri',
              'Chaparai Waterfall',
              'Tribal Museum',
              'Katika Waterfalls',
              'Padmapuram Gardens',
              'Mastyagundam (Fish Pool)',
            ],
          ),
          PlanCard(
            title: 'Platinum Plan',
            places: [
              'Borra Caves',
              'Ananthagiri',
              'Chaparai Waterfall',
              'Tribal Museum',
              'Katika Waterfalls',
              'Padmapuram Gardens',
              'Mastyagundam (Fish Pool)',
              'Tyda Nature Camp',
              'Lambasingi',
              'Tatipudi Reservoir (Near Vizag)',
            ],
          ),
        ],
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  final String title;
  final List<String> places;

  PlanCard({required this.title, required this.places});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(title, style: TextStyle(fontSize: 20)),
          ),
          for (var i = 0; i < places.length; i++)
            ListTile(
              title: Text('Day ${i + 1}: ${places[i]}'),
              subtitle: Text('Estimated Time: Full Day'),
            ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Budget(),
  ));
}
