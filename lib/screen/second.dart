import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_switch/flutter_switch.dart';


void main() {
  var app = MaterialApp(
    title: "My App",
    home: AddTaskPageState(),
    theme: ThemeData(primarySwatch: Colors.blue),
  );
  runApp(app);
}

class AddTaskPageState extends StatefulWidget {
  const AddTaskPageState({Key? key}) : super(key: key);

  @override
  State<AddTaskPageState> createState() => _AddTaskPageStateState();
}

class _AddTaskPageStateState extends State<AddTaskPageState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              exit(0);
            },
          ),
          title: const Text(
            "Add Task",
            style: TextStyle(fontSize: 19),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(10),
          child: MyWidget(),
        ));
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool _doneStatus = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.all(5),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Title',
              hintText: 'Enter Title',
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.all(5),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Note',
              hintText: 'Enter Note',
            ),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          children: const [
            SizedBox(width: 10),
            Text(
              "Priority :",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(width: 15),
            DropDown(),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: const [
            SizedBox(width: 10),
            Text(
              "Deadline : ",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(width: 15),
            DatePick(),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: const [
            SizedBox(width: 10),
            Text(
              "Status : ",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(width: 15),
            SwitchStatus()
          ],
        ),
        const SizedBox(height: 50),
        FloatingActionButton.extended(
          onPressed: () {
          // Add your onPressed code here!
          },
          label: const Text('Add'),
          icon: const Icon(Icons.add),
          backgroundColor: Colors.blue,
         ),
        
        
        // ElevatedButton.icon(
        //   onPressed: () {},
        //   icon: const Icon(Icons.add),
        //   label: const Text("Add"),
        // )
      ],
    );
  }
}

class DropDown extends StatefulWidget {
  const DropDown({Key? key}) : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String dropdownValue = 'Low';
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: const Color.fromARGB(120, 33, 149, 243),
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Low', 'Medium', 'High']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

// class DropDownStatus extends StatefulWidget {
//   const DropDownStatus({Key? key}) : super(key: key);

//   @override
//   State<DropDownStatus> createState() => _DropDownStatusState();
// }

// class _DropDownStatusState extends State<DropDownStatus> {
//   String dropDownStatus = "Select";

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: dropDownStatus,
//       icon: const Icon(Icons.arrow_drop_down),
//       elevation: 16,
//       style: const TextStyle(color: Colors.black),
//       underline: Container(
//         height: 2,
//         color: const Color.fromARGB(120, 33, 149, 243),
//       ),
//       onChanged: (String? newValue) {
//         setState(() {
//           dropDownStatus = newValue!;
//         });
//       },
//       items: <String>['To Do', 'In Progress', 'Done']
//           .map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }

class DatePick extends StatefulWidget {
  const DatePick({Key? key}) : super(key: key);

  @override
  State<DatePick> createState() => _DatePickState();
}

class _DatePickState extends State<DatePick> {
  String _selectedDate = "Select Date";

  Future<String> _openDatePicker(BuildContext) async {
    final DateTime? d = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: new DateTime(2015),
        lastDate: new DateTime(2050));
    if (d != null) {
      setState(() {
        _selectedDate = new DateFormat.yMMMd("en_US").format(d).toString();
      });
    }
    return _selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          _selectedDate,
        ),
        IconButton(
          icon: const Icon(
            Icons.calendar_today,
          ),
          onPressed: () {
            _openDatePicker(context);
          },
        )
      ],
    );
  }
}

class SwitchStatus extends StatefulWidget {
  const SwitchStatus({Key? key}) : super(key: key);

  @override
  State<SwitchStatus> createState() => _SwitchStatusState();
}

class _SwitchStatusState extends State<SwitchStatus> {
  bool _doneStatus = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlutterSwitch(
          activeText: "   Done",
          inactiveText: "In Progress",
          value: _doneStatus,
          valueFontSize: 12.0,
          height: 40,
          width: 110,
          borderRadius: 30.0,
          showOnOff: true,
          onToggle: (val) {
            setState(() {
              _doneStatus = val;
            });
            // if(_doneStatus) {
            //   Fluttertoast.showToast(msg: "task done.");
            // }
            // if (_doneStatus) {
            //   Fluttertoast.showToast(msg: "task done.");
            // }
          },
        ),
        
      ],
    );
  }
}

// class MyCustomForm extends StatelessWidget {
//   const MyCustomForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//           child: TextField(
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               hintText: 'Title',
//             ),
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
//           child: TextField(
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               hintText: 'Notes',
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class MyAddButton extends StatefulWidget {
//   const MyAddButton({Key? key}) : super(key: key);

//   @override
//   State<MyAddButton> createState() => _MyAddButtonState();
// }

// class _MyAddButtonState extends State<MyAddButton> {
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton.icon(
//       onPressed: () {},
//       icon: Icon(Icons.add),
//       label: Text("Add"),
//     );
//   }
// }
