import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rebirth/my_rp/user_modal.dart';

import 'data_provider.dart';

class RiverApp extends StatelessWidget {
  const RiverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: const MaterialApp(
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// counterProvider is a simple state provider that holds an integer value
final counterProvider = StateProvider<int>((ref) => 0);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var counter = ref.watch(counterProvider);
    final _data = ref.watch(userDataProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Riverpod Example')),
      body: Column(
        children: [
          Center(
            child: Text('Hello, Riverpod!', style: TextStyle(fontSize: 24)),
          ),

          Text('Counter: $counter', style: TextStyle(fontSize: 24)),
          Divider(color: Colors.blue,thickness: 20,),
          Expanded(
            child: _data.when(data: (data){
              List<UserModel> userList = data.map((e)=> (e)).toList();
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: userList.length,
                        itemBuilder: (_,index){
                          final user = userList[index];
                          return Card(
                            elevation: 4,
                            color: Colors.blue,
                            child: ListTile(
                              title: Text(user.firstName),
                              subtitle: Text(user.email),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(user.avatar),
                            ),
                          ),
                          );
                        }),
                  ),

                ],
              );
            }, error: (err,s) {
              print(err);
              return Center(
                child: Text('Error: $err', style: TextStyle(color: Colors.red, fontSize: 18)),
              );
            }, loading:()=> Center(child: CircularProgressIndicator(),)),
          )


        ],
      ),

      bottomNavigationBar:

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              ref.read(counterProvider.notifier).state++;
            },
            child: const Text('Increment'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(counterProvider.notifier).state--;
            },
            child: const Text('Decrement'),
          ),
        ],
      ),

    );
  }
}
