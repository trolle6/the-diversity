# THE MOST DIVERSITY

A maximal “museum repo”: programming languages, data formats, build configs, human languages, esoteric codes, queries, shaders, protocols, and misc encodings — all in one place.

Your **Visual Studio** solution still builds the C++ console app in `the most diversity/main.cpp`.

## Quick start

| Action | How |
|--------|-----|
| Build C++ | Open `the most diversity.sln` in Visual Studio → F5 |
| Regenerate bulk files | `powershell -File scripts/generate-museum.ps1` |
| Run samples (if installed) | `powershell -File scripts/run-samples.ps1` |
| Stats | Open `DIVERSITY_INDEX.json` |

## What’s inside

| Folder | Contents |
|--------|----------|
| `languages/` | ~90 hello-world style samples (Python, Rust, COBOL, Brainfuck, Verilog, …) |
| `formats/` | JSON, YAML, XML, TOML, NDJSON, GeoJSON, RSS, iCal, Protobuf, RDF, … |
| `configs/` | npm, Cargo, Gradle, Docker, Terraform, K8s, Ansible, GitHub Actions, … |
| `human-languages/` | 40+ locales in `translations.json` + `.properties` files |
| `queries/` | SQL, SPARQL, Cypher, MongoDB, Datalog, XQuery, … |
| `markup/` | Markdown, LaTeX, AsciiDoc, SVG, Org mode, … |
| `styles/` | CSS, SCSS, LESS, Stylus |
| `shaders/` | GLSL, HLSL, Metal, WGSL |
| `protocols/` | HTTP, OpenAPI, AsyncAPI, gRPC, SOAP, … |
| `esoteric/` | Ook!, Shakespeare, hexdump, … |
| `misc/` | Morse, Base64, ROT13, Braille, chess PGN, ABC notation, … |
| `data/` | ISO samples, HTTP status codes, emoji |

## Philosophy

Nothing here claims every file runs on your machine out of the box. The goal is **breadth**: many paradigms, ecosystems, and notations side by side so you can browse, compare, and extend.

Add your own favorite language or format — drop a file in the right folder and re-run the generator (or edit `scripts/generate-museum.ps1`).

## License

Samples are trivial hello-world snippets; use them however you like.
