# Let's make the portfolio

[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos)

## To build your portfolio

- fork the repo
- change the database inside [server](./server/database/)
- add `COMMIT_SECRET` to your repository environment
  - Repository read and write access
- play/update inside `dev` branch
- Once modification is done,
  - make a pull request to the master branch(your forked)
  - Merge the PR
  - Check actions and it will be live on github page

## Server docs

- [user_info json structure](./server/docs/user_info.md)
- [project json structure](./server/docs/project.md)
- [connect_option json structure](./server/docs/connect_option.md.md)
