#!/usr/bin/env python3
"""Serve THE MOST DIVERSITY in your browser. Default: http://127.0.0.1:8765"""
from __future__ import annotations

import argparse
import json
import mimetypes
import os
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from urllib.parse import unquote

ROOT = Path(__file__).resolve().parent.parent
WEB = ROOT / "web"
SKIP_DIRS = {".git", ".vs", "node_modules", "__pycache__", "x64", "x86", "Debug", "Release"}
TEXT_EXTENSIONS = {
    ".py", ".js", ".ts", ".json", ".md", ".txt", ".html", ".css", ".xml", ".yaml", ".yml",
    ".toml", ".ini", ".csv", ".sql", ".sh", ".ps1", ".bat", ".c", ".cpp", ".h", ".rs", ".go",
    ".java", ".rb", ".php", ".lua", ".pl", ".r", ".properties", ".graphql", ".gql", ".rq",
    ".bf", ".wat", ".v", ".vhdl", ".erl", ".exs", ".clj", ".hs", ".fs", ".ml", ".scm",
    ".proto", ".dockerfile", ".tf", ".bicep", ".gradle", ".kts", ".vcxproj", ".sln", ".filters",
}


def build_catalog() -> dict:
    categories: dict[str, list[dict]] = {}
    for entry in sorted(ROOT.iterdir(), key=lambda p: p.name.lower()):
        if not entry.is_dir() or entry.name in SKIP_DIRS or entry.name == "web":
            continue
        files: list[dict] = []
        for path in sorted(entry.rglob("*")):
            if not path.is_file():
                continue
            rel = path.relative_to(ROOT).as_posix()
            if any(part in SKIP_DIRS for part in path.parts):
                continue
            files.append({
                "path": rel,
                "name": path.name,
                "size": path.stat().st_size,
            })
        if files:
            categories[entry.name] = files

    index_path = ROOT / "DIVERSITY_INDEX.json"
    stats = {}
    if index_path.is_file():
        try:
            stats = json.loads(index_path.read_text(encoding="utf-8"))
        except json.JSONDecodeError:
            stats = {}

    return {
        "root": str(ROOT),
        "stats": stats,
        "categories": categories,
        "total_files": sum(len(v) for v in categories.values()),
    }


class MuseumHandler(SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=str(ROOT), **kwargs)

    def log_message(self, fmt: str, *args) -> None:
        print(f"[museum] {self.address_string()} - {fmt % args}")

    def do_GET(self) -> None:
        path = unquote(self.path.split("?", 1)[0])
        if path in ("/", "/index.html"):
            self._serve_file(WEB / "index.html", "text/html; charset=utf-8")
            return
        if path.startswith("/web/"):
            rel = path[1:]
            target = ROOT / rel
            if target.is_file():
                ctype = mimetypes.guess_type(str(target))[0] or "application/octet-stream"
                self._serve_file(target, ctype)
                return
        if path == "/api/catalog":
            data = json.dumps(build_catalog(), ensure_ascii=False).encode("utf-8")
            self.send_response(200)
            self.send_header("Content-Type", "application/json; charset=utf-8")
            self.send_header("Content-Length", str(len(data)))
            self.end_headers()
            self.wfile.write(data)
            return
        if path.startswith("/api/file/"):
            rel = path[len("/api/file/") :]
            target = (ROOT / rel).resolve()
            if not str(target).startswith(str(ROOT.resolve())):
                self.send_error(403, "Forbidden")
                return
            if not target.is_file():
                self.send_error(404, "Not found")
                return
            ext = target.suffix.lower()
            if ext not in TEXT_EXTENSIONS and ext != "":
                self.send_error(415, "Binary or unsupported file — open from disk")
                return
            try:
                text = target.read_text(encoding="utf-8")
            except UnicodeDecodeError:
                self.send_error(415, "Not UTF-8 text")
                return
            payload = json.dumps({"path": rel, "content": text}, ensure_ascii=False).encode("utf-8")
            self.send_response(200)
            self.send_header("Content-Type", "application/json; charset=utf-8")
            self.send_header("Content-Length", str(len(payload)))
            self.end_headers()
            self.wfile.write(payload)
            return
        super().do_GET()

    def _serve_file(self, path: Path, content_type: str) -> None:
        if not path.is_file():
            self.send_error(404, "Not found")
            return
        data = path.read_bytes()
        self.send_response(200)
        self.send_header("Content-Type", content_type)
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)


def main() -> None:
    parser = argparse.ArgumentParser(description="Museum web server")
    parser.add_argument("--host", default="127.0.0.1")
    parser.add_argument("--port", type=int, default=8765)
    args = parser.parse_args()

    os.chdir(ROOT)
    server = ThreadingHTTPServer((args.host, args.port), MuseumHandler)
    url = f"http://{args.host}:{args.port}/"
    print()
    print("  THE MOST DIVERSITY — web museum")
    print(f"  Open in your browser: {url}")
    print("  Press Ctrl+C to stop")
    print()
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\nStopped.")
        server.server_close()


if __name__ == "__main__":
    main()
