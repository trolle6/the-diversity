const $ = (sel) => document.querySelector(sel);

let catalog = null;
let activeCategory = null;

async function loadCatalog() {
  const res = await fetch("/api/catalog");
  if (!res.ok) throw new Error("Failed to load catalog");
  catalog = await res.json();
  renderStats();
  renderCategories();
  $("#footer-port").textContent = window.location.origin;
}

function renderStats() {
  const total = catalog.total_files ?? 0;
  const langs = catalog.stats?.programming_languages ?? "—";
  const el = $("#stats");
  el.innerHTML = `
    <span class="stat-pill">${total} files browsable</span>
    <span class="stat-pill">${Object.keys(catalog.categories).length} categories</span>
    <span class="stat-pill">~${langs} language samples</span>
  `;
}

function renderCategories(filter = "") {
  const nav = $("#categories");
  nav.innerHTML = "";
  const q = filter.trim().toLowerCase();

  for (const [name, files] of Object.entries(catalog.categories)) {
    const visible = !q || name.toLowerCase().includes(q) ||
      files.some((f) => f.path.toLowerCase().includes(q));
    if (!visible) continue;

    const btn = document.createElement("button");
    btn.type = "button";
    btn.className = "cat-btn" + (name === activeCategory ? " active" : "");
    btn.innerHTML = `${name}<span class="cat-count">(${files.length})</span>`;
    btn.addEventListener("click", () => selectCategory(name, q));
    nav.appendChild(btn);
  }
}

function selectCategory(name, filter = "") {
  activeCategory = name;
  renderCategories(filter);
  const files = catalog.categories[name];
  const q = filter.trim().toLowerCase();
  const list = q
    ? files.filter((f) => f.path.toLowerCase().includes(q) || f.name.toLowerCase().includes(q))
    : files;

  $("#category-title").textContent = name;
  const ul = $("#files");
  ul.innerHTML = "";
  for (const f of list) {
    const li = document.createElement("li");
    const btn = document.createElement("button");
    btn.type = "button";
    btn.textContent = f.path;
    btn.addEventListener("click", () => openFile(f.path));
    li.appendChild(btn);
    ul.appendChild(li);
  }

  $("#welcome").classList.add("hidden");
  $("#viewer").classList.add("hidden");
  $("#file-list").classList.remove("hidden");
}

async function openFile(path) {
  const res = await fetch("/api/file/" + encodeURI(path));
  if (!res.ok) {
    const msg = res.status === 415 ? "This file type is not shown in the browser." : "Could not open file.";
    alert(msg);
    return;
  }
  const data = await res.json();
  $("#viewer-path").textContent = data.path;
  $("#viewer-content").querySelector("code").textContent = data.content;
  $("#file-list").classList.add("hidden");
  $("#viewer").classList.remove("hidden");
}

$("#close-viewer").addEventListener("click", () => {
  $("#viewer").classList.add("hidden");
  $("#file-list").classList.remove("hidden");
});

$("#search").addEventListener("input", (e) => {
  const q = e.target.value;
  renderCategories(q);
  if (activeCategory && catalog.categories[activeCategory]) {
    selectCategory(activeCategory, q);
  }
});

loadCatalog().catch((err) => {
  $("#stats").textContent = "Could not load museum: " + err.message;
});
