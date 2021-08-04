import 'package:abitur/add_EGE_points_page/bloc/add_ege_points_bloc.dart';
import 'package:abitur/add_EGE_points_page/widget/enter_subject_points.dart';
import 'package:abitur/common/bloc/account_bloc/account_bloc.dart';
import 'package:abitur/domain/subjects.dart';
import 'package:abitur/profile_page/view/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddEgePoints extends StatefulWidget {
  const AddEgePoints({Key? key}) : super(key: key);

  @override
  _AddEgePointsState createState() => _AddEgePointsState();
}

class _AddEgePointsState extends State<AddEgePoints> {
  final form = FormGroup({
    'subjects': FormArray([]),
  });

  void addSubjectToForm() {
    setState(() {
      (form.control('subjects') as FormArray).add(
          FormGroup({'id': FormControl<int>(), 'value': FormControl<int>()}));
    });
  }

  void validation(int index, SubjectsDate targetSubject) {
    ((form.control('subjects') as FormArray).controls.elementAt(index)
            as FormGroup)
        .control('value')
        .setValidators([Validators.max(targetSubject.maxValue)],
            autoValidate: true);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEgePointsBloc, AddEgePointsState>(
        builder: (BuildContext context, AddEgePointsState state) {
      return state.loading
          ? ReactiveForm(
              formGroup: form,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        onPressed: addSubjectToForm,
                        child: Text(
                          'Добавить предмет',
                          style: TextStyle(color: Colors.white),
                        )),
                    Expanded(
                      child: ListView.builder(
                        itemCount: (form.control('subjects') as FormArray)
                            .controls
                            .length,
                        itemBuilder: (context, index) {
                          return EnterSubjectPoints(
                              onSubjectSelect: (subjectId) {
                                final targetSubject = state.subjects.firstWhere(
                                    (element) => element.id == subjectId);
                                validation(index, targetSubject);
                              },
                              delete: () {
                                setState(() {
                                  (form.control('subjects') as FormArray)
                                      .removeAt(index);
                                });
                              },
                              subjects: state.subjects,
                              formGroup: (form.control('subjects') as FormArray)
                                  .controls
                                  .elementAt(index) as FormGroup);
                        },
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          print(form.value);
                          context.read<AddEgePointsBloc>()
                            ..add(PutSubjects(formGroup: form.value));
                          if (state.success) {
                            Navigator.pop(context, ProfilePage());
                            context
                                .read<AccountBloc>()
                                .add(LoadingProfileData());
                          } else {
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Не удалось отправить данные"),
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Готово',
                          style: TextStyle(color: Colors.white),
                        )),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            )
          : Center(child: CircularProgressIndicator());
      
    });
  }
}
