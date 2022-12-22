import 'package:flutter/material.dart';

import '../../../../constants.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: GestureDetector(
              child: Card(
                elevation: 2,
                child: SizedBox(
                    height: 70,
                    width: MediaQuery.of(context).size.width - 28,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25,left: 10),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            const WidgetSpan(
                              child: Icon(
                                Icons.settings_backup_restore,
                                color: Color(0xFF868585),
                                size: 18,
                              ),
                            ),
                            TextSpan(
                              text:
                              ' Reset All Data',
                              style: const TextStyle(
                                  fontSize: 17,
                                  color: Color(0xFF868585)),
                            ),
                          ],
                        ),
                      ),
                    ),
                ),
              ),
              onTap: (){
                showDialog<void>(context: context, builder: (ctx)=>
                AlertDialog(
                  content: const Text('Reset Data'),
                  actions: [
                    TextButton(onPressed: (){

                    },
                        child: Text('OK')),
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text('Cancel'))
                  ],
                ));
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: GestureDetector(
              child: Card(
                elevation: 2,
                child: SizedBox(
                    height: 70,
                    width: MediaQuery.of(context).size.width - 28,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25,left: 10),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            const WidgetSpan(
                              child: Icon(
                                Icons.delete,
                                color: Color(0xFF868585),
                                size: 18,
                              ),
                            ),
                            TextSpan(
                              text:
                              ' Delete Account',
                              style: const TextStyle(
                                  fontSize: 17,
                                  color: Color(0xFF868585)),
                            ),
                          ],
                        ),
                      ),
                    ),),
              ),
              onTap: (){},
            ),
          ),
        ],
      ),
    );
  }
}
