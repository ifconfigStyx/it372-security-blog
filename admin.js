var loginPanel = document.querySelector("#login-panel");
var editorPanel = document.querySelector("#editor-panel");
var loginForm = document.querySelector("#login-form");
var loginError = document.querySelector("#login-error");
var manager = document.querySelector("#post-manager");
var editor = document.querySelector("#editor");
var idEl = document.querySelector("#post-id");
var titleEl = document.querySelector("#title");
var categoryEl = document.querySelector("#category");
var dateEl = document.querySelector("#date");
var excerptEl = document.querySelector("#excerpt");
var contentEl = document.querySelector("#content");
var statusEl = document.querySelector("#save-status");
var posts = [];

function escapeHtml(str) {
  if (!str) return "";
  return str
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#039;");
}

// helper for api calls
async function api(url, opts) {
  opts = opts || {};
  opts.headers = opts.headers || {};
  opts.headers["Content-Type"] = "application/json";

  var res = await fetch(url, opts);
  var data = {};
  try { data = await res.json(); } catch (e) {}

  if (!res.ok) {
    throw new Error(data.error || "Request failed.");
  }
  return data;
}

// load post list into sidebar
async function refresh() {
  posts = await api("/api/posts");

  if (posts.length === 0) {
    manager.innerHTML = "<p class='muted'>No posts yet.</p>";
    return;
  }

  var html = "";
  for (var i = 0; i < posts.length; i++) {
    html += '<div class="post-item" data-id="' + escapeHtml(String(posts[i].id)) + '">';
    html += '<strong>' + escapeHtml(posts[i].title) + '</strong>';
    html += '<small>' + escapeHtml(posts[i].date || "") + '</small>';
    html += '</div>';
  }
  manager.innerHTML = html;

  // add click handlers
  var items = manager.querySelectorAll(".post-item");
  for (var j = 0; j < items.length; j++) {
    (function (item) {
      item.onclick = function () {
        for (var k = 0; k < posts.length; k++) {
          if (String(posts[k].id) === item.dataset.id) {
            edit(posts[k]);
            break;
          }
        }
      };
    })(items[j]);
  }
}

// fill form with post data
function edit(post) {
  idEl.value = post ? post.id : "";
  titleEl.value = post ? post.title : "";
  categoryEl.value = post ? (post.category || "Information Security") : "Information Security";
  dateEl.value = post ? post.date : new Date().toISOString().slice(0, 10);
  excerptEl.value = post ? (post.excerpt || "") : "";
  contentEl.value = post ? (post.content || "") : "";
  statusEl.textContent = "";
}

// login
loginForm.onsubmit = async function (e) {
  e.preventDefault();
  loginError.textContent = "";

  try {
    await api("/api/login", {
      method: "POST",
      body: JSON.stringify({ password: document.querySelector("#password").value })
    });

    loginPanel.classList.add("hidden");
    editorPanel.classList.remove("hidden");
    await refresh();
    edit(null);
  } catch (err) {
    loginError.textContent = err.message;
  }
};

// logout
document.querySelector("#logout").onclick = async function () {
  try { await api("/api/login", { method: "DELETE" }); } catch (e) {}
  location.reload();
};

// new post button
document.querySelector("#new-post").onclick = function () {
  edit(null);
};

// save post
editor.onsubmit = async function (e) {
  e.preventDefault();
  statusEl.textContent = "Saving...";

  var payload = {
    id: idEl.value || undefined,
    title: titleEl.value,
    category: categoryEl.value,
    date: dateEl.value,
    excerpt: excerptEl.value,
    content: contentEl.value
  };

  try {
    await api("/api/posts", {
      method: "POST",
      body: JSON.stringify(payload)
    });
    statusEl.textContent = "Saved.";
    await refresh();
    edit(null);
  } catch (err) {
    statusEl.textContent = err.message;
  }
};

// delete post
document.querySelector("#delete").onclick = async function () {
  if (!idEl.value) return;
  if (!confirm("Delete this post?")) return;

  statusEl.textContent = "Deleting...";

  try {
    await api("/api/posts", {
      method: "DELETE",
      body: JSON.stringify({ id: idEl.value })
    });
    statusEl.textContent = "Deleted.";
    await refresh();
    edit(null);
  } catch (err) {
    statusEl.textContent = err.message;
  }
};
