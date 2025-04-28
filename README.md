# Let's make the portfolio

[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos)

## RUN

**Local server**

- you can run on local from [main_dev.dart](./apps/portfolio_yeasin/lib/main_dev.dart) but
  - make sure to run the server `make server` will do the job.
  - then run web-app with `make dev`, it will give you localhost url to see the output.

**Production**

- you can run on local from [main_prod.dart](./apps/portfolio_yeasin/lib/main_prod.dart).
  - It fetch data from github resources.

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
