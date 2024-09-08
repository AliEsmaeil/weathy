
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../inner_models/representable_data.dart';

class SmoothAreaChart extends StatelessWidget {

  String? chartTitle;
  String? xAxisTitle;
  String? yAxisTitle;
  List<RepresentableData> dataSource;

  SmoothAreaChart({
    super.key,
     this.chartTitle,
     this.xAxisTitle,
     this.yAxisTitle,
    required this.dataSource,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
        child: SfCartesianChart(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: chartTitle == null ? ChartTitle() : ChartTitle(text : chartTitle??''),
          primaryXAxis: CategoryAxis(
            title: AxisTitle(text: xAxisTitle),
            interval: 1,
            borderWidth: 0,
            majorGridLines: MajorGridLines(width: 0),
            labelPlacement: LabelPlacement.onTicks,
            labelRotation: xAxisTitle == 'Day' ?-45 : 0,
          ),
          primaryYAxis: NumericAxis(
            title: AxisTitle(text: yAxisTitle),
            majorGridLines: MajorGridLines(width: 0),
            borderWidth: 0,
          ),
          plotAreaBorderWidth: 0,
          enableAxisAnimation: true,
          margin: EdgeInsets.all(0),
          zoomPanBehavior: ZoomPanBehavior(zoomMode: ZoomMode.x),
          series:[
            SplineAreaSeries<RepresentableData, dynamic>(
              markerSettings: MarkerSettings(color: Colors.white, isVisible: true, shape: DataMarkerType.circle,),
                gradient: LinearGradient(
                  colors: [
                    Colors.orange,
                    Colors.red,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                dataSource: dataSource,                xValueMapper: (RepresentableData d, _) => d.category,
                yValueMapper: (RepresentableData d, _) => d.value)
          ],
        ));
  }
}
