extension StringExtension on String {

  String toCamelCase() {
    final str = split(" ");
    var s = "";
    for(var st in str) {
      s += "${st.toFirstUpperCase()} ";
    }
    return s.trim();
  }

  String toFirstUpperCase() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

}