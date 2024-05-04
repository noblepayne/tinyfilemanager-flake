{
  coreutils,
  php,
  writeShellApplication,
  tinyFileManager,
}:
writeShellApplication {
  name = "serve";
  runtimeInputs = [
    coreutils # better stat on macos?
    php
    tinyFileManager
  ];
  text = ''
    php -S 127.0.0.1:9999 "${tinyFileManager}/tinyfilemanager.php"
  '';
}
