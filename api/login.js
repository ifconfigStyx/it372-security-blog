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
