import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _selectedMonth = 0;

  final List<String> months = ['Month 1', 'Month 2', 'Month 3'];
  final List<int> ironLevels = [20, 18, 22]; // example data
  final List<int> changePercent = [5, -3, 4];

  List<FlSpot> _generateRandomData() {
    final random = Random();
    return List.generate(7, (index) {
      return FlSpot(index.toDouble(), random.nextInt(30).toDouble() + 10);
    });
  }

  @override
  Widget build(BuildContext context) {
    final int ironLevel = ironLevels[_selectedMonth];
    final int percentChange = changePercent[_selectedMonth];

    return Scaffold(
      appBar: AppBar(
        title: Text("History Overview"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info Card
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(Icons.person, size: 40),
                    ),
                    SizedBox(height: 10),
                    Text("User: Alex",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("PID: 987654321",
                        style: TextStyle(color: Colors.black54)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _infoButton("Contact"),
                        SizedBox(width: 10),
                        _infoButton("Treatment Plan"),
                        SizedBox(width: 10),
                        Icon(Icons.calendar_today,
                            size: 20, color: Colors.black54),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Month Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(months.length, (index) {
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedMonth = index;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedMonth == index
                          ? Colors.blue
                          : Colors.grey[300],
                      shape: StadiumBorder(),
                    ),
                    child: Text(
                      months[index],
                      style: TextStyle(
                        color: _selectedMonth == index
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),

              // Iron Levels
              Text("Iron Levels",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              SizedBox(height: 8),
              Text("$ironLevel mg/dL",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
              SizedBox(height: 4),
              Text(
                  "Last 3 Months ${percentChange > 0 ? '+' : ''}$percentChange%",
                  style: TextStyle(
                    color: percentChange >= 0 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(height: 20),

              // Chart
              Container(
                height: 200,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: LineChart(
                  LineChartData(
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            switch (value.toInt()) {
                              case 0:
                                return Text("JAN",
                                    style: TextStyle(fontSize: 12));
                              case 3:
                                return Text("FEB",
                                    style: TextStyle(fontSize: 12));
                              case 6:
                                return Text("APR",
                                    style: TextStyle(fontSize: 12));
                              default:
                                return Text("");
                            }
                          },
                        ),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: _generateRandomData(),
                        isCurved: true,
                        color: Colors.blue,
                        barWidth: 3,
                        dotData: FlDotData(show: false),
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoButton(String label) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        side: BorderSide(color: Colors.blue),
        shape: StadiumBorder(),
      ),
    );
  }
}
