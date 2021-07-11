import 'package:flutter/material.dart';
import 'package:mood/model/store/mood.dart';
import 'package:mood/views/data_chart_and_bar/mood_data_list.dart';
import 'package:mood/model/database/mood/mood_model.dart';
import 'package:mood/model/database/mood/mood.dart';
import '../../constants/selectable_moods.dart';
import 'package:mood/constants/selectable_moods.dart';
import 'package:provider/provider.dart';

// db
import '../../model/database/mood/mood.dart';

// store
import 'package:charts_flutter/flutter.dart' as charts;

class MoodDataBar extends StatefulWidget {
  @override
  _MoodDataBarState createState() => _MoodDataBarState();
}

class _MoodDataBarState extends State<MoodDataBar> {
  List<MoodDataList> _moodDataList = [];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MoodBLoC _moodBLoC = context.watch<MoodBLoC>();

    // Counts the number of occurences of each mood and puts it into a list for the bar chart
    for (MoodIcons _mood in moodList) {
      MoodDataList _moodData = MoodDataList();

      var _foundElement = _moodBLoC.allMoods
          .where((element) => element.mood == _mood.moodValue);
      _moodData.moodName = _mood.name;
      _moodData.numOccurrences = _foundElement.length;
      _moodDataList.add(_moodData);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Moods in a bar chart"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        // In case the phone's really big or the data gets big
        child: SizedBox(
          height: 1000,
          child: getBarView(),
        ),
      ),
    );
  }

  charts.BarChart getBarView() {
    return charts.BarChart(
      [
        // Builds the bar chart
        charts.Series<MoodDataList, String>(
          id: 'Mood Names',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (MoodDataList data, _) => data.moodName,
          measureFn: (MoodDataList data, _) => data.numOccurrences,
          data: _moodDataList,
        ),
      ],
      animate: true,
      vertical: true,

      // Changes the font color to white
      primaryMeasureAxis: new charts.NumericAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
              labelStyle:
                  charts.TextStyleSpec(color: charts.MaterialPalette.white))),
      domainAxis: new charts.OrdinalAxisSpec(
          renderSpec: charts.SmallTickRendererSpec(
              labelStyle:
                  charts.TextStyleSpec(color: charts.MaterialPalette.white))),
    );
  }
}
