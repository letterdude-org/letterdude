extension DateTimeExtension on DateTime {
  String timePassedSince() {
    final now = DateTime.now();
    if (now.isBefore(this)) {
      return 'in the future 👻';
    }
    final diff = now.difference(this);
    if (diff.inSeconds < 60) {
      return '${diff.inSeconds}s ago';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else {
      return '${diff.inDays}d ago';
    }
  }
}
