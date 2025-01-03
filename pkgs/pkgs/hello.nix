{ writeShellScriptBin }:
writeShellScriptBin "hello" ''
  echo "hello, world!"
''
