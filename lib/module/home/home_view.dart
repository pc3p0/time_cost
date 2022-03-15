import 'package:flutter/material.dart';
import 'package:money_time/module/home/local_widgets/page_form.dart';

import '../../model/time_value_analysis.dart';
import 'home_view_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  /// An example controller for performing logic.
  final _controller = HomeViewController();

  final _formKey = GlobalKey<FormState>();

  final _purchaseCostController = TextEditingController();
  final _salaryController = TextEditingController();
  final _hourlyRateController = TextEditingController();
  final _hoursPerWeekController = TextEditingController();
  final _weeksPerYearController = TextEditingController();

  /// The default Widget to display as the SliverAppBar title.
  static const _resultsPlaceholderWidget = Text(
    'Complete the relevant fields below, to see how much of your time that next purchase will cost you!',
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 16, color: Colors.white),
  );
  Widget _resultsWidget = _resultsPlaceholderWidget;

  static const String _defaultTitleText = 'What\'s your time cost?';
  String _titleText = _defaultTitleText;

  bool _enableSalary = true;
  bool _enableHourly = true;

  @override
  void initState() {
    _salaryController.addListener(() {
      setState(() {
        _enableHourly = (_salaryController.text.trim().isEmpty) ? true : false;
      });
    });

    _hourlyRateController.addListener(() {
      setState(() {
        _enableSalary =
            (_hourlyRateController.text.trim().isEmpty) ? true : false;
      });
    });
    super.initState();
  }

  void _updateTitleText(String newTitle) {
    setState(() {
      _titleText = newTitle;
    });
  }

  /// Update `_titleWidget`.
  void _updateResultsWidget(Widget newText) {
    setState(() {
      _resultsWidget = newText;
    });
  }

  /// Clear any Form fields of focus.
  void _clearFocus() => FocusScope.of(context).unfocus();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                _titleText,
                key: ValueKey<String>(_titleText),
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      switchInCurve: Curves.easeInOut,
                      switchOutCurve: Curves.easeInOut,
                      child: _resultsWidget,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: PageForm(
                    controller: _controller,
                    formKey: _formKey,
                    enableSalary: _enableSalary,
                    enableHourly: _enableHourly,
                    purchaseCostController: _purchaseCostController,
                    salaryController: _salaryController,
                    hourlyRateController: _hourlyRateController,
                    hoursPerWeekController: _hoursPerWeekController,
                    weeksPerYearController: _weeksPerYearController,
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        _updateResultsWidget(_resultsPlaceholderWidget);
                        _updateTitleText(_defaultTitleText);
                      },
                      child: const Text('Clear'),
                    ),
                    ElevatedButton(
                      onPressed: () => _showAnalysis(theme),
                      child: const Text('Show Me'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Perform some logic.
  TimeValueAnalysis? _validateForm() {
    if (_formKey.currentState!.validate()) {
      // Ensure we collect the right data
      if (_enableSalary) {
        var costOfItem =
            _purchaseCostController.text.trim().substring(1).split(',').join();
        var salary =
            _salaryController.text.trim().substring(1).split(',').join();
        return _controller.costOfTime(
          costOfItem,
          true,
          salary: salary,
        );
      } else {
        var costOfItem =
            _purchaseCostController.text.trim().substring(1).split(',').join();
        var hourly =
            _hourlyRateController.text.trim().substring(1).split(',').join();
        var hoursPerWeek = _hoursPerWeekController.text.trim();
        var weeksPerYear = _weeksPerYearController.text.trim();
        return _controller.costOfTime(
          costOfItem,
          false,
          rate: hourly,
          hoursPerWeek: hoursPerWeek,
          weeksPerYear: weeksPerYear,
        );
      }
    }
    return null;
  }

  /// Update the UI with the results based on user input.
  void _showAnalysis(ThemeData theme) {
    _clearFocus();
    TimeValueAnalysis? data = _validateForm();

    if (data != null) {
      var costInHours = (double.parse(data.purchaseCost ?? '0') /
              double.parse(data.costInTime ?? '0'))
          .toStringAsFixed(2);

      var rw = RichText(
        text: TextSpan(
          text: costInHours,
          style: TextStyle(
            fontSize: theme.textTheme.displayMedium?.fontSize,
            color: theme.colorScheme.onPrimary,
          ),
          children: const [
            TextSpan(
              text: ' Hours',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      );

      _updateResultsWidget(rw);
      _updateTitleText('A purcahse of \$${data.purchaseCost} will cost you');
    }
  }

  @override
  void dispose() {
    _purchaseCostController.dispose();
    _salaryController.dispose();
    _hourlyRateController.dispose();
    _hoursPerWeekController.dispose();
    _weeksPerYearController.dispose();
    super.dispose();
  }
}
