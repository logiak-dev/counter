import 'package:flutter/material.dart';
import 'package:simple_tooltip/simple_tooltip.dart';

class ControlButtonsPanel extends StatelessWidget {
  final VoidCallback _start, _stop, _reset;
  final bool _stopWatchRunning;

  const ControlButtonsPanel(
      this._start, this._stop, this._reset, this._stopWatchRunning);

  @override
  Widget build(BuildContext context) {
    Widget btnPlay = ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).colorScheme.secondary)),
        onPressed: _start,
        child: IconButton(
          icon: Icon(Icons.play_arrow,
              color: _stopWatchRunning ? Colors.grey : Colors.white),
          onPressed: _start,
        ));
    Widget btnPause = ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).colorScheme.secondary)),
        onPressed: _stop,
        child: IconButton(
          icon: Icon(Icons.pause,
              color: !_stopWatchRunning ? Colors.grey : Colors.white),
          onPressed: _stop,
        ));
    Widget btnReset = ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).colorScheme.secondary)),
        onPressed: _reset,
        child: IconButton(
          icon: Icon(Icons.refresh,
              color:   Colors.white),
          onPressed: _reset,
        ));

    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      SimpleTooltip(show: false, content: Text('Play'), child: btnPlay),
      SimpleTooltip(show: false, content: Text('Pause'), child: btnPause),
      if (_reset != null)
        SimpleTooltip(show: false, content: Text('Reset'), child: btnReset)
    ]);
  }
}
