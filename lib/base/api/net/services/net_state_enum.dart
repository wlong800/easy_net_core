enum NetState {
  /// Not currently connected to any asynchronous computation.
  ///
  /// For example, a [FutureBuilder] whose [FutureBuilder.future] is null.
  error,

  /// Connected to an asynchronous computation and awaiting interaction.
  waiting,

  /// Connected to an active asynchronous computation.
  ///
  /// For example, a [Stream] that has returned at least one value, but is not
  /// yet done.
  active,

  /// Connected to a terminated asynchronous computation.
  done,
  empty,
}
