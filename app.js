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
