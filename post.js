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
