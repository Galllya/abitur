import 'package:abitur/add_EGE_points_page/bloc/add_ege_points_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnterSubjectPoints extends StatefulWidget {
  const EnterSubjectPoints({Key? key}) : super(key: key);

  @override
  _EnterSubjectPointsState createState() => _EnterSubjectPointsState();
}

class _EnterSubjectPointsState extends State<EnterSubjectPoints> {
  // String dropdownValue = 'Русский язык';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEgePointsBloc, AddEgePointsState>(
        builder: (BuildContext context, AddEgePointsState state) {
      String dropdownValue = state.subjects.first.title;
      return Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 3,
                child: DropdownButtonFormField<String>(
                  value: dropdownValue,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: state.subjects.map((favoritesDate) {
                    return DropdownMenuItem<String>(
                      value: favoritesDate.id.toString(),
                      child: Text(favoritesDate.title),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(
                flex: 1,
                child: TextFormField(
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Баллы",
                    )),
              ),
            ],
          ),
        ],
      );
    });
  }
}
