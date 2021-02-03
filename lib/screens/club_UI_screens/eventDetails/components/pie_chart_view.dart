import 'package:bookario/screens/club_UI_screens/details/components/select_date.dart';
import 'package:bookario/components/size_config.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import 'package:flutter/foundation.dart';

class ChartView extends StatefulWidget {
  const ChartView({
    Key key,
    this.maleStag,
    this.femaleStag,
    this.couples,
  }) : super(key: key);

  final double maleStag;
  final double femaleStag;
  final double couples;

  @override
  _ChartViewState createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
  ];
  int key = 0;
  Map<String, double> dataMap;

  @override
  void initState() {
    setState(() {
      dataMap = {
        "Male": widget.maleStag,
        "Female": widget.femaleStag,
        "Couples": widget.couples,
      };
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final chart = PieChart(
      key: ValueKey(key),
      dataMap: dataMap,
      animationDuration: Duration(seconds: 1),
      chartLegendSpacing: 32,
      chartRadius: SizeConfig.screenWidth / 3.2 > 300
          ? 300
          : SizeConfig.screenWidth / 3.2,
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: ChartType.ring,
      centerText: null,
      legendOptions: LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.right,
        showLegends: true,
        legendShape: BoxShape.circle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: false,
        showChartValuesOutside: false,
      ),
      ringStrokeWidth: 48,
    );
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        child: LayoutBuilder(
          builder: (_, constraints) {
            if (constraints.maxWidth >= 600) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: chart,
                  ),
                  Flexible(
                    flex: 1,
                    child: SelectDate(),
                  )
                ],
              );
            } else {
              return Column(
                children: [
                  Container(
                    child: chart,
                    margin: EdgeInsets.symmetric(
                      vertical: 32,
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
