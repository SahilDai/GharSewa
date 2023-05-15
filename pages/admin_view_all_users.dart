import 'package:day35/pages/admin_user_detail.dart';
import 'package:day35/pages/admin_worker_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewAllUser extends StatelessWidget {
  ViewAllUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Replace with your actual data
    List<Map<String, dynamic>> workers = [
      {'name': 'John Doe', 'age': 32},
      {'name': 'Jane Smith', 'age': 28},
      {'name': 'Bob Johnson', 'age': 45},
      {'name': 'Emily Davis', 'age': 22},
      {'name': 'Michael Lee', 'age': 37},
      {'name': 'Sara Brown', 'age': 29},
      {'name': 'David Chen', 'age': 50},
      {'name': 'Karen Kim', 'age': 41},
      {'name': 'Peter Wong', 'age': 34},
      {'name': 'Lisa Nguyen', 'age': 26},
    ];

    return Scaffold(
      appBar: AppBar(title: Text('All Users')),
      body: ListView.builder(
        itemCount: workers.length,
        itemBuilder: (BuildContext context, int index) {
          Map<String, dynamic> worker = workers[index];
          return Column(
            children: [
              ListTile(
                title: Text(worker['name']),
                subtitle: Text('Age: ${worker['age']}'),
                trailing: ElevatedButton(
                  child: Text('View Detail'),
                  onPressed: () {
                    // Navigate to detail widget with worker data
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserDetail()));
                  },
                ),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}
