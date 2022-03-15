import 'package:flutter_test/flutter_test.dart';
import 'package:money_time/model/time_value_analysis.dart';

import 'package:money_time/module/home/home_view_controller.dart';

void main() {
  final _controller = HomeViewController();
  String? _nullUserInput;

  group('Currency Field Validation', () {
    /// Currency TextFormField Validation.
    test('Invalid purchase cost', () {
      expect('Enter purchase cost',
          _controller.validatePurchaseCost(_nullUserInput));
    });

    test('Valid purchase cost', () {
      String validCurrency = '\$50.00';
      expect(null, _controller.validatePurchaseCost(validCurrency));
    });

    /// Salary Validation
    test('Invalid salary', () {
      expect('Enter salary', _controller.validateSalary(_nullUserInput));
    });

    test('Valid salary', () {
      String salary = '\$65,000';
      expect(null, _controller.validateSalary(salary));
    });

    /// Hourly Rate Validation
    test('Invalid hourly rate', () {
      expect(
          'Enter hourly rate', _controller.validateHourlyRate(_nullUserInput));
    });

    test('Valid hourly rate', () {
      String rate = '\$65';
      expect(null, _controller.validateHourlyRate(rate));
    });
  });

  /// Non-Currency TextFormField Validation
  group('TextFieldForm Validation', () {
    /// Hours Per Week
    test('Invalid hours per week', () {
      expect('Enter hours worked weekly',
          _controller.validateHoursPerWeek(_nullUserInput));
    });

    test('Negative hours per week', () {
      expect('Must be greater than 0', _controller.validateHoursPerWeek('-5'));
    });

    test('Hours per week exceed max', () {
      expect('Yeah, ok', _controller.validateHoursPerWeek('200'));
    });

    test('Valid hours per week', () {
      expect(null, _controller.validateHoursPerWeek('35'));
    });

    /// Weeks Per Year
    test('Invalid weeks per year', () {
      expect('Enter weeks worked annually',
          _controller.validateWeeksPerYear(_nullUserInput));
    });

    test('Negative weeks per year', () {
      expect('Must be greater than 0', _controller.validateWeeksPerYear('-5'));
    });

    test('Weeks per year exceed max', () {
      expect('Yeah, sure', _controller.validateWeeksPerYear('60'));
    });

    test('Valid weeks per year', () {
      expect(null, _controller.validateWeeksPerYear('40'));
    });
  });

  /// Unit Tests for `HomeViewController` logic.
  group('HomeViewController Logic', () {
    const _purchaseCost = '75.00';
    const _salary = '45000.00';
    const _rate = '20.00';
    const _hoursPerWeek = '30';
    const _weeksPerYear = '40';

    final _salaryTimevalueAnalysis =
        TimeValueAnalysis(costInTime: '14.60', purchaseCost: _purchaseCost);
    final _hourlyTimevalueAnalysis =
        TimeValueAnalysis(costInTime: '27.38', purchaseCost: _purchaseCost);

    bool _isValidSalaryCostOfTime(
        TimeValueAnalysis? timeValueAnalysis, TimeValueAnalysis matcher) {
      return (timeValueAnalysis == null)
          ? false
          : (timeValueAnalysis.costInTime == matcher.costInTime) &&
              (timeValueAnalysis.purchaseCost == matcher.purchaseCost);
    }

    test('costOfTime() should return null', () {
      expect(null, _controller.costOfTime('100.00', true, salary: null));
    });

    test('costOfTime() should return null', () {
      expect(null, _controller.costOfTime('100.00', false));
    });

    test('costOfTime() should return result for salary', () {
      var costOfTime =
          _controller.costOfTime(_purchaseCost, true, salary: _salary);
      expect(
          true, _isValidSalaryCostOfTime(costOfTime, _salaryTimevalueAnalysis));
    });

    test('costOfTime() should return result for hourly', () {
      var costOfTime = _controller.costOfTime(
        _purchaseCost,
        false,
        rate: _rate,
        hoursPerWeek: _hoursPerWeek,
        weeksPerYear: _weeksPerYear,
      );
      expect(
          true, _isValidSalaryCostOfTime(costOfTime, _hourlyTimevalueAnalysis));
    });
  });
}
