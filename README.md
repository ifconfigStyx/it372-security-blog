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
