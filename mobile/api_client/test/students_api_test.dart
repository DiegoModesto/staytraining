import 'package:test/test.dart';
import 'package:staytraining_api/staytraining_api.dart';


/// tests for StudentsApi
void main() {
  final instance = StaytrainingApi().getStudentsApi();

  group(StudentsApi, () {
    // Adicionar apontamento (admin, auditado)
    //
    // **Permissão:** `studentficha.write`.
    //
    //Future<IdResponse> addStudentApportment(String id, AddApportmentRequest addApportmentRequest) async
    test('test addStudentApportment', () async {
      // TODO
    });

    // Adicionar anotação
    //
    // Anotação do professor (nunca visível ao aluno). Com `workoutId`, fica vinculada a um treino. **Permissão:** `health.write`.
    //
    //Future<IdResponse> addStudentNote(String id, AddStudentNoteRequest addStudentNoteRequest) async
    test('test addStudentNote', () async {
      // TODO
    });

    // Obter ficha do aluno
    //
    // Dados pessoais, foto e apontamentos de saúde. **Permissão:** `student.read`.
    //
    //Future<StudentDetail> getStudentById(String id) async
    test('test getStudentById', () async {
      // TODO
    });

    // Histórico de edições da ficha
    //
    // **Permissão:** `studentficha.write`.
    //
    //Future<BuiltList<StudentEditLog>> listStudentEditLogs(String id) async
    test('test listStudentEditLogs', () async {
      // TODO
    });

    // Listar anotações do aluno
    //
    // Anotações do professor (gerais e por treino). **Permissão:** `student.read`.
    //
    //Future<BuiltList<StudentNote>> listStudentNotes(String id) async
    test('test listStudentNotes', () async {
      // TODO
    });

    // Listar alunos
    //
    // **Permissão:** `student.read`.
    //
    //Future<BuiltList<StudentListItem>> listStudents() async
    test('test listStudents', () async {
      // TODO
    });

    // Cadastrar aluno
    //
    // **Permissão:** `student.manage`.
    //
    //Future<IdResponse> registerStudent(RegisterStudentRequest registerStudentRequest) async
    test('test registerStudent', () async {
      // TODO
    });

    // Remover apontamento (admin, auditado)
    //
    // **Permissão:** `studentficha.write`.
    //
    //Future removeStudentApportment(String id, String apportmentId) async
    test('test removeStudentApportment', () async {
      // TODO
    });

    // Editar ficha (admin, auditado)
    //
    // Admin edita os dados da ficha; a edição é registrada em edit-logs. **Permissão:** `studentficha.write`.
    //
    //Future updateStudentFicha(String id, UpdateStudentFichaRequest updateStudentFichaRequest) async
    test('test updateStudentFicha', () async {
      // TODO
    });

  });
}
