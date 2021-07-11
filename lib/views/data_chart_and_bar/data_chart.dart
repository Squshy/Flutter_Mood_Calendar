import 'package:flutter/material.dart';
import 'package:mood/model/database/mood/mood.dart';
import 'package:mood/model/store/mood.dart';
import 'package:provider/provider.dart';

// db
import '../../model/database/mood/mood.dart';
import '../../utility.dart';

class MoodDataChart extends StatefulWidget {
  @override
  _MoodDataChartState createState() => _MoodDataChartState();
}

class _MoodDataChartState extends State<MoodDataChart> {
  List<Mood> _allMoods = [];
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MoodBLoC _moodBLoC = context.watch<MoodBLoC>();
    _allMoods = _moodBLoC.allMoods;

    return Scaffold(
      appBar: AppBar(
        title: Text("All recorded moods"),
      ),
      body: getDataTableView(),
    );
  }

  SingleChildScrollView getDataTableView() {
    return SingleChildScrollView(
      child: DataTable(
          // Can't dynamically set the height for each datarow, only datatable has that property
          // and that sets the height for each datarow
          // Added a scroll view to compensate as well
          dataRowHeight: 150.0,
          sortAscending: _sortAscending,
          sortColumnIndex: _sortColumnIndex,
          columns: <DataColumn>[
            DataColumn(
                label: Text("Date"),
                numeric: false,
                onSort: (index, ascending) {
                  setState(() {
                    _sortColumnIndex = 0;
                    _sortAscending = ascending;
                    _allMoods.sort((a, b) {
                      if (!ascending) {
                        return a.mdate.compareTo(b.mdate);
                      } else {
                        return b.mdate.compareTo(a.mdate);
                      }
                    });
                  });
                }),
            DataColumn(
              label: Container(child: Text("Description of Mood")),
            ),
            DataColumn(
              label: Text("Mood"),
              numeric: false,
              onSort: (index, ascending) {
                setState(() {
                  _sortColumnIndex = 2;
                  _sortAscending = ascending;
                  _allMoods.sort((a, b) {
                    if (!ascending) {
                      return a.mood.compareTo(b.mood);
                    } else {
                      return b.mood.compareTo(a.mood);
                    }
                  });
                });
              },
            ),
          ],
          rows: _allMoods
              .map((_rowData) => DataRow(cells: <DataCell>[
                    // Shows the mood date
                    DataCell(
                        Row(
                          children: <Widget>[
                            Container(
                              child: Flexible(
                                  child:
                                      Text(Utility.formatter.format(_rowData.mdate))),
                            ),
                          ],
                        ),
                        showEditIcon: false,
                        placeholder: false),
                    // Shows the mood description
                    DataCell(Row(
                      children: <Widget>[
                        SingleChildScrollView(
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Text(
                                _rowData.feelingDescription,
                                maxLines: null,
                              )),
                        ),
                      ],
                    )),
                    // Shows the mood for that day
                    DataCell(Row(
                      children: [
                        Text(Utility.getMoodValueName(_rowData) ?? 'NULL'),
                      ],
                    )),
                  ]))
              .toList()),
    );
  }
}
