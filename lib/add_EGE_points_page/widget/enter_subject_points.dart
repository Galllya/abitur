import 'package:abitur/domain/subjects.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EnterSubjectPoints extends StatelessWidget {
  final VoidCallback delete;
  final Function(int?) onSubjectSelect;
  final List<SubjectsDate> subjects;
  final FormGroup formGroup;
  const EnterSubjectPoints(
      {Key? key,
      required this.subjects,
      required this.formGroup,
      required this.delete,
      required this.onSubjectSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: formGroup,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                  flex: 3,
                  child: ReactiveDropdownField(
                    onChanged: onSubjectSelect,
                    formControlName: 'id',
                    items: [
                      ...subjects.map((e) => DropdownMenuItem<int>(
                            child: Text(e.title),
                            value: e.id,
                          ))
                    ],
                  )),
              SizedBox(
                width: 20,
              ),
              Flexible(
                flex: 1,
                child: ReactiveTextField(
                    formControlName: 'value',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Баллы",
                    )),
              ),
              IconButton(
                  onPressed: () {
                    delete();
                  },
                  icon: Icon(Icons.delete))
            ],
          ),
        ],
      ),
    );
  }
}
