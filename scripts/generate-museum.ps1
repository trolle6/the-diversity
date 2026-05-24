# One-shot generator for THE MOST DIVERSITY museum files.
$ErrorActionPreference = "Stop"
$Root = Split-Path $PSScriptRoot -Parent
Set-Location $Root

function W($rel, $text) {
    $p = Join-Path $Root $rel
    $dir = Split-Path $p -Parent
    if ($dir -and -not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
    [IO.File]::WriteAllText($p, $text.TrimStart("`n"), [Text.UTF8Encoding]::new($false))
}

# --- Programming languages (hello / tiny sample each) ---
$lang = @{
"languages/python/hello.py" = 'print("Hello from Python 🐍")'
"languages/javascript/hello.js" = 'console.log("Hello from JavaScript");'
"languages/typescript/hello.ts" = 'const msg: string = "Hello from TypeScript"; console.log(msg);'
"languages/java/Hello.java" = @'
public class Hello {
    public static void main(String[] args) {
        System.out.println("Hello from Java");
    }
}
'@
"languages/c/hello.c" = '#include <stdio.h>\nint main(void) { puts("Hello from C"); return 0; }'
"languages/csharp/Hello.cs" = 'class Hello { static void Main() => System.Console.WriteLine("Hello from C#"); }'
"languages/go/hello.go" = @'
package main
import "fmt"
func main() { fmt.Println("Hello from Go") }
'@
"languages/rust/hello.rs" = 'fn main() { println!("Hello from Rust"); }'
"languages/ruby/hello.rb" = 'puts "Hello from Ruby"'
"languages/php/hello.php" = '<?php echo "Hello from PHP\n";'
"languages/swift/hello.swift" = 'print("Hello from Swift")'
"languages/kotlin/hello.kt" = 'fun main() { println("Hello from Kotlin") }'
"languages/scala/Hello.scala" = '@main def hello() = println("Hello from Scala")'
"languages/haskell/hello.hs" = 'main = putStrLn "Hello from Haskell"'
"languages/erlang/hello.erl" = @'
-module(hello).
-export([start/0]).
start() -> io:format("Hello from Erlang~n").
'@
"languages/elixir/hello.exs" = 'IO.puts("Hello from Elixir")'
"languages/clojure/hello.clj" = '(println "Hello from Clojure")'
"languages/lua/hello.lua" = 'print("Hello from Lua")'
"languages/perl/hello.pl" = 'print "Hello from Perl\n";'
"languages/r/hello.R" = 'cat("Hello from R\n")'
"languages/julia/hello.jl" = 'println("Hello from Julia")'
"languages/dart/hello.dart" = @'
void main() { print('Hello from Dart'); }
'@
"languages/zig/hello.zig" = @'
const std = @import("std");
pub fn main() !void { try std.io.getStdOut().writer().print("Hello from Zig\n", .{}); }
'@
"languages/nim/hello.nim" = 'echo "Hello from Nim"'
"languages/crystal/hello.cr" = 'puts "Hello from Crystal"'
"languages/fsharp/hello.fs" = 'printfn "Hello from F#"'
"languages/ocaml/hello.ml" = 'let () = print_endline "Hello from OCaml"'
"languages/common-lisp/hello.lisp" = '(format t "Hello from Common Lisp~%")'
"languages/scheme/hello.scm" = '(display "Hello from Scheme\n")'
"languages/racket/hello.rkt" = '#lang racket\n(displayln "Hello from Racket")'
"languages/prolog/hello.pro" = @'
:- initialization(main).
main :- write('Hello from Prolog'), nl, halt.
'@
"languages/bash/hello.sh" = '#!/usr/bin/env bash\necho "Hello from Bash"'
"languages/powershell/hello.ps1" = 'Write-Output "Hello from PowerShell"'
"languages/fish/hello.fish" = 'echo "Hello from Fish"'
"languages/awk/hello.awk" = 'BEGIN { print "Hello from AWK" }'
"languages/tcl/hello.tcl" = 'puts "Hello from Tcl"'
"languages/groovy/hello.groovy" = 'println "Hello from Groovy"'
"languages/objective-c/hello.m" = '#import <Foundation/Foundation.h>\nint main() { NSLog(@"Hello from Objective-C"); return 0; }'
"languages/d/hello.d" = 'import std.stdio; void main() { writeln("Hello from D"); }'
"languages/vb/Hello.vb" = 'Module Hello\n    Sub Main()\n        System.Console.WriteLine("Hello from VB.NET")\n    End Sub\nEnd Module'
"languages/fortran/hello.f90" = @'
program hello
  print *, "Hello from Fortran"
end program hello
'@
"languages/cobol/hello.cob" = @'
       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLO.
       PROCEDURE DIVISION.
           DISPLAY "Hello from COBOL".
           STOP RUN.
'@
"languages/pascal/hello.pas" = @'
program Hello;
begin
  WriteLn('Hello from Pascal');
end.
'@
"languages/ada/hello.adb" = @'
with Ada.Text_IO; use Ada.Text_IO;
procedure Hello is begin Put_Line ("Hello from Ada"); end Hello;
'@
"languages/matlab/hello.m" = 'disp(''Hello from MATLAB'')'
"languages/solidity/Hello.sol" = '// SPDX-License-Identifier: MIT\npragma solidity ^0.8.0;\ncontract Hello { string public greet = "Hello from Solidity"; }'
"languages/sql/hello.sql" = 'SELECT ''Hello from SQL'' AS greeting;'
"languages/v/hello.v" = 'fn main() { println("Hello from V") }'
"languages/odin/hello.odin" = @'
package main
import "core:fmt"
main :: proc() { fmt.println("Hello from Odin") }
'@
"languages/pony/hello.pony" = @'
actor Main
  new create(env: Env) =>
    env.out.print("Hello from Pony")
'@
"languages/gleam/hello.gleam" = @'
import gleam/io
pub fn main() { io.println("Hello from Gleam") }
'@
"languages/hy/hello.hy" = '(print "Hello from Hy")'
"languages/reason/hello.re" = 'print_string("Hello from ReasonML\n");'
"languages/smalltalk/hello.st" = 'Transcript show: ''Hello from Smalltalk''; cr.'
"languages/forth/hello.fth" = ': HELLO ." Hello from Forth" CR ; HELLO'
"languages/apl/hello.apl" = '← ''Hello from APL'''
"languages/assembly/hello.asm" = @'
; NASM-style (conceptual)
section .data
    msg db 'Hello from Assembly', 10
section .text
    global _start
'@
"languages/wasm/hello.wat" = @'
(module
  (import "env" "log" (func $log (param i32 i32)))
  (memory 1)
  (data (i32.const 0) "Hello from WebAssembly")
)
'@
"languages/html/hello.html" = '<!DOCTYPE html><html lang="en"><body><p>Hello from HTML</p></body></html>'
"languages/css/hello.css" = 'body::before { content: "Hello from CSS (via pseudo-element)"; }'
"languages/graphql/hello.graphql" = 'query { greeting(message: "Hello from GraphQL") }'
"languages/lisp-scheme/r7rs.scm" = '(display "Hello from R7RS Scheme\n")'
"languages/moonscript/hello.moon" = 'print "Hello from MoonScript"'
"languages/haxe/hello.hx" = 'class Main { static function main() { trace("Hello from Haxe"); } }'
"languages/livescript/hello.ls" = 'console.log -> "Hello from LiveScript"'
"languages/coffeescript/hello.coffee" = 'console.log "Hello from CoffeeScript"'
"languages/batch/hello.bat" = '@echo off\necho Hello from Batch'
"languages/autoit/hello.au3" = 'MsgBox(0, "Hello", "Hello from AutoIt")'
"languages/lolcode/hello.lol" = @'
HAI 1.2
CAN HAS STDIO?
VISIBLE "Hello from LOLCODE"
KTHXBYE
'@
"languages/brainfuck/hello.bf" = '++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.'
"languages/befunge/hello.b93" = '"!dlroW olleH">:#,_@'
"languages/chef/hello.chef" = @'
Hello World Souffle.

Ingredients.
72 g letters

Method.
Put letters into 1st mixing bowl.
Liquify contents of the 1st mixing bowl.
Pour contents of the 1st mixing bowl into the 1st baking dish.

Serves 1.
'@
"languages/whitespace/hello.ws" = '   Say hello using Whitespace (spaces/tabs/newlines only — see esoteric/)'
"languages/malbolge/hello.mb" = '(Malbolge is deliberately hostile; this file marks the slot.)'
"languages/unlambda/hello.unl" = '`.Hello from Unlambda``s``k'
"languages/intercal/hello.icl" = 'PLEASE DO ,1 <- #13\nPLEASE DO ,1 SUB #1 <- #238\nPLEASE GIVE UP'
"languages/rockstar/hello.rock" = @'
The world is a stage
Say "Hello from Rockstar"
'@
"languages/verilog/hello.v" = 'module hello; initial $display("Hello from Verilog"); endmodule'
"languages/vhdl/hello.vhd" = @'
entity hello is end hello;
architecture beh of hello is
begin
  process begin
    report "Hello from VHDL";
    wait;
  end process;
end beh;
'@
"languages/labview-note.txt" = 'LabVIEW is graphical — slot reserved for .vi diversity.'
"languages/rpg/hello.rpgle" = '     C                   EVAL      MSG = ''Hello from RPG''\n     C                   DSPLY     MSG'
"languages/abap/hello.abap" = 'WRITE / ''Hello from ABAP''.'
"languages/cobol-copybook/hello.cpy" = '       01  GREETING PIC X(20) VALUE ''Hello from copybook''.'
"languages/plsql/hello.plsql" = 'BEGIN\n  DBMS_OUTPUT.PUT_LINE(''Hello from PL/SQL'');\nEND;'
"languages/t-sql/hello.tsql" = 'PRINT ''Hello from T-SQL'';'
"languages/postgresql/hello.pgsql" = 'DO $$ BEGIN RAISE NOTICE ''Hello from PostgreSQL''; END $$;'
"languages/mysql/hello.mysql.sql" = 'SELECT ''Hello from MySQL'';'
"languages/redis/hello.redis" = 'ECHO "Hello from Redis"'
"languages/lua-config/hello.lua.cfg" = 'return { greeting = "Hello from Lua table config" }'
}

foreach ($kv in $lang.GetEnumerator()) { W $kv.Key $kv.Value }

# --- Data formats ---
W "formats/sample.json" '{"greeting":"Hello from JSON","unicode":"🌍","nested":{"array":[1,2,3]}}'
W "formats/sample.yaml" "greeting: Hello from YAML\nunicode: 🌍\nlist:\n  - alpha\n  - beta\n"
W "formats/sample.yml" "alias: true  # .yml extension\n"
W "formats/sample.xml" '<?xml version="1.0"?><root><greeting>Hello from XML</greeting></root>'
W "formats/sample.toml" "title = \"Hello from TOML\"\n[owner]\nname = \"diversity\"\n"
W "formats/sample.ini" "[section]\ngreeting=Hello from INI\n"
W "formats/sample.csv" "id,name,lang\n1,diversity,csv\n2,museum,tsv-next\n"
W "formats/sample.tsv" "id`tname\n1`tHello from TSV\n"
W "formats/sample.ndjson" '{"line":1}{"line":2,"msg":"Hello from NDJSON"}'
W "formats/sample.json5" "{ greeting: 'Hello from JSON5', trailingComma: true, }"
W "formats/sample.hjson" @'
{
  greeting: Hello from HJSON
  # comments allowed
}
'@
W "formats/sample.edn" '{:greeting "Hello from EDN" :tags [:clojure :data]}'
W "formats/sample.properties" "greeting=Hello from Java Properties\nunicode=\u0041\n"
W "formats/sample.env" "GREETING=Hello from dotenv\nPORT=3000\n"
W "formats/sample.geojson" '{"type":"Feature","properties":{"name":"Diversity Point"},"geometry":{"type":"Point","coordinates":[0,0]}}'
W "formats/sample.feed.rss" '<?xml version="1.0"?><rss version="2.0"><channel><title>Diversity Feed</title><item><title>Hello from RSS</title></item></channel></rss>'
W "formats/sample.atom.xml" '<?xml version="1.0"?><feed xmlns="http://www.w3.org/2005/Atom"><title>Diversity</title><entry><title>Hello from Atom</title></entry></feed>'
W "formats/sample.ics" "BEGIN:VCALENDAR\nVERSION:2.0\nBEGIN:VEVENT\nSUMMARY:Hello from iCal\nEND:VEVENT\nEND:VCALENDAR\n"
W "formats/sample.vcard" "BEGIN:VCARD\nVERSION:3.0\nFN:Hello from vCard\nEND:VCARD\n"
W "formats/sample.bib" '@misc{diversity2026, title={Hello from BibTeX}, year={2026}}'
W "formats/sample.proto" 'syntax = "proto3"; message Greet { string text = 1; } // Hello from Protobuf'
W "formats/sample.avsc" '{"type":"record","name":"Greet","fields":[{"name":"text","type":"string"}]}'
W "formats/sample.cbor-note.txt" "CBOR is binary — slot for .cbor bytes."
W "formats/sample.msgpack-note.txt" "MessagePack is binary — slot reserved."
W "formats/sample.plist.xml" @'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict><key>greeting</key><string>Hello from plist</string></dict></plist>
'@
W "formats/sample.rdf.ttl" '@prefix ex: <http://example.org/> .\nex:greeting "Hello from Turtle/RDF" .'
W "formats/sample.jsonld" '{"@context":"https://schema.org","name":"Hello from JSON-LD"}'
W "formats/sample.sqlite.sql" 'CREATE TABLE greetings (id INTEGER PRIMARY KEY, text TEXT);\nINSERT INTO greetings VALUES (1, ''Hello from SQLite schema'');'
W "formats/sample.parquet-note.txt" "Parquet is columnar binary — noted for diversity."
W "formats/sample.arrow-note.txt" "Apache Arrow IPC — binary columnar format slot."

# --- Configs from many ecosystems ---
W "configs/package.json" '{"name":"the-most-diversity","version":"1.0.0","description":"Hello from npm package.json"}'
W "configs/Cargo.toml" "[package]\nname = \"the-most-diversity\"\nversion = \"0.1.0\"\n"
W "configs/pyproject.toml" '[project]\nname = "the-most-diversity"\nversion = "0.1.0"\n'
W "configs/composer.json" '{"name":"museum/diversity","description":"Hello from Composer"}'
W "configs/Gemfile" 'source "https://rubygems.org"\n# Hello from Bundler Gemfile'
W "configs/go.mod" "module github.com/example/the-most-diversity\n\ngo 1.22\n"
W "configs/build.gradle.kts" 'plugins { java }\n// Hello from Gradle Kotlin DSL'
W "configs/pom.xml" '<project><modelVersion>4.0.0</modelVersion><artifactId>diversity</artifactId></project>'
W "configs/mix.exs" 'defmodule Diversity.MixProject do\n  use Mix.Project\nend'
W "configs/dub.json" '{"name":"diversity","description":"Hello from DUB"}'
W "configs/Package.swift" '// swift-tools-version:5.9\nimport PackageDescription\nlet package = Package(name: "Diversity")'
W "configs/project.clj" '(defproject diversity "0.1.0")'
W "configs/stack.yaml" 'resolver: lts-22.0\n# Hello from Haskell Stack'
W "configs/cabal.project" 'packages: .\n'
W "configs/CMakeLists.txt" 'cmake_minimum_required(VERSION 3.20)\nproject(Diversity)\nadd_executable(diversity languages/c/hello.c)'
W "configs/Makefile" 'all:\n\t@echo Hello from Makefile'
W "configs/Dockerfile" 'FROM alpine:3.19\nRUN echo "Hello from Dockerfile"'
W "configs/docker-compose.yml" "services:\n  diversity:\n    image: alpine:3.19\n    command: echo Hello from Docker Compose\n"
W "configs/.editorconfig" "root = true\n[*]\ncharset = utf-8\nend_of_line = lf\n"
W "configs/tsconfig.json" '{"compilerOptions":{"strict":true},"include":["languages/typescript"]}'
W "configs/biome.json" '{"$schema":"https://biomejs.dev/schemas/1.5.3/schema.json","organizeImports":{"enabled":true}}'
W "configs/eslintrc.cjs" 'module.exports = { rules: {} }; // Hello from ESLint'
W "configs/prettierrc" '{"singleQuote":true}'
W "configs/ruff.toml" 'line-length = 88\n# Hello from Ruff'
W "configs/.pre-commit-config.yaml" "repos:\n  - repo: meta\n    hooks: []\n"
W "configs/ansible-playbook.yml" "- hosts: localhost\n  tasks:\n    - debug: msg=Hello from Ansible\n"
W "configs/terraform/main.tf" 'output "greeting" { value = "Hello from Terraform" }'
W "configs/kubernetes/deployment.yaml" "apiVersion: apps/v1\nkind: Deployment\nmetadata:\n  name: diversity\n"
W "configs/nginx.conf" 'server { listen 80; return 200 "Hello from nginx\n"; }'
W "configs/apache.httpd.conf" '# Hello from Apache httpd'
W "configs/renovate.json" '{"extends":["config:base"]}'
W "configs/dependabot.yml" "version: 2\nupdates: []\n"
W "configs/github-actions-ci.yml" "name: diversity\non: [push]\njobs:\n  hi:\n    runs-on: ubuntu-latest\n    steps:\n      - run: echo Hello from GitHub Actions\n"

# Human-language i18n files live in human-languages/ (UTF-8); see write-human-languages.ps1

# --- Markup & docs ---
W "markup/README fragment.md" '# Hello from Markdown\n\n| Col | Val |\n|-----|-----|\n| diversity | max |\n'
W "markup/sample.adoc" '= Hello from AsciiDoc\n\nThis is *bold* diversity.\n'
W "markup/sample.rst" = "Hello from reStructuredText\n=============================\n\n.. note:: diversity\n"
W "markup/sample.tex" = '\documentclass{article}\begin{document}Hello from \LaTeX\end{document}'
W "markup/sample.org" = '* Hello from Org mode\n** nested\n'
W "markup/sample.mediawiki" = "== Hello from MediaWiki ==\n'''bold''' diversity.\n"
W "markup/sample.bbcode.txt" = '[b]Hello[/b] from BBCode'
W "markup/sample.svg" = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 30"><text y="20">Hello SVG</text></svg>'
W "markup/sample.xhtml" = '<?xml version="1.0"?><html xmlns="http://www.w3.org/1999/xhtml"><body>XHTML</body></html>'

# --- Styles ---
W "styles/hello.css" = '/* CSS */ .diversity { color: rebeccapurple; }'
W "styles/hello.scss" = '$brand: rebeccapurple; .diversity { color: $brand; }'
W "styles/hello.less" = '@brand: rebeccapurple; .diversity { color: @brand; }'
W "styles/hello.styl" = 'brand = rebeccapurple\n.diversity\n  color brand'
W "styles/tailwind.html" = '<div class="text-purple-600 font-bold">Hello Tailwind-style utility classes (in HTML)</div>'

# --- Queries ---
W "queries/ansi.sql" = 'SELECT ''Hello from ANSI SQL'' AS msg;'
W "queries/sparql.rq" = 'SELECT ?greeting WHERE { ?s ?p ?o . BIND("Hello from SPARQL" AS ?greeting) }'
W "queries/cypher.cypher" = 'RETURN "Hello from Cypher" AS greeting;'
W "queries/gremlin.groovy" = 'g.V().limit(1) // Hello from Gremlin'
W "queries/mongodb.js" = 'db.greetings.insertOne({ text: "Hello from MongoDB shell" });'
W "queries/datalog.dl" = 'greeting("Hello from Datalog").'
W "queries/xquery.xq" = '<greeting>{ "Hello from XQuery" }</greeting>'
W "queries/xpath.txt" = '/root/greeting - Hello from XPath expression slot'
W "queries/graphql.gql" = 'query { __typename } # Hello from GraphQL schema queries'

# --- Shaders ---
W "shaders/hello.glsl" = 'void main() { gl_FragColor = vec4(1.0, 0.0, 1.0, 1.0); /* Hello GLSL */ }'
W "shaders/hello.hlsl" = 'float4 main() : SV_Target { return float4(1,0,1,1); } // Hello HLSL'
W "shaders/hello.metal" = '#include <metal_stdlib>\nusing namespace metal;\n// Hello Metal'
W "shaders/hello.wgsl" = '@fragment fn main() -> @location(0) vec4<f32> { return vec4(1.0, 0.0, 1.0, 1.0); }'

# --- Protocols / wire formats ---
W "protocols/http-request.http" = "GET / HTTP/1.1\r\nHost: diversity.local\r\n\r\n"
W "protocols/smtp-dialog.txt" = "220 diversity.local ESMTP\nHELO client\nMAIL FROM:<hi@diversity>\n"
W "protocols/mqtt-connect.txt" = "MQTT CONNECT packet slot (binary protocol)"
W "protocols/dns-query.binnote.txt" = "DNS wire format - binary slot"
W "protocols/gRPC.proto" = 'service Greeter { rpc SayHello (HelloRequest) returns (HelloReply); }'
W "protocols/openapi.yaml" = "openapi: 3.0.0\ninfo:\n  title: Diversity API\n  version: 1.0.0\npaths: {}\n"
W "protocols/asyncapi.yaml" = "asyncapi: 2.6.0\ninfo:\n  title: Diversity Events\n  version: 1.0.0\n"
W "protocols/soap.xml" = '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Body>Hello SOAP</soap:Body></soap:Envelope>'

# --- Regex / encodings / misc codes ---
W "regex/patterns.txt" = 'Email-ish: [A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}
Phone-ish: \+?\d{7,15}
'
W "misc/morse.txt" = '.... . .-.. .-.. ---   ..-. .-. --- --   -- --- .-. ... .'
W "misc/braille.txt" = '⠓⠑⠇⠇⠕ ⠋⠗⠕⠍ ⠃⠗⠁⠊⠇⠇⠑'
W "misc/semaphore.txt" = 'Semaphore: arms spell HELLO (see charts)'
W "misc/rot13.txt" = 'Uryyb sebz EBG13'
W "misc/base64.txt" = 'SGVsbG8gZnJvbSBCYXNlNjQ='
W "misc/hex.txt" = '48656c6c6f2066726f6d20484558'
W "misc.binary.txt" = '01001000 01100101 01101100 01101100 01101111'
W "misc/unicode.txt" = 'Hello world - emoji and math live here (UTF-8 file)'
W "misc/pig-latin.txt" = 'Ellohay omfray Igpay Atinlay'
W "misc/leetspeak.txt" = 'H3ll0 fr0m 1337sp34k'
W "misc/nato.txt" = 'Hotel Echo Lima Lima Oscar'
W "misc/upside-down.txt" = 'plɹoʍ ollǝH'
W "misc/qr-placeholder.svg" = '<svg xmlns="http://www.w3.org/2000/svg" width="64" height="64"><rect width="64" height="64" fill="#fff"/><text x="4" y="32" font-size="8">QR slot</text></svg>'
W "misc/chess-pgn.pgn" = "[Event Diversity]`n1. e4 e5 2. Nf3 Nc6 *`n"
W "misc/music-abc.abc" = 'X:1\nT:Hello Tune\nK:C\n|: C D E G |\n'
W "misc/semver.txt" = '1.0.0-alpha+build.42 - Hello from SemVer'
W "misc/cron.txt" = '0 9 * * 1-5  # Hello from cron - weekdays 9am'
W "misc/uri-examples.txt" = 'https://example.com/path?q=diversity#fragment\nmailto:hi@diversity\nfile:///tmp/x\n'
W "misc/mime.types" = 'text/plain\ntext/html\napplication/json\n'
W "misc/jwt-payload.json" = '{"sub":"diversity","greeting":"Hello from JWT payload - unsigned demo"}'
W "misc/license-spdx.txt" = 'SPDX-License-Identifier: MIT OR Apache-2.0'
W "data/emoji-favorites.txt" = 'rainbow butterfly octopus masks puzzle UFO violin noodles (emoji file)'
W "data/iso-3166-sample.csv" = 'code,name\nSE,Sweden\nJP,Japan\nBR,Brazil\n'
W "data/iso-4217-sample.csv" = 'code,name\nUSD,US Dollar\nEUR,Euro\nJPY,Yen\n'
W "data/http-status-codes.csv" = 'code,phrase\n200,OK\n418,I''m a teapot\n451,Unavailable For Legal Reasons\n'

# --- Esoteric extras ---
W "esoteric/ook.ook" = 'Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook? Ook. Ook! - Ook interpreter'
W "esoteric/shakespeare.sh" = 'Romeo, a young man with a remarkable patience.\nJuliet, a likewise young woman of remarkable grace.\nAct I: Hello.\n[Enter Romeo and Juliet]\nRomeo: Listen to your heart!'
W "esoteric/hexdump-sample.txt" = '00000000  48 65 6c 6c 6f  |Hello|'

# --- DIVERSITY_INDEX ---
$index = @{
  generated = (Get-Date -Format o)
  programming_languages = (Get-ChildItem -Recurse languages -File | Measure-Object).Count
  data_formats = (Get-ChildItem -Recurse formats -File | Measure-Object).Count
  human_language_files = (Get-ChildItem -Recurse human-languages -File | Measure-Object).Count
  config_files = (Get-ChildItem -Recurse configs -File | Measure-Object).Count
  total_files = (Get-ChildItem -Recurse -File | Where-Object { $_.FullName -notmatch '\\\.vs\\' } | Measure-Object).Count
}
$indexJson = ($index | ConvertTo-Json -Depth 3)
W "DIVERSITY_INDEX.json" $indexJson
Write-Host "Generated museum at $Root"
Write-Host $indexJson
