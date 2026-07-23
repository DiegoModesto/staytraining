import 'package:test/test.dart';
import 'package:staytraining_api/staytraining_api.dart';


/// tests for ReportsApi
void main() {
  final instance = StaytrainingApi().getReportsApi();

  group(ReportsApi, () {
    // Relatório semanal
    //
    // Resumo da semana: sessões, médias e por exercício. **Permissão:** `report.read`.
    //
    //Future<WeeklyReport> getWeeklyReport(Date weekStart, { String studentId }) async
    test('test getWeeklyReport', () async {
      // TODO
    });

  });
}
