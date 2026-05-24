(module
  (import "env" "log" (func $log (param i32 i32)))
  (memory 1)
  (data (i32.const 0) "Hello from WebAssembly")
)