const list = document.querySelector("#post-list");
const search = document.querySelector("#search");
let posts = [];

async function loadPosts() {
  const res = await fetch("/api/posts");
  posts = await res.json();
  render();
}

function escapeHtml(str) {
  if (!str) return "";
  return str
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#039;");
}

function render() {
  const q = (search.value || "").toLowerCase();

  const filtered = posts.filter(function (post) {
    var text = (post.title + " " + post.category + " " + post.excerpt + " " + post.content).toLowerCase();
    return text.indexOf(q) !== -1;
  });

  if (filtered.length === 0) {
    list.innerHTML = "<p class='muted'>No posts found.</p>";
    return;
  }

  var html = "";
  for (var i = 0; i < filtered.length; i++) {
    var post = filtered[i];
    html += '<article class="card">';
    html += '<div class="tag">' + escapeHtml(post.category || "IT 372") + '</div>';
    html += '<a href="/post.html?id=' + encodeURIComponent(post.id) + '">';
    html += '<h3>' + escapeHtml(post.title) + '</h3>';
    html += '</a>';
    html += '<p>' + escapeHtml(post.excerpt || "") + '</p>';
    html += '<div class="meta">' + escapeHtml(post.date || "") + ' &middot; ';
    html += '<a href="/post.html?id=' + encodeURIComponent(post.id) + '">Read more</a>';
    html += '</div>';
    html += '</article>';
  }

  list.innerHTML = html;
}

search.addEventListener("input", render);

loadPosts().catch(function () {
  list.innerHTML = "<p class='error'>Could not load posts.</p>";
});
