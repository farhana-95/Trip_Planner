import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trip_planner/constants.dart';
import '../add_expense.dart';
import '../expense.dart';
import 'category_model.dart';
import 'category_service.dart';
class CategoryScreen extends StatefulWidget {
  final int tripid;
   CategoryScreen({Key? key,required this.tripid}) : super(key: key);
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}
class _CategoryScreenState extends State<CategoryScreen> {
  static int tripId = 0 ;

  final CommonService _commonService = CommonService();

  List<Cat> catList =  [];
  final FocusNode _textFocusNode = FocusNode();


  @override
  void initState() {
    tripId = widget.tripid;
    print("commonService 2 ${catList.length}");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children:<Widget> [
      Expanded(
          //flex: 3,
          child: FutureBuilder<List<Cat>>(
            future: _commonService.retrieveCategories(),
            builder: (context,future) {
              if(!future.hasData) {
                return Container();
              } else {
                catList = future.data!;
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: catList.length,
                    itemBuilder: (context, index) {
                      // late String position=index.toString();
                      //  if(_searchController.text.isEmpty){
                      return Card(
                        elevation: 1,
                        child: ListTile(
                          onTap: () async {
                            Future.delayed(Duration.zero, () {
                              setState(() {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Expense(
                                           category: catList[index], tripid: tripId,
                                      );
                                    },
                                  ),
                                );
                              });
                            });
                          },
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                              child: Icon(IconDataSolid(

                                  catList[index].icon), size: 20,color: kPrimaryColor,)

                          ),
                          title: Text(catList[index].name),
                        ),
                      );
                    });
              }
            },),

        ),]
      ),
    );
  }

}
