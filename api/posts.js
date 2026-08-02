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
