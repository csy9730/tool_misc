# scipy.signal.findpeaks



```python
scipy.signal.find_peaks(x, height=None, threshold=None, distance=None, prominence=None, width=None, wlen=None, rel_height=0.5, plateau_size=None)
```

Parameters

- **x** sequence

  包含峰值的信号（数组/序列格式）

- **height** number or ndarray or sequence, optional

  波升的最小值和最大值约束。

  > Required height of peaks. Either a number, `None`, an array matching *x* or a 2-element sequence of the former. The first element is always interpreted as the minimal and the second, if supplied, as the maximal required height.

- **threshold** number or ndarray or sequence, optional

  Required threshold of peaks, the vertical distance to its neighboring samples. Either a number, `None`, an array matching *x* or a 2-element sequence of the former. The first element is always interpreted as the minimal and the second, if supplied, as the maximal required threshold.

- **distance**number, optional

  水平距离约束。多个波峰近邻 ，将会删除较低的波峰。

  > Required minimal horizontal distance (>= 1) in samples between neighbouring peaks. Smaller peaks are removed first until the condition is fulfilled for all remaining peaks.

- **prominence**number or ndarray or sequence, optional

  Required prominence of peaks. Either a number, `None`, an array matching *x* or a 2-element sequence of the former. The first element is always interpreted as the minimal and the second, if supplied, as the maximal required prominence.

- **width**number or ndarray or sequence, optional

  Required width of peaks in samples. Either a number, `None`, an array matching *x* or a 2-element sequence of the former. The first element is always interpreted as the minimal and the second, if supplied, as the maximal required width.

- **wlen**int, optional

  Used for calculation of the peaks prominences, thus it is only used if one of the arguments *prominence* or *width* is given. See argument *wlen* in [`peak_prominences`](https://docs.scipy.org/doc/scipy/reference/generated/scipy.signal.peak_prominences.html#scipy.signal.peak_prominences) for a full description of its effects.

- **rel_height**float, optional

  Used for calculation of the peaks width, thus it is only used if *width* is given. See argument *rel_height* in [`peak_widths`](https://docs.scipy.org/doc/scipy/reference/generated/scipy.signal.peak_widths.html#scipy.signal.peak_widths) for a full description of its effects.

- **plateau_size**number or ndarray or sequence, optional

  Required size of the flat top of peaks in samples. Either a number, `None`, an array matching *x* or a 2-element sequence of the former. The first element is always interpreted as the minimal and the second, if supplied as the maximal required plateau size.*New in version 1.2.0.*

Returns

- **peaks**ndarray

  Indices of peaks in *x* that satisfy all given conditions.

- **properties**dict

  A dictionary containing properties of the returned peaks which were calculated as intermediate results during evaluation of the specified conditions:‘peak_heights’If *height* is given, the height of each peak in *x*.‘left_thresholds’, ‘right_thresholds’If *threshold* is given, these keys contain a peaks vertical distance to its neighbouring samples.‘prominences’, ‘right_bases’, ‘left_bases’If *prominence* is given, these keys are accessible. See [`peak_prominences`](https://docs.scipy.org/doc/scipy/reference/generated/scipy.signal.peak_prominences.html#scipy.signal.peak_prominences) for a description of their content.‘width_heights’, ‘left_ips’, ‘right_ips’If *width* is given, these keys are accessible. See [`peak_widths`](https://docs.scipy.org/doc/scipy/reference/generated/scipy.signal.peak_widths.html#scipy.signal.peak_widths) for a description of their content.‘plateau_sizes’, left_edges’, ‘right_edges’If *plateau_size* is given, these keys are accessible and contain the indices of a peak’s edges (edges are still part of the plateau) and the calculated plateau sizes.*New in version 1.2.0.*To calculate and return properties without excluding peaks, provide the open interval `(None, None)` as a value to the appropriate argument (excluding *distance*).



