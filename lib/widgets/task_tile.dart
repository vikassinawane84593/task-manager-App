import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {

  final String title;
  final String description;
  final String date;

  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskTile({

    super.key,

    required this.title,
    required this.description,
    required this.date,

    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      margin: const EdgeInsets.only(
        bottom: 15,
      ),

      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(15),
      ),

      child: ListTile(

        isThreeLine: true,

        contentPadding:
        const EdgeInsets.all(15),

        title: Text(

          title,

          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Padding(

          padding:
          const EdgeInsets.only(
            top: 8,
          ),

          child: Text(description),
        ),

        trailing: SingleChildScrollView(

          child: Column(

            mainAxisAlignment:
            MainAxisAlignment.start,

            children: [

              Text(

                date,

                style: TextStyle(
                  color: Colors.red.shade700,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              Row(

                mainAxisSize:
                MainAxisSize.min,

                children: [

                  IconButton(

                    onPressed: onEdit,

                    icon: const Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                  ),

                  IconButton(

                    onPressed: onDelete,

                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}