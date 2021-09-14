library counter;

import 'dart:async';
import 'package:counter/controls_buttons_panel.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:soundpool/soundpool.dart';

class Counter extends StatefulWidget {
  final GlobalKey<CounterState> key;

  Counter(this.key) : super(key: key);

  @override
  State createState() => CounterState();
}

class CounterState extends State<Counter> {
  /// user hears beeps at half a minute and minute interval
  static const List<int> _kBeepsAt = [30, 60];

  double get ratePerMinute => _ratePerMin;

  static final Soundpool pool = Soundpool.fromOptions();
  final TextEditingController _controller = TextEditingController();

  final TextStyle timerTextStyle =
      const TextStyle(fontSize: 60.0, fontFamily: 'Open Sans');
  final Stopwatch _stopwatch = Stopwatch();

  int _tapCount = 0;
  double _ratePerMin = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _initSounds();
    _timer = Timer.periodic(const Duration(milliseconds: 30), _refresh);
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startWatch() {
    _clickSound();
    _stopwatch.start();
  }

  void _resetWatch() {
    _clickSound();
    _stopwatch.stop();
    _stopwatch.reset();
    if (mounted) {
      setState(() {
        _tapCount = 0;
        _ratePerMin = 0;
      });
    }
  }

  void _stopWatch() {
    _clickSound();
    if (mounted) {
      setState(() {
        _stopwatch.stop();
      });
    }
  }

  void _increment() {
    if (_stopwatch.isRunning) {
      _clickSound();
      if (mounted) {
        setState(() {
          _tapCount += 1;
        });
      }
    }
  }

  void _refresh(Timer timer) {
    if (_stopwatch.isRunning) {
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget buttonsPanel = ControlButtonsPanel(
        _startWatch, _stopWatch, _resetWatch, _stopwatch.isRunning);

    Widget timeDisplay = Container();

    Widget btnClick = ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).colorScheme.secondary)),
        onPressed: _increment,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
            ),
            child: Padding(
                padding: EdgeInsets.all(80),
                child: Icon(Icons.add,
                    size: 60.0,
                    color:
                        _stopwatch.isRunning ? Colors.white : Colors.grey))));

    if (_stopwatch.elapsed != null && _tapCount > 0) {
      if (_kBeepsAt.contains(_stopwatch.elapsed.inSeconds)) {
        _notificationSound();
      }

      double millsecondPerBeat = _stopwatch.elapsed.inMilliseconds / _tapCount;
      _ratePerMin = 60 / (millsecondPerBeat / 1000);
      timeDisplay = Text(_ratePerMin.toInt().toString() + '/min',
          style: const TextStyle(fontSize: 32));
      _controller.text = _ratePerMin.toInt().toString();
    }
    return Material(
        color: Colors.transparent,
        elevation: 16,
        child: Container(
            height: 470,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryVariant,
              borderRadius: BorderRadius.circular(35),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(32, 16, 32, 16),
                      child: _buildDisplay(timeDisplay)),
                  Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(32, 16, 32, 16),
                      child: buttonsPanel),
                  Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: btnClick),
                ])));
  }

  Widget _buildDisplay(Widget timeDisplay) {
    return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(32, 16, 32, 16),
            child: IntrinsicHeight(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                  Column(children: [
                    Text('${_stopwatch.elapsed.inSeconds} s',
                        style: const TextStyle(fontSize: 32)),
                    SizedBox(height: 4),
                    Text('Elapsed', style: const TextStyle(fontSize: 14)),
                  ]),
                  if (_stopwatch.elapsed != null && _tapCount > 0)
                    VerticalDivider(
                      width: 9,
                      thickness: 1,
                      color: Colors.black26,
                    ),
                  if (_stopwatch.elapsed != null && _tapCount > 0)
                    Column(children: [
                      timeDisplay,
                      SizedBox(height: 4),
                      Text('Rate', style: const TextStyle(fontSize: 14)),
                    ]),
                ]))));
  }

  double getBeatsPerMinute() {
    return double.tryParse(_controller.text) ?? 0;
  }


  static const String kTapWav =
      'assets/sounds/03_Primary_System_Sounds/ui_tap-variant-01.m4a';

  static const String kNotificationWav =
      'assets/sounds/02_Alerts_and_Notifications/notification_simple-01.m4a';


  static final Map<String, int> _soundsMap = <String, int>{};

  static Future<void> _initSounds() async {

    _soundsMap[kTapWav] = await _load(kTapWav);

    _soundsMap[kNotificationWav] = await _load(kNotificationWav);

  }

  static Future<void> _notificationSound() async {
    int i = _soundsMap[kNotificationWav] ?? 0;
    return _play(i);
  }

  static Future<void> _clickSound() async {
    int i = _soundsMap[kTapWav] ?? 0;
    return _play(i);
  }

  static Future<int> _load(String audioPath) async {
    int soundId = await rootBundle.load(audioPath).then((ByteData soundData) {
      return pool.load(soundData);
    });
    return soundId;
  }

  static Future<void> _play(int soundId) async {
    await pool.play(soundId);
  }
}
