import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';

class AcquisitionPage extends StatefulWidget {
  @override
  _AcquisitionPageState createState() => _AcquisitionPageState();
}

class _AcquisitionPageState extends State<AcquisitionPage> {
  DateTime? startDate;
  DateTime? endDate;
  List<dynamic> cards = [];
  String selectedSection = '';
  String? selectedDeviceId;
  List<bool> showDateSection = [];
  List<bool> showChart = [];
  List<List<List<FlSpot>>> chartData = [];
  final List<String> layers = [
    '66546790081be63a71e1069f',
    '66546790081be63a71e106a1',
    '66546790081be63a71e106a3',
    '66546790081be63a71e106ad'
  ];
  final List<String> colors = [
    '#167150',
    '#9627b0',
    '#0345a8',
    '#855e03',
    '#9d4194'
  ];

  @override
  void initState() {
    super.initState();
    _fetchCards();
  }

  Future<void> _fetchCards() async {
    List<dynamic> allCards = [];
    for (String layer in layers) {
      final url = Uri.parse(
          'https://app.quermes.net/api/card/get-cards-by-user-id-and-layer');
      try {
        final response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'userId': '6654630063bbd34d063c87cb',
            'layer': layer,
          }),
        );

        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          if (jsonResponse != null && jsonResponse['cards'] != null) {
            allCards.addAll(jsonResponse['cards']);
          } else {
            debugPrint(
                'Réponse de l\'API ne contient pas les cartes attendues pour la couche $layer.');
            debugPrint('Réponse de l\'API: $jsonResponse');
          }
        } else {
          debugPrint(
              'Erreur de requête pour la couche $layer: ${response.statusCode}');
          debugPrint('Réponse de l\'API: ${response.body}');
        }
      } catch (e) {
        debugPrint('Exception pour la couche $layer: $e');
      }
    }

    setState(() {
      cards = allCards;
      showDateSection = List<bool>.filled(cards.length, false);
      showChart = List<bool>.filled(cards.length, false);
      chartData = List<List<List<FlSpot>>>.generate(cards.length,
          (_) => []); // Correction ici pour les données dynamiques
    });
  }

  Future<void> _selectDateTime(BuildContext context, bool isStart) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate:
          isStart ? (startDate ?? DateTime.now()) : (endDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(pickedDate),
      );

      if (pickedTime != null) {
        final DateTime finalDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          if (isStart) {
            startDate = finalDateTime;
          } else {
            endDate = finalDateTime;
          }
        });
      }
    }
  }

  void _selectSection(String section, int tabIndex, String deviceId) {
    setState(() {
      selectedSection = section;
      selectedDeviceId = deviceId;
      _resetShowDateSections();
      showDateSection[tabIndex] = true;
      showChart[tabIndex] = false;
    });
  }

  void _resetShowDateSections() {
    showDateSection = List<bool>.filled(cards.length, false);
  }

  Future<void> _validate(int tabIndex) async {
    if (startDate != null && endDate != null && selectedDeviceId != null) {
      final url =
          Uri.parse('https://app.quermes.net/api/vector/get-vectors-dev');
      try {
        final response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'userId': '6654630063bbd34d063c87cb',
            'idDevice': selectedDeviceId,
            'chartType': "line",
            'colors': colors,
            'dateEnd': DateFormat('yyyy-MM-dd HH:mm:ss').format(endDate!),
            'dateStart': DateFormat('yyyy-MM-dd HH:mm:ss').format(startDate!),
            'maxNumber': 2000,
            'val1': 4,
            'val2': 1,
            'val3': false,
            'val4': false,
            'val5': "realtime",
          }),
        );

        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          debugPrint('Réponse de l\'API: $jsonResponse');
          setState(() {
            showChart[tabIndex] = true;
            List<String> variableNames = List<String>.from(
                jsonResponse['charts'][0]['variableNames'] ?? []);
            chartData[tabIndex] = _parseChartData(
                jsonResponse['charts'][0]['chartData'] ?? [], variableNames);
          });
        } else {
          debugPrint('Erreur de requête: ${response.statusCode}');
          debugPrint('Réponse de l\'API: ${response.body}');
        }
      } catch (e) {
        debugPrint('Exception: $e');
      }
    } else {
      debugPrint('Les dates de début et de fin doivent être sélectionnées.');
    }
  }

  List<List<FlSpot>> _parseChartData(dynamic data, List<String> variableNames) {
    Map<String, List<FlSpot>> spotsMap = {
      for (var name in variableNames) name: []
    };

    for (var point in data) {
      double xValue =
          DateTime.parse(point['ts']).millisecondsSinceEpoch.toDouble();
      for (var name in variableNames) {
        if (point.containsKey(name) && point[name] != null) {
          spotsMap[name]!.add(FlSpot(xValue, point[name].toDouble()));
        }
      }
    }

    return spotsMap.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acquisition'),
      ),
      body: cards.isEmpty
          ? Center(child: CircularProgressIndicator())
          : DefaultTabController(
              length: cards.length,
              child: Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    tabs:
                        cards.map((card) => Tab(text: card['title'])).toList(),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: cards
                          .asMap()
                          .entries
                          .map((entry) =>
                              _buildTabContent(context, entry.value, entry.key))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildTabContent(BuildContext context, dynamic card, int tabIndex) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(card['title']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: card['entities'] != null
                  ? card['entities']
                      .map<Widget>((entity) => _buildButton(context,
                          entity['name'], tabIndex, entity['deviceId']['_id']))
                      .toList()
                  : [],
            ),
          ),
          Divider(),
          if (showDateSection[tabIndex])
            Column(
              children: [
                Text(
                  selectedSection,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text('Date début'),
                          TextFormField(
                            readOnly: true,
                            onTap: () => _selectDateTime(context, true),
                            decoration: InputDecoration(
                              hintText: startDate != null
                                  ? DateFormat('dd-MM-yyyy HH:mm')
                                      .format(startDate!)
                                  : 'Sélectionner la date de début',
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: [
                          Text('Date fin'),
                          TextFormField(
                            readOnly: true,
                            onTap: () => _selectDateTime(context, false),
                            decoration: InputDecoration(
                              hintText: endDate != null
                                  ? DateFormat('dd-MM-yyyy HH:mm')
                                      .format(endDate!)
                                  : 'Sélectionner la date de fin',
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => _validate(tabIndex),
                  child: Text('Valider'),
                ),
              ],
            ),
          if (showChart[tabIndex] && chartData[tabIndex] != null)
            Column(
              children: chartData[tabIndex]
                  .asMap()
                  .entries
                  .map((entry) => _buildGraph(
                      card['variableNames']?[entry.key] ?? 'Variable inconnue',
                      entry.value))
                  .toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String section, int tabIndex, String deviceId) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton(
        onPressed: () => _selectSection(section, tabIndex, deviceId),
        child: Text(section),
      ),
    );
  }

  Widget _buildGraph(String title, List<FlSpot> spots) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Expanded(
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 2,
                    isStrokeCapRound: true,
                    belowBarData: BarAreaData(show: false),
                    dotData: FlDotData(show: false),
                  ),
                ],
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, _) =>
                          Text(value.toStringAsFixed(1)),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, _) {
                        DateTime date =
                            DateTime.fromMillisecondsSinceEpoch(value.toInt());
                        return Text(DateFormat('HH:mm').format(date));
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: true),
                gridData: FlGridData(show: true),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
