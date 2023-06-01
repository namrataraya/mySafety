import 'package:flutter/material.dart';
import 'package:my_safety/helpers/colors.dart';
import 'package:my_safety/helpers/custom_appbar.dart';
import 'package:my_safety/helpers/custom_text.dart';
import 'package:my_safety/helpers/strings.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(text: "Admin Panel"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 200,
              color: primary_color,
              child: Center(
                  child: CustomText(
                text: "User Details",
                color: Colors.white,
                size: 18,
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    height: 200,
                    color: Colors.deepPurpleAccent,
                    child: Center(
                        child: CustomText(
                      text: txt_phone_number,
                      color: Colors.white,
                      size: 18,
                    )),
                  )),
                  SizedBox(width: 5),
                  Expanded(
                    child: Container(
                      height: 200,
                      color: Colors.deepOrangeAccent,
                      child: Center(
                          child: CustomText(
                        text: txt_live_location,
                        color: Colors.white,
                        size: 18,
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}










// import 'package:flutter/material.dart';
// import 'package:searchfield/searchfield.dart';
// import 'package:fl_chart/fl_chart.dart';

// class AdminPage extends StatefulWidget {
//   const AdminPage({Key? key}) : super(key: key);

//   @override
//   _AdminPageState createState() => _AdminPageState();
// }

// class _AdminPageState extends State<AdminPage> {
//   var firstnameController = new TextEditingController();
//   var lastnameController = new TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   // ignore: prefer_const_constructors
//                   Text(
//                     "Admin Panel",

//                     //Theme.of(context).textTheme.headline6
//                     style: Theme.of(context).textTheme.headline6,
//                   ),
//                   const Spacer(),
//                   Expanded(
//                     child: SearchField(
//                       hint: 'Search.... ',
//                       suggestions: [],
//                     ),
//                   ),

//                   Container(
//                     margin: const EdgeInsets.only(left: 0.75),
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 0.75, vertical: 0.75 / 2),
//                     decoration: const BoxDecoration(color: Colors.amber),
//                     child: Row(
//                       children: [
//                         Image.asset(
//                           "images/profile.png",
//                           height: 27,
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 0.75),
//                           child: Text(
//                             "Admin",
//                           ),
//                         ),
//                         const Icon(Icons.keyboard_arrow_down),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),

//               Row(
//                 children: [
//                   Expanded(
//                     flex: 3,
//                     child: Container(
//                       height: 250,
//                       color: Colors.amberAccent[400],
//                       child: Column(
//                         children: [
//                           const Text(
//                             "Company Details",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 200,
//                             child: PieChart(
//                               PieChartData(
//                                 sections: [
//                                   PieChartSectionData(
//                                       color: Colors.green,
//                                       value: 25,
//                                       title: "Profit ",
//                                       radius: 26),
//                                   PieChartSectionData(
//                                       color: Colors.purpleAccent,
//                                       title: "Old Users",
//                                       value: 20,
//                                       radius: 26),
//                                   PieChartSectionData(
//                                       color: Colors.blue,
//                                       title: "New Users",
//                                       value: 15,
//                                       radius: 26),
//                                   PieChartSectionData(
//                                       color: Colors.grey,
//                                       value: 25,
//                                       title: "Expendicture",
//                                       radius: 26),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Container(
//                       color: Colors.white10,
//                     ),
//                   ),

//                   const SizedBox(height: 10.0),
//                   // for new users start
//                   Expanded(
//                       flex: 8,
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               Text(
//                                 "New Users",
//                                 style: Theme.of(context).textTheme.subtitle1,
//                               ),
//                               const Spacer(),
//                               ElevatedButton.icon(
//                                   onPressed: () {},
//                                   icon: const Icon(Icons.add),
//                                   label: const Text("Add New")),
//                               const SizedBox(height: 10.0),
//                             ],
//                           )
//                         ],
//                       )),
//                   const SizedBox(height: 10.0),
//                 ],
//               ),
//               Flexible(
//                   child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: DataTable(
//                         columns: const [
//                           DataColumn(
//                             label: Text("ID"),
//                           ),
//                           DataColumn(
//                             label: Text("Name"),
//                           ),
//                           DataColumn(
//                             label: Text("Phone"),
//                           ),
//                         ],
//                         rows: [],
//                       ),
//                     ),
//                   )
//                 ],
//               )),
//               // for new users Ends

//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Container(
//                       color: Colors.white10,
//                     ),
//                   ),

//                   const SizedBox(height: 10.0),
//                   // for new users start
//                   Expanded(
//                       flex: 8,
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               Text(
//                                 "Staff Members",
//                                 style: Theme.of(context).textTheme.subtitle1,
//                               ),
//                               const Spacer(),
//                               ElevatedButton.icon(
//                                   onPressed: () {},
//                                   icon: const Icon(Icons.add),
//                                   label: const Text("Add New")),
//                               const SizedBox(height: 10.0),
//                             ],
//                           )
//                         ],
//                       )),
//                   const SizedBox(height: 10.0),
//                 ],
//               ),
//               Flexible(
//                   child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(1.0),
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: Center(
//                         child: DataTable(
//                           columns: const [
//                             DataColumn(
//                               label: Text("ID"),
//                             ),
//                             DataColumn(
//                               label: Text("Name"),
//                             ),
//                             DataColumn(
//                               label: Text("Phone"),
//                             ),
//                             DataColumn(
//                               label: Text("Position"),
//                             ),
//                           ],
//                           rows: [],
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               )),
//               // for new users Ends
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   PieChartSectionData newMethod() {
//     return PieChartSectionData(
//         color: Colors.red, value: 15, showTitle: false, radius: 26);
//   }
// }
