enum UpdateError {
  unknown,
  network,
  manifestInvalid,
  updateUrlInvalid,
  checksumMissing,
  checksumMismatch,
  downloadFailed,
  installerLaunchFailed,
  playUpdateFailed,
}
