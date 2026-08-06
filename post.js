var root = document.querySelector("#post");
var params = new URLSearchParams(location.search);
var id = params.get("id");

function escapeHtml(str) {
  if (!str) return "";
  return str
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#039;");
}

(async function () {
  var res = await fetch("/api/posts");
  var posts = await res.json();

  var post = null;
  for (var i = 0; i < posts.length; i++) {
    if (String(posts[i].id) === String(id)) {
      post = posts[i];
      break;
    }
  }

  if (!post) {
    root.innerHTML = "<h1>Post not found</h1>";
    return;
  }

  document.title = post.title;

  var html = "";
  html += '<div class="tag">' + escapeHtml(post.category || "General") + '</div>';
  html += '<h1>' + escapeHtml(post.title) + '</h1>';
  html += '<p class="meta">' + escapeHtml(post.date || "") + '</p>';
  html += '<div class="post-content">' + marked.parse(post.content || "") + '</div>';

  root.innerHTML = html;
})().catch(function () {
  root.innerHTML = "<p class='error'>Could not load post.</p>";
});