import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  bool isExpense = true;
  List<String> categories = [
    "Food",
    "Transport",
    "Shopping",
    "Health",
    "Education",
    "Entertainment",
    "Others"
  ];
  late String dropDownValue = categories.first;
  TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Transactions"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Switch(
                    value: isExpense,
                    onChanged: (bool value) {
                      setState(() {
                        isExpense = value;
                      });
                    },
                    inactiveTrackColor: Colors.green[200],
                    inactiveThumbColor: Colors.green,
                    activeColor: Colors.red,
                  ),
                  SizedBox(width: 10),
                  Text(
                    isExpense ? "Expense" : "Income",
                    style: GoogleFonts.montserrat(
                        fontSize: 20,
                        color: isExpense ? Colors.red : Colors.green),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Amount",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Text(
                "Select Category",
                style: GoogleFonts.montserrat(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: DropdownButton<String>(
                  value: dropDownValue,
                  isExpanded: true,
                  icon: Icon(Icons.arrow_downward),
                  items:
                      categories.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {}),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                  readOnly: true,
                  controller: dateController,
                  decoration: InputDecoration(labelText: "Enter Date"),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now());

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('d MMMM yyyy').format(pickedDate);
                      dateController.text = formattedDate;
                    }
                  }),
            ),
            SizedBox(height: 20),
            Center(child: ElevatedButton(onPressed: () {}, child: Text("Save")))
          ],
        )),
      ),
    );
  }
}
