import 'package:money_time/model/time_value_analysis.dart';

/// An example Controller for `ContentView`.
class ContentViewController {
  String? validatePurchaseCost(String? str) =>
      (str == null || str.isEmpty) ? 'Enter purchase cost' : null;

  String? validateSalary(String? str) =>
      (str == null || str.isEmpty) ? 'Enter salary' : null;

  String? validateHourlyRate(String? str) =>
      (str == null || str.isEmpty) ? 'Enter hourly rate' : null;

  String? validateHoursPerWeek(String? str) {
    var strDouble = double.parse(str ?? '0');
    return (str == null || str.isEmpty)
        ? 'Enter hours worked weekly'
        : (strDouble <= 0)
            ? 'Must be greater than 0'
            : (strDouble > 168)
                ? 'Yeah, ok'
                : null;
  }

  String? validateWeeksPerYear(String? str) {
    var strDouble = double.parse(str ?? '0');
    return (str == null || str.isEmpty)
        ? 'Enter weeks worked annually'
        : (strDouble <= 0)
            ? 'Must be greater than 0'
            : (strDouble > 52)
                ? 'Yeah, sure'
                : null;
  }

  /// Calculate cost of an individual's time, based on hourly income & purchase cost.
  TimeValueAnalysis? costOfTime(String purchaseCost, bool isSalary,
      {String? salary,
      String? rate,
      String? hoursPerWeek,
      String? weeksPerYear}) {
    // Calculate for salaried individuals.
    // Value of one hour (60 mins) - 365 days * 24 hours per day.
    if (isSalary && salary != null) {
      return TimeValueAnalysis(
        costInTime: (double.parse(purchaseCost) / (double.parse(salary) / 8760))
            .toStringAsFixed(2),
        purchaseCost: purchaseCost,
      );
    } else {
      // Calculate for salaried individuals.
      if (rate != null && hoursPerWeek != null && weeksPerYear != null) {
        var rateToNum = double.parse(rate);
        var hoursPerWeekToNum = double.parse(hoursPerWeek);
        var weeksPerYearToNum = double.parse(weeksPerYear);

        // Convert hourly rate to equivalent salary spread over a fulll year.
        var equivalentSalary =
            ((weeksPerYearToNum * hoursPerWeekToNum) * rateToNum);

        return TimeValueAnalysis(
          costInTime: (double.parse(purchaseCost) / (equivalentSalary / 8760))
              .toStringAsFixed(2),
          purchaseCost: purchaseCost,
        );
      }
    }
    return null;
  }
}
