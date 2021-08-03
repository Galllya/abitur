import 'package:abitur/add_EGE_points_page/bloc/add_ege_points_bloc.dart';
import 'package:abitur/add_EGE_points_page/widget/enter_subject_points.dart';
import 'package:abitur/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEgePoints extends StatefulWidget {
  const AddEgePoints({Key? key}) : super(key: key);

  @override
  _AddEgePointsState createState() => _AddEgePointsState();
}

class _AddEgePointsState extends State<AddEgePoints> {
  int howManyAdd = 0;
  bool showDeleteButton = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEgePointsBloc, AddEgePointsState>(
        builder: (BuildContext context, AddEgePointsState state) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            EnterSubjectPoints(),
            for (int i = 0; i < howManyAdd; i++) EnterSubjectPoints(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      howManyAdd++;
                      showDeleteButton = true;
                    });
                  },
                  icon: Icon(Icons.add_circle_outline_rounded),
                  iconSize: 50,
                  color: primaryTheme.primaryColor,
                ),
                if (showDeleteButton)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        howManyAdd--;
                        if (howManyAdd == 0) {
                          showDeleteButton = false;
                        }
                      });
                    },
                    icon: Icon(Icons.keyboard_return),
                    iconSize: 50,
                    color: primaryTheme.primaryColor,
                  )
              ],
            ),
            Text(state.subjects.toString()),
          ],
        ),
      );
    });
  }
}
