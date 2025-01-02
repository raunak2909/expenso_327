import 'package:d_chart/commons/axis/axis.dart';
import 'package:d_chart/commons/config_render/config_render.dart';
import 'package:d_chart/commons/data_model/data_model.dart';
import 'package:d_chart/commons/style/style.dart';
import 'package:d_chart/d_chart.dart';
import 'package:d_chart/ordinal/bar.dart';
import 'package:expense_app_ui/data/local/model/expense_model.dart';
import 'package:expense_app_ui/data/local/model/filter_expense_model.dart';
import 'package:expense_app_ui/domain/app_constants.dart';
import 'package:expense_app_ui/ui/add_exp_page.dart';
import 'package:expense_app_ui/ui/bloc/expense_bloc.dart';
import 'package:expense_app_ui/ui/bloc/expense_event.dart';
import 'package:expense_app_ui/ui/bloc/expense_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<String> mMonths = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  List<ExpenseModel> mExpense = [];
  DateFormat mFormat = DateFormat.yMMM();

  ///month
  ///DateFormat mFormat = DateFormat.yMMMM();
  ///year
  ///DateFormat mFormat = DateFormat.y();

  List<FilterExpenseModel> filteredData = [];

  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(FetchInitialExpenseEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DashBoard'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: MediaQuery.of(context).orientation == Orientation.landscape
            ? Row(
                children: [
                  Expanded(child: getUIOne()),
                  SizedBox(
                    width: 21,
                  ),
                  Expanded(child: SingleChildScrollView(child: getUITwo())),
                ],
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    /// search icon and logo
                    getUIOne(),

                    /// Expense List
                    getUITwo()
                  ],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddExpPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getUITwo() {
    return BlocBuilder<ExpenseBloc, ExpenseState>(builder: (_, state) {
      if (state is ExpenseLoadingState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ExpenseErrorState) {
        return Center(
          child: Text(state.errorMsg),
        );
      } else if (state is ExpenseLoadedState) {
        filterDataDateWise(allExp: state.mExp.reversed.toList());

        List<OrdinalData> mData = [];
        num highestAmt = 0;

        for (FilterExpenseModel eachFilterData in filteredData) {
          if (highestAmt < eachFilterData.totalAmt) {
            highestAmt = eachFilterData.totalAmt;
          }

          mData.add(OrdinalData(
              domain: eachFilterData.typeName,
              measure: eachFilterData.totalAmt));
        }
        print(highestAmt);

        return state.mExp.isNotEmpty
            ? Column(
                children: [
                  AspectRatio(
                      aspectRatio: 16 / 9,
                      child: DChartBarO(
                          animate: true,
                          domainAxis: DomainAxis(),
                          measureAxis: MeasureAxis(
                              useGridLine: true,
                              showLine: true,
                              noRenderSpec: false,
                              tickLineStyle:
                                  LineStyle(thickness: 2, color: Colors.blue),
                              gridLineStyle: LineStyle(
                                color: Colors.blue.shade200,
                                thickness: 1,
                                dashPattern: [7, 2],
                              )),
                          configRenderBar: ConfigRenderBar(radius: 11),
                          fillColor: (group, data, index) {
                            return data.measure == highestAmt
                                ? Colors.blue
                                : Colors.grey;
                          },
                          groupList: [OrdinalGroup(id: "1", data: mData)])),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: filteredData.length,
                      itemBuilder: (_, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 11),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(color: Colors.grey, width: 0.5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      filteredData[index].typeName,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "-\$${filteredData[index].totalAmt}",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Divider(),
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        filteredData[index].allExpenses.length,
                                    shrinkWrap: true,
                                    itemBuilder: (_, childIndex) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 11.0),
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFe0e0e0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Image.asset(
                                                    AppConstants.mCat
                                                        .where((exp) {
                                                          return exp.id ==
                                                              filteredData[
                                                                      index]
                                                                  .allExpenses[
                                                                      childIndex]
                                                                  .categoryId;
                                                        })
                                                        .toList()[0]
                                                        .imgPath,
                                                    fit: BoxFit.contain,
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                                )),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  filteredData[index]
                                                      .allExpenses[childIndex]
                                                      .title,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(filteredData[index]
                                                    .allExpenses[childIndex]
                                                    .desc)
                                              ],
                                            ),
                                            Spacer(),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  mFormat.format(DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          int.parse(filteredData[
                                                                  index]
                                                              .allExpenses[
                                                                  childIndex]
                                                              .createdAt))),
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.grey),
                                                ),
                                                Text(
                                                  "-\$${filteredData[index].allExpenses[childIndex].amount}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.pinkAccent),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    })
                              ],
                            ),
                          ),
                        );
                      })
                ],
              )

            ///DChartPieO(
            //                                 customLabel: (data, index){
            //                                   return "${data.measure}\n ${data.domain}";
            //                                 },
            //                                   animate: true,
            //                                   configRenderPie: ConfigRenderPie(
            //                                       strokeWidthPx: 2,
            //                                       arcWidth: 150,
            //                                       arcLabelDecorator: ArcLabelDecorator(
            //                                           showLeaderLines: true,
            //                                           labelPadding: 11,
            //                                           labelPosition:
            //                                               ArcLabelPosition.inside,
            //                                           outsideLabelStyle: LabelStyle(
            //                                               color: Colors.black,
            //                                               fontSize: 12,
            //                                               fontWeight: FontWeight.bold),
            //                                           leaderLineStyle:
            //                                               ArcLabelLeaderLineStyle(
            //                                                   color: Colors.blue,
            //                                                   length: 34,
            //                                                   thickness: 2),
            //                                           insideLabelStyle: LabelStyle(
            //                                               color: Colors.white,
            //                                               fontSize: 10,
            //                                               fontWeight: FontWeight.bold))),
            //                                   animationDuration: Duration(seconds: 1),
            //                                   data: mData),

            /*ListView.builder(
                      itemCount: filteredData.length,
                      itemBuilder: (_, index) {

                        return Container(
                          margin: EdgeInsets.only(bottom: 11),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(color: Colors.grey, width: 0.5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      filteredData[index].typeName,
                                      style: TextStyle(
                                          fontSize: 17, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "-\$${filteredData[index].totalAmt}",
                                      style: TextStyle(
                                          fontSize: 17, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Divider(),
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: filteredData[index].allExpenses.length,
                                    shrinkWrap: true,
                                    itemBuilder: (_, childIndex){
                                  return Padding(
                          padding: const EdgeInsets.only(bottom: 11.0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFe0e0e0),
                                      borderRadius:
                                          BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Image.asset(
                                      AppConstants.mCat
                                          .where((exp) {
                                            return exp.id ==
                                                filteredData[index].allExpenses[childIndex].categoryId;
                                          })
                                          .toList()[0]
                                          .imgPath,
                                      fit: BoxFit.contain,
                                      height: 30,
                                      width: 30,
                                    ),
                                  )),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    filteredData[index].allExpenses[childIndex].title,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(filteredData[index].allExpenses[childIndex].desc)
                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    mFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(filteredData[index].allExpenses[childIndex].createdAt))),
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey),
                                  ),
                                  Text(
                                    "-\$${filteredData[index].allExpenses[childIndex].amount}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.pinkAccent),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                                })
                              ],
                            ),
                          ),
                        );


                      })*/
            : Center(
                child: Text("No expenses yet!!"),
              );
      }

      return Container();
    });
  }

  Widget getUIOne() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "asset/image/logoremvoe.png",
              fit: BoxFit.contain,
              width: 120,
            ),
            Icon(
              Icons.search,
              size: 40,
            )
          ],
        ),

        SizedBox(
          height: 20,
        ),

        // user profile
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // profile picture
            Image.asset(
              "asset/image/profileicon.jpg",
              height: 45,
              width: 45,
              fit: BoxFit.contain,
            ),

            // name of user
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Morning",
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  "chanderakinjal",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            //button
            OutlinedButton(
              onPressed: () {},
              child: Row(
                children: [
                  Text(
                    "This Month",
                    style: TextStyle(color: Colors.black),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.black,
                  )
                ],
              ),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Color(0xFFe0e0e0),
                side: BorderSide.none,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),

        ///Purple Container
        Container(
          decoration: BoxDecoration(
            color: Color(0xFF727dd6),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              // Text
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Expense total",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "\$3,734",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),

                    /// red button
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          child: Text("+\$240",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide.none,
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            minimumSize: Size(45, 25),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                        Text(
                          "than last month",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              ///side Image
              Expanded(
                child: Image.asset(
                  "asset/image/containersideimg.png",
                  height: 160,
                  width: 160,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void filterDataDateWise({required List<ExpenseModel> allExp}) {
    filteredData.clear();

    ///date/month/year
    ///total Amount
    ///List of Expense
    List<String> uniqueDates = [];

    for (ExpenseModel eachExp in allExp) {
      String eachDate = mFormat.format(
          DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.createdAt)));

      if (!uniqueDates.contains(eachDate)) {
        uniqueDates.add(eachDate);
      }
    }

    print(uniqueDates);

    for (String eachDate in uniqueDates) {
      num totalAmt = 0.0;
      List<ExpenseModel> eachDateExp = [];

      for (ExpenseModel eachExp in allExp) {
        String expDate = mFormat.format(
            DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.createdAt)));

        if (eachDate == expDate) {
          eachDateExp.add(eachExp);

          if (eachExp.expenseType == "Debit") {
            ///debit
            totalAmt += eachExp.amount;
          } else {
            ///credit
            totalAmt -= eachExp.amount;
          }
        }
      }

      filteredData.add(FilterExpenseModel(
          typeName: eachDate, totalAmt: totalAmt, allExpenses: eachDateExp));
    }

    //print(filteredData[2].allExpenses.length);
  }
}

/// month wise
/// year wise
///
