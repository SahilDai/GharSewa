import 'package:day35/services/firestore_users.dart';
import 'package:day35/widgets/admin/admin_users_details.dart';
import 'package:flutter/material.dart';

class ViewAllUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Users')),
      body: FutureBuilder<List<UserStruct>>(
        future: getAllUsersFromFireStore("users"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<UserStruct> workers = snapshot.data!;
            return ListView.builder(
              itemCount: workers.length,
              itemBuilder: (BuildContext context, int index) {
                UserStruct worker = workers[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text('${worker.firstName} ${worker.lastName}'),
                      subtitle: Text('Contact: ${worker.contact}'),
                      trailing: ElevatedButton(
                        child: Text('View Detail'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UserDetails(IUsers: worker)));
                        },
                      ),
                    ),
                    Divider(),
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
