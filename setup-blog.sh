#!/usr/bin/env bash

set -e

echo "Creating Zero Trust Journal..."

mkdir -p api

cat > index.html <<'EOF'
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>Zero Trust Journal</title>
  <meta name="description" content="Vincent's IT 372 Information Assurance and Security blog.">
  <link rel="stylesheet" href="style.css">
</head>
<body>

<header class="site-header">
  <div class="wrap nav">
    <a class="brand" href="/">ZERO TRUST <span>JOURNAL</span></a>

    <nav>
      <a href="/">Home</a>
      <a href="#posts">Posts</a>
      <a href="/admin.html">Admin</a>
    </nav>
  </div>
</header>

<main class="wrap">

<section class="hero">
  <p class="eyebrow">IT 372 • INFORMATION ASSURANCE & SECURITY</p>

  <h1>
    Security, privacy, and the systems we trust.
  </h1>

  <p class="lead">
    A personal course blog about secure design, information assurance,
    privacy, and what happens when developers forget that software
    affects real people.
  </p>
</section>

<section id="posts">

  <div class="section-head">
    <h2>Latest posts</h2>

    <input
      id="search"
      type="search"
      placeholder="Search posts..."
      aria-label="Search posts"
    >
  </div>

  <div id="post-list" class="post-grid">
    <p class="muted">Loading posts…</p>
  </div>

</section>

</main>

<footer class="wrap footer">
  Zero Trust Journal • IT 372
</footer>

<script src="app.js"></script>

</body>
</html>
EOF


cat > post.html <<'EOF'
<!doctype html>
<html lang="en">

<head>

<meta charset="utf-8">

<meta
  name="viewport"
  content="width=device-width,initial-scale=1"
>

<title>Post — Zero Trust Journal</title>

<link rel="stylesheet" href="style.css">

</head>

<body>

<header class="site-header">

<div class="wrap nav">

<a class="brand" href="/">
ZERO TRUST <span>JOURNAL</span>
</a>

<nav>
<a href="/">Home</a>
<a href="/#posts">Posts</a>
</nav>

</div>

</header>


<main class="wrap">

<article id="post" class="post-page">

<p class="muted">
Loading…
</p>

</article>

</main>


<footer class="wrap footer">
Zero Trust Journal • IT 372
</footer>


<script src="post.js"></script>

</body>
</html>
EOF


cat > admin.html <<'EOF'
<!doctype html>
<html lang="en">

<head>

<meta charset="utf-8">

<meta
  name="viewport"
  content="width=device-width,initial-scale=1"
>

<title>Admin — Zero Trust Journal</title>

<link rel="stylesheet" href="style.css">

</head>


<body>

<header class="site-header">

<div class="wrap nav">

<a class="brand" href="/">
ZERO TRUST <span>JOURNAL</span>
</a>

<nav>
<a href="/">View blog</a>
</nav>

</div>

</header>


<main class="wrap admin">


<section id="login-panel" class="panel">

<p class="eyebrow">
PRIVATE AREA
</p>

<h1>
Admin
</h1>

<p class="muted">
Only you should use this page.
</p>


<form id="login-form">

<label>
Password

<input
id="password"
type="password"
required
autocomplete="current-password"
>

</label>


<button>
Sign in
</button>


<p
id="login-error"
class="error"
></p>

</form>

</section>



<section
id="editor-panel"
class="hidden"
>


<div class="section-head">

<div>

<p class="eyebrow">
POST MANAGER
</p>

<h1>
Manage posts
</h1>

</div>


<div class="actions">

<button id="new-post">
New post
</button>

<button
id="logout"
class="secondary"
>
Log out
</button>

</div>

</div>



<div class="admin-layout">


<aside
id="post-manager"
class="panel"
>
</aside>


<form
id="editor"
class="panel"
>


<input
id="post-id"
type="hidden"
>


<label>

Title

<input
id="title"
required
maxlength="180"
>

</label>


<div class="two">


<label>

Category

<input
id="category"
maxlength="80"
placeholder="Information Security"
>

</label>


<label>

Date

<input
id="date"
type="date"
required
>

</label>


</div>


<label>

Excerpt

<textarea
id="excerpt"
rows="3"
maxlength="400"
></textarea>

</label>


<label>

Content

<textarea
id="content"
rows="18"
required
placeholder="Write your post here..."
></textarea>

</label>


<div class="actions">

<button type="submit">
Save post
</button>


<button
type="button"
id="delete"
class="danger"
>
Delete
</button>

</div>


<p
id="save-status"
class="muted"
></p>


</form>

</div>

</section>

</main>


<script src="admin.js"></script>

</body>
</html>
EOF


cat > style.css <<'EOF'
* {
  box-sizing: border-box;
}

body {
  margin: 0;
  background: #0b1020;
  color: #e5e7eb;
  font-family:
    Inter,
    ui-sans-serif,
    system-ui,
    -apple-system,
    BlinkMacSystemFont,
    "Segoe UI",
    sans-serif;
  line-height: 1.7;
}

.wrap {
  width: min(1050px, calc(100% - 36px));
  margin: auto;
}

.site-header {
  border-bottom: 1px solid #20283b;
  background: #0b1020;
  position: sticky;
  top: 0;
  z-index: 5;
}

.nav {
  min-height: 70px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 20px;
}

.brand {
  color: white;
  text-decoration: none;
  font-weight: 900;
  letter-spacing: .12em;
}

.brand span {
  color: #7dd3fc;
}

.nav nav {
  display: flex;
  gap: 20px;
}

.nav nav a {
  color: #aeb8cc;
  text-decoration: none;
}

.nav nav a:hover {
  color: white;
}

.hero {
  padding: 90px 0 70px;
  max-width: 820px;
}

.eyebrow {
  color: #7dd3fc;
  font-size: .78rem;
  font-weight: 800;
  letter-spacing: .13em;
}

.hero h1 {
  font-size: clamp(2.5rem, 7vw, 5rem);
  line-height: 1.02;
  margin: 14px 0;
}

.lead {
  font-size: 1.18rem;
  color: #aeb8cc;
}

.section-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 20px;
  margin: 30px 0 18px;
}

.section-head h2 {
  margin: 0;
}

.section-head input {
  background: #11182a;
  border: 1px solid #2a344a;
  color: white;
  padding: 11px 14px;
  border-radius: 9px;
  width: 240px;
}

.post-grid {
  display: grid;
  grid-template-columns:
    repeat(auto-fit, minmax(280px, 1fr));
  gap: 18px;
}

.card,
.panel {
  background: #11182a;
  border: 1px solid #202b40;
  border-radius: 14px;
  padding: 24px;
}

.card {
  transition: .15s;
}

.card:hover {
  transform: translateY(-2px);
  border-color: #3b82f6;
}

.card a {
  color: white;
  text-decoration: none;
}

.card h3 {
  margin: 8px 0;
  font-size: 1.35rem;
  line-height: 1.3;
}

.meta,
.muted {
  color: #8995aa;
}

.tag {
  color: #7dd3fc;
  font-size: .78rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: .08em;
}

.footer {
  padding: 70px 0 35px;
  color: #657087;
}

.post-page {
  max-width: 800px;
  padding: 70px 0;
}

.post-page h1 {
  font-size: clamp(2.3rem, 6vw, 4.2rem);
  line-height: 1.08;
}

.post-content {
  white-space: pre-wrap;
  font-size: 1.08rem;
  color: #cdd5e1;
}

.admin {
  padding: 55px 0;
}

.admin h1 {
  margin-top: 0;
}

.admin-layout {
  display: grid;
  grid-template-columns: 280px 1fr;
  gap: 18px;
}

.post-item {
  padding: 12px;
  border-bottom: 1px solid #273149;
  cursor: pointer;
}

.post-item:last-child {
  border: 0;
}

.post-item:hover {
  background: #172036;
}

.post-item strong {
  display: block;
}

.post-item small {
  color: #8995aa;
}

.two {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 14px;
}

label {
  display: block;
  font-weight: 700;
  margin: 14px 0;
}

input,
textarea {
  display: block;
  width: 100%;
  margin-top: 7px;
  background: #0b1020;
  color: white;
  border: 1px solid #2a344a;
  border-radius: 8px;
  padding: 11px;
  font: inherit;
}

button {
  border: 0;
  border-radius: 8px;
  background: #38bdf8;
  color: #07111f;
  font-weight: 800;
  padding: 11px 16px;
  cursor: pointer;
}

button.secondary {
  background: #273149;
  color: #e5e7eb;
}

button.danger {
  background: #ef4444;
  color: white;
}

.actions {
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
}

.error {
  color: #fca5a5;
}

.hidden {
  display: none;
}

@media (max-width: 700px) {

  .nav {
    align-items: flex-start;
    padding: 15px 0;
    flex-direction: column;
  }

  .hero {
    padding-top: 55px;
  }

  .section-head {
    align-items: stretch;
    flex-direction: column;
  }

  .section-head input {
    width: 100%;
  }

  .admin-layout,
  .two {
    grid-template-columns: 1fr;
  }

}
EOF


cat > app.js <<'EOF'
const list = document.querySelector("#post-list");
const search = document.querySelector("#search");

let posts = [];

async function loadPosts() {

  const response = await fetch("/api/posts");

  posts = await response.json();

  render();

}

function escapeHtml(value = "") {

  return value.replace(
    /[&<>"']/g,
    character => ({
      "&": "&amp;",
      "<": "&lt;",
      ">": "&gt;",
      '"': "&quot;",
      "'": "&#039;"
    }[character])
  );

}

function render() {

  const query =
    (search.value || "").toLowerCase();

  const filtered =
    posts.filter(post =>
      `${post.title} ${post.category} ${post.excerpt} ${post.content}`
        .toLowerCase()
        .includes(query)
    );

  if (!filtered.length) {

    list.innerHTML =
      "<p class='muted'>No posts found.</p>";

    return;

  }

  list.innerHTML =
    filtered.map(post => `

      <article class="card">

        <div class="tag">
          ${escapeHtml(post.category || "IT 372")}
        </div>

        <a
          href="/post.html?id=${encodeURIComponent(post.id)}"
        >

          <h3>
            ${escapeHtml(post.title)}
          </h3>

        </a>

        <p>
          ${escapeHtml(post.excerpt || "")}
        </p>

        <div class="meta">

          ${escapeHtml(post.date || "")}

          ·

          <a
            href="/post.html?id=${encodeURIComponent(post.id)}"
          >
            Read post →
          </a>

        </div>

      </article>

    `).join("");

}

search.addEventListener("input", render);

loadPosts().catch(() => {

  list.innerHTML =
    "<p class='error'>Could not load posts.</p>";

});
EOF


cat > post.js <<'EOF'
const root =
  document.querySelector("#post");

const id =
  new URLSearchParams(location.search).get("id");

const escapeHtml = value =>
  (value || "").replace(
    /[&<>"']/g,
    character => ({
      "&": "&amp;",
      "<": "&lt;",
      ">": "&gt;",
      '"': "&quot;",
      "'": "&#039;"
    }[character])
  );


(async () => {

  const response =
    await fetch("/api/posts");

  const posts =
    await response.json();

  const post =
    posts.find(
      item => String(item.id) === String(id)
    );

  if (!post) {

    root.innerHTML =
      "<h1>Post not found</h1>";

    return;

  }

  document.title =
    `${post.title} — Zero Trust Journal`;

  root.innerHTML = `

    <div class="tag">
      ${escapeHtml(post.category || "IT 372")}
    </div>

    <h1>
      ${escapeHtml(post.title)}
    </h1>

    <p class="meta">
      ${escapeHtml(post.date || "")}
    </p>

    <div class="post-content">
      ${escapeHtml(post.content)}
    </div>

  `;

})().catch(() => {

  root.innerHTML =
    "<p class='error'>Could not load post.</p>";

});
EOF


cat > admin.js <<'EOF'
const loginPanel =
  document.querySelector("#login-panel");

const editorPanel =
  document.querySelector("#editor-panel");

const loginForm =
  document.querySelector("#login-form");

const loginError =
  document.querySelector("#login-error");

const manager =
  document.querySelector("#post-manager");

const editor =
  document.querySelector("#editor");

const idEl =
  document.querySelector("#post-id");

const titleEl =
  document.querySelector("#title");

const categoryEl =
  document.querySelector("#category");

const dateEl =
  document.querySelector("#date");

const excerptEl =
  document.querySelector("#excerpt");

const contentEl =
  document.querySelector("#content");

const statusEl =
  document.querySelector("#save-status");

let posts = [];


function escapeHtml(value = "") {

  return value.replace(
    /[&<>"']/g,
    character => ({
      "&": "&amp;",
      "<": "&lt;",
      ">": "&gt;",
      '"': "&quot;",
      "'": "&#039;"
    }[character])
  );

}


async function api(url, options = {}) {

  const response =
    await fetch(url, {

      ...options,

      headers: {

        "Content-Type":
          "application/json",

        ...(options.headers || {})

      }

    });

  let data = {};

  try {

    data = await response.json();

  } catch {}

  if (!response.ok) {

    throw new Error(
      data.error || "Request failed."
    );

  }

  return data;

}


async function refresh() {

  posts =
    await api("/api/posts");

  manager.innerHTML =
    posts.length

      ? posts.map(post => `

          <div
            class="post-item"
            data-id="${escapeHtml(String(post.id))}"
          >

            <strong>
              ${escapeHtml(post.title)}
            </strong>

            <small>
              ${escapeHtml(post.date || "")}
            </small>

          </div>

        `).join("")

      : "<p class='muted'>No posts yet.</p>";


  manager
    .querySelectorAll(".post-item")
    .forEach(item => {

      item.onclick = () => {

        const post =
          posts.find(
            post =>
              String(post.id) ===
              item.dataset.id
          );

        edit(post);

      };

    });

}


function edit(post) {

  idEl.value =
    post?.id || "";

  titleEl.value =
    post?.title || "";

  categoryEl.value =
    post?.category ||
    "Information Security";

  dateEl.value =
    post?.date ||
    new Date()
      .toISOString()
      .slice(0, 10);

  excerptEl.value =
    post?.excerpt || "";

  contentEl.value =
    post?.content || "";

  statusEl.textContent = "";

}


loginForm.onsubmit =
  async event => {

    event.preventDefault();

    loginError.textContent = "";

    try {

      await api(
        "/api/login",
        {

          method: "POST",

          body: JSON.stringify({

            password:
              document
                .querySelector("#password")
                .value

          })

        }
      );

      loginPanel
        .classList
        .add("hidden");

      editorPanel
        .classList
        .remove("hidden");

      await refresh();

      edit(null);

    } catch (error) {

      loginError.textContent =
        error.message;

    }

  };


document
  .querySelector("#logout")
  .onclick = async () => {

    await api(
      "/api/login",
      {
        method: "DELETE"
      }
    ).catch(() => {});

    location.reload();

  };


document
  .querySelector("#new-post")
  .onclick = () => {

    edit(null);

  };


editor.onsubmit =
  async event => {

    event.preventDefault();

    statusEl.textContent =
      "Saving…";

    const payload = {

      id:
        idEl.value || undefined,

      title:
        titleEl.value,

      category:
        categoryEl.value,

      date:
        dateEl.value,

      excerpt:
        excerptEl.value,

      content:
        contentEl.value

    };


    try {

      await api(
        "/api/posts",
        {

          method: "POST",

          body:
            JSON.stringify(payload)

        }
      );

      statusEl.textContent =
        "Saved to GitHub.";

      await refresh();

      edit(null);

    } catch (error) {

      statusEl.textContent =
        error.message;

    }

  };


document
  .querySelector("#delete")
  .onclick = async () => {

    if (!idEl.value)
      return;

    if (!confirm(
      "Delete this post?"
    ))
      return;

    statusEl.textContent =
      "Deleting…";

    try {

      await api(
        "/api/posts",
        {

          method: "DELETE",

          body:
            JSON.stringify({
              id: idEl.value
            })

        }
      );

      statusEl.textContent =
        "Deleted.";

      await refresh();

      edit(null);

    } catch (error) {

      statusEl.textContent =
        error.message;

    }

  };
EOF


cat > posts.json <<'EOF'
[
  {
    "id": "it372-001",
    "title": "When \"Make It Run\" Becomes a Security Incident",
    "category": "Information Assurance",
    "date": "2026-08-02",
    "excerpt": "What happens when a fast hackathon prototype becomes production software without being redesigned for security?",
    "content": "The university platform in this case shows how quickly a successful prototype can become a serious security problem.\n\nReplace this starter content with your full IT 372 blog post from your assignment."
  }
]
EOF


cat > api/login.js <<'EOF'
const crypto =
  require("crypto");


function sign(value, secret) {

  return crypto
    .createHmac("sha256", secret)
    .update(value)
    .digest("hex");

}


function createCookie(secret) {

  const payload =
    Buffer
      .from(
        JSON.stringify({
          exp:
            Date.now() +
            1000 * 60 * 60 * 24 * 7
        })
      )
      .toString("base64url");


  const signature =
    sign(payload, secret);


  return `ztj_session=${payload}.${signature}; Path=/; HttpOnly; Secure; SameSite=Lax; Max-Age=604800`;

}


function authenticated(req, secret) {

  const cookie =
    (req.headers.cookie || "")
      .split(";")
      .map(value => value.trim())
      .find(
        value =>
          value.startsWith(
            "ztj_session="
          )
      );


  if (!cookie)
    return false;


  const token =
    cookie.split("=")[1];

  const [payload, signature] =
    token.split(".");


  if (!payload || !signature)
    return false;


  try {

    const expected =
      sign(payload, secret);

    const validSignature =
      crypto.timingSafeEqual(
        Buffer.from(signature),
        Buffer.from(expected)
      );

    const data =
      JSON.parse(
        Buffer
          .from(payload, "base64url")
          .toString()
      );


    return (
      validSignature &&
      data.exp > Date.now()
    );

  } catch {

    return false;

  }

}


module.exports =
  async function handler(req, res) {

    const secret =
      process.env.SESSION_SECRET;

    const adminPassword =
      process.env.ADMIN_PASSWORD;


    if (!secret || !adminPassword) {

      return res
        .status(500)
        .json({
          error:
            "Server is not configured."
        });

    }


    if (req.method === "DELETE") {

      res.setHeader(
        "Set-Cookie",
        "ztj_session=; Path=/; HttpOnly; Secure; SameSite=Lax; Max-Age=0"
      );

      return res
        .status(200)
        .json({ ok: true });

    }


    if (req.method !== "POST") {

      return res
        .status(405)
        .json({
          error:
            "Method not allowed."
        });

    }


    const given =
      String(
        (req.body || {}).password || ""
      );


    const a =
      Buffer.from(given);

    const b =
      Buffer.from(adminPassword);


    const valid =
      a.length === b.length &&
      crypto.timingSafeEqual(
        a,
        b
      );


    if (!valid) {

      return res
        .status(401)
        .json({
          error:
            "Wrong password."
        });

    }


    res.setHeader(
      "Set-Cookie",
      createCookie(secret)
    );


    return res
      .status(200)
      .json({
        ok: true
      });

  };


module.exports.isAuthenticated =
  authenticated;
EOF


cat > api/posts.js <<'EOF'
const crypto =
  require("crypto");

const login =
  require("./login.js");


const OWNER =
  process.env.GITHUB_OWNER ||
  "ifconfigStyx";

const REPO =
  process.env.GITHUB_REPO ||
  "it372-security-blog";

const FILE =
  process.env.GITHUB_FILE ||
  "posts.json";


const API =
  `https://api.github.com/repos/${OWNER}/${REPO}/contents/${FILE}`;


function headers() {

  return {

    "Authorization":
      `Bearer ${process.env.GITHUB_TOKEN}`,

    "Accept":
      "application/vnd.github+json",

    "X-GitHub-Api-Version":
      "2022-11-28",

    "Content-Type":
      "application/json"

  };

}


async function getFile() {

  const response =
    await fetch(
      API,
      {
        headers:
          headers()
      }
    );


  if (!response.ok) {

    throw new Error(
      "Could not read GitHub storage."
    );

  }


  const data =
    await response.json();


  const content =
    data.content
      .replace(/\n/g, "");


  const text =
    Buffer
      .from(content, "base64")
      .toString("utf8");


  return {

    sha:
      data.sha,

    posts:
      JSON.parse(text)

  };

}


async function saveFile(
  posts,
  sha,
  message
) {

  const content =
    Buffer
      .from(
        JSON.stringify(
          posts,
          null,
          2
        ) + "\n"
      )
      .toString("base64");


  const response =
    await fetch(
      API,
      {

        method:
          "PUT",

        headers:
          headers(),

        body:
          JSON.stringify({

            message,

            content,

            sha,

            branch:
              "main"

          })

      }
    );


  if (!response.ok) {

    const data =
      await response
        .json()
        .catch(
          () => ({})
        );


    throw new Error(
      data.message ||
      "Could not save to GitHub."
    );

  }

}


function authorized(req) {

  return (
    process.env.SESSION_SECRET &&
    login.isAuthenticated(
      req,
      process.env.SESSION_SECRET
    )
  );

}


module.exports =
  async function handler(
    req,
    res
  ) {

    try {

      if (req.method === "GET") {

        const {
          posts
        } = await getFile();


        posts.sort(
          (a, b) =>
            String(b.date)
              .localeCompare(
                String(a.date)
              )
        );


        return res
          .status(200)
          .json(posts);

      }


      if (!authorized(req)) {

        return res
          .status(401)
          .json({
            error:
              "Not authorized."
          });

      }


      const {
        posts,
        sha
      } =
        await getFile();


      if (req.method === "POST") {

        const post =
          req.body || {};


        if (
          !post.title ||
          !post.content
        ) {

          return res
            .status(400)
            .json({
              error:
                "Title and content are required."
            });

        }


        const id =
          post.id ||
          crypto.randomUUID();


        const next = {

          id,

          title:
            String(
              post.title
            ).trim(),

          category:
            String(
              post.category ||
              "IT 372"
            ).trim(),

          date:
            String(
              post.date ||
              new Date()
                .toISOString()
                .slice(0, 10)
            ),

          excerpt:
            String(
              post.excerpt ||
              ""
            ).trim(),

          content:
            String(
              post.content
            )

        };


        const index =
          posts.findIndex(
            item =>
              String(item.id) ===
              String(id)
          );


        if (index >= 0) {

          posts[index] =
            next;

        } else {

          posts.push(next);

        }


        await saveFile(
          posts,
          sha,
          index >= 0
            ? "Edit blog post"
            : "Add blog post"
        );


        return res
          .status(200)
          .json(next);

      }


      if (
        req.method ===
        "DELETE"
      ) {

        const id =
          String(
            (req.body || {}).id ||
            ""
          );


        const next =
          posts.filter(
            post =>
              String(post.id) !==
              id
          );


        if (
          next.length ===
          posts.length
        ) {

          return res
            .status(404)
            .json({
              error:
                "Post not found."
            });

        }


        await saveFile(
          next,
          sha,
          "Delete blog post"
        );


        return res
          .status(200)
          .json({
            ok: true
          });

      }


      return res
        .status(405)
        .json({
          error:
            "Method not allowed."
        });


    } catch (error) {

      return res
        .status(500)
        .json({
          error:
            error.message ||
            "Server error."
        });

    }

  };
EOF


cat > README.md <<'EOF'
# Zero Trust Journal

A small IT 372 course blog.

## Features

- Public blog posts
- Search
- Password-protected admin editor
- Create, edit, and delete posts
- Posts stored in GitHub through the GitHub Contents API
- Deployable on Vercel

## Required Vercel environment variables

GITHUB_TOKEN
GITHUB_OWNER
GITHUB_REPO
GITHUB_FILE
ADMIN_PASSWORD
SESSION_SECRET

Never put the GitHub token in frontend JavaScript or commit it to Git.
EOF


echo
echo "======================================"
echo " Zero Trust Journal created!"
echo "======================================"
echo
echo "Files:"
find . -maxdepth 2 -type f | sort
echo
echo "Next:"
echo "  git add ."
echo "  git commit -m 'Build Zero Trust Journal blog'"
echo "  git push"
echo
