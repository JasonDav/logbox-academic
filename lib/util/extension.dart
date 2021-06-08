import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


/// Extension on [BuildContext] to allow for reads 
/// on state outside of widget tree with [Provider].
extension readProvExtension<T> on BuildContext {
  T staticRead<T>() {
    return Provider.of<T>(this, listen: false);
  }
}