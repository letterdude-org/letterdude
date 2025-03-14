String stringifyBytes(int bytes) {
  if (bytes < 1024) {
    return '$bytes Bytes';
  }
  return '${(bytes / 1024).toStringAsFixed(2)} KB';
}
