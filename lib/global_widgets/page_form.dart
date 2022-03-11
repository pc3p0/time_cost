import 'package:flutter/material.dart';

import '../module/content_view_controller.dart';
import 'custom_form_field.dart';

class PageForm extends StatelessWidget {
  const PageForm({
    Key? key,
    required this.controller,
    required this.formKey,
    required this.enableSalary,
    required this.enableHourly,
    required this.purchaseCostController,
    required this.salaryController,
    required this.hourlyRateController,
    required this.hoursPerWeekController,
    required this.weeksPerYearController,
  }) : super(key: key);

  final ContentViewController controller;
  final GlobalKey<FormState> formKey;
  final bool enableSalary;
  final bool enableHourly;
  final TextEditingController purchaseCostController;
  final TextEditingController salaryController;
  final TextEditingController hourlyRateController;
  final TextEditingController hoursPerWeekController;
  final TextEditingController weeksPerYearController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.vertical,
        spacing: 24,
        children: [
          CustomFormField(
            textController: purchaseCostController,
            helperLabel: 'Cost of purchase',
            prefixIcon: const Icon(Icons.sell_outlined),
            validator: (str) => controller.validatePurchaseCost(str),
            isCurrency: true,
          ),
          CustomFormField(
            textController: salaryController,
            helperLabel: 'Salary',
            prefixIcon: const Icon(Icons.attach_money_rounded),
            validator:
                enableSalary ? (str) => controller.validateSalary(str) : null,
            isCurrency: true,
            isLast: true,
            isEnabled: enableSalary,
          ),
          const Text(
            'Or',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          CustomFormField(
            textController: hourlyRateController,
            helperLabel: 'Hourly rate',
            prefixIcon: const Icon(Icons.attach_money),
            validator: !enableSalary
                ? (val) => controller.validateHourlyRate(val)
                : null,
            isCurrency: true,
            isEnabled: enableHourly,
          ),
          CustomFormField(
            textController: hoursPerWeekController,
            helperLabel: 'Hours per week',
            prefixIcon: const Icon(Icons.timelapse_outlined),
            validator: !enableSalary
                ? (val) => controller.validateHoursPerWeek(val)
                : null,
            isEnabled: enableHourly,
          ),
          CustomFormField(
            textController: weeksPerYearController,
            helperLabel: 'Weeks per year',
            prefixIcon: const Icon(Icons.calendar_month),
            validator: enableHourly
                ? (val) => controller.validateWeeksPerYear(val)
                : null,
            isLast: true,
            isEnabled: enableHourly,
          ),
        ],
      ),
    );
  }
}
