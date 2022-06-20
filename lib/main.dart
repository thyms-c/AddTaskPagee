import 'package:flutter/material.dart';
import 'package:my_app/screen/addtask.dart';
import 'package:intl/intl.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

void main() {
  var app = MaterialApp(
    title: "My App",
    home: MyHomePage(),
    theme: ThemeData(primarySwatch: Colors.blue),
  );
  runApp(app);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "Home",
              style: TextStyle(fontSize: 19),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const AddTask()));
                },
              )
            ]),
        body: Container());
  }
}





class AddTask extends StatelessWidget {
  const AddTask({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add Task",
            style: TextStyle(fontSize: 19),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            child: Column(children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                  hintText: 'Enter Title',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Note',
                  hintText: 'Enter Note',
                ),
              ),
              const SizedBox(height: 15),
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
              const SizedBox(height: 15),
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
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.add),
                label: const Text("Add"),
              )
            ]),
          ),
        ));
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
