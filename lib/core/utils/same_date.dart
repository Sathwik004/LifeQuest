bool isSameDate(DateTime storedDate) {
  DateTime today = DateTime.now();
  try {
    if (storedDate.year == today.year &&
        storedDate.month == today.month &&
        storedDate.day == today.day) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
