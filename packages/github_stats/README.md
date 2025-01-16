# Get Github user's info

<s>Get the token from</s> not using graphql

> settings > Developer Setting > Personal access tokens > Generate new token

- Provide a token name
- Expiration > No expiration (Because we want it forever )
- little scroll; `user` > [x] read:user

You can also provide access to the private repository,

> Dropped GraphQL support; http is much faster and less heavy
> There are good limitation on rest, not sure will add more; will check later

## Features

- [x] Get user profile
  - [x] public repo, gist, followers
- [ ] specific repo's insight
- [ ] git graph
<!-- - [ ] limited total starts to the first 100 for single query -->
