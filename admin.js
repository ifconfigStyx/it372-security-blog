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
