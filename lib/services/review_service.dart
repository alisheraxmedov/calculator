import 'package:get_storage/get_storage.dart';
import 'package:in_app_review/in_app_review.dart';

class ReviewService {
  static const _countKey = 'review_calc_count';
  static const _askedKey = 'review_asked';
  static const _triggerAt = 7;

  static final GetStorage _box = GetStorage();
  static final InAppReview _review = InAppReview.instance;

  static Future<void> registerCalculation() async {
    if (_box.read<bool>(_askedKey) ?? false) return;

    final next = (_box.read<int>(_countKey) ?? 0) + 1;
    await _box.write(_countKey, next);

    if (next == _triggerAt) {
      await _maybeRequest();
    }
  }

  static Future<void> _maybeRequest() async {
    try {
      if (await _review.isAvailable()) {
        await _review.requestReview();
        await _box.write(_askedKey, true);
      }
    } catch (_) {
      // Play Services yo'q yoki quota tugagan — silent fail
    }
  }
}
