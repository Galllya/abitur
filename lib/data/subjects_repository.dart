import 'package:abitur/data/subjects_provider.dart';
import 'package:abitur/domain/subjects.dart';

abstract class ISubjectsRepository {
  final SubjectsProvider subjectsProvider;

  ISubjectsRepository(this.subjectsProvider);

  Future<List<SubjectsDate>> loadSubjects();
}

class SubjectsRepository extends ISubjectsRepository {
  SubjectsRepository(SubjectsProvider subjectsProvider)
      : super(subjectsProvider);

  @override
  Future<List<SubjectsDate>> loadSubjects() async {
    return subjectsProvider.loadSubjects();
  }
}
