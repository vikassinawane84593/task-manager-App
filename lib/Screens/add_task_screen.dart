import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(
        backgroundColor: Colors.red.shade700,

        title: const Text(
          "Add Task",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,
      ),

      body: SingleChildScrollView(

        child: Padding(
          padding:  EdgeInsets.all(20),

          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                 SizedBox(height: 20),

                 Text(
                  "Task Title",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                 SizedBox(height: 10),

                TextFormField(
                  controller: titleController,

                  decoration: InputDecoration(
                    hintText: "Enter task title",
                    filled: true,
                    fillColor: Colors.white,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),

                  validator: (value) {

                    if (value == null || value.isEmpty) {
                      return "Please enter task title";
                    }

                    return null;
                  },
                ),

                 SizedBox(height: 25),

                 Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                 SizedBox(height: 10),

                TextFormField(
                  controller: descriptionController,
                  maxLines: 5,

                  decoration: InputDecoration(

                    hintText: "Enter task description",

                    filled: true,
                    fillColor: Colors.white,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),

                  validator: (value) {

                    if (value == null || value.isEmpty) {
                      return "Please enter description";
                    }

                    return null;
                  },
                ),

                 SizedBox(height: 25),

                const Text(
                  "Select Date",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                 SizedBox(height: 10),

                Container(

                  padding:  EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 18,
                  ),
                  

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: Row(

                    mainAxisAlignment:
                    MainAxisAlignment.start,

                    children: [

                      Text(

                        selectedDate == null
                            ? "Choose Date"
                            : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",

                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                        ),
                      ),

                      IconButton(

                        onPressed: () async {

                          DateTime? pickedDat =
                          await showDatePicker(

                            context: context,
                            firstDate: DateTime(2025),
                            lastDate: DateTime(2030),
                            initialDate: DateTime.now(),
                          );

                          if (pickedDat != null) {

                            setState(() {
                              selectedDate = pickedDat;
                            });
                          }
                        },

                        icon: Icon(
                          Icons.calendar_month,
                          color: Colors.red.shade700,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),

                    onPressed: () {

                      if (_formKey.currentState!.validate()) {

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Task Added"),
                          ),
                        );
                      }
                    },

                    child: const Text(
                      "Add Task",

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}