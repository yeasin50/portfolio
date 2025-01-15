part of 'git_user_info.dart';

class GithubGraphQuery {
  GithubGraphQuery(this.query);
  final String query;

  GithubGraphQuery addUserInfo() {
    /// viewer instance
    const String userInfo = """
   viewer {
        name
        email
        url
        bio
        avatarUrl
        followers {
            totalCount
        }
        following {
            totalCount
        }
        location
        status {
            message
            emoji
        }
        isHireable
        createdAt
    }
""";

    return GithubGraphQuery(query + userInfo);
  }

  GithubGraphQuery contributionCollection() {
    const String contribution = """
 viewer{
        contributionsCollection {
            endedAt
            hasActivityInThePast
            hasAnyContributions
            hasAnyRestrictedContributions
            isSingleDay
            latestRestrictedContributionDate
            restrictedContributionsCount
            startedAt
            totalCommitContributions
            totalIssueContributions
            totalPullRequestContributions
            totalPullRequestReviewContributions
            totalRepositoriesWithContributedCommits
            totalRepositoriesWithContributedIssues
            totalRepositoriesWithContributedPullRequestReviews
            totalRepositoriesWithContributedPullRequests
            totalRepositoryContributions
        }
    }
""";
    return GithubGraphQuery(query + contribution);
  }

  GithubGraphQuery getTopRep({required String userId, int limit = 10}) {
    final String topUserStaredRepo = """
 repositories(first: $limit, orderBy: { field: STARGAZERS, direction: DESC }) {
            totalCount,
            nodes {
                name
                description
                forkCount
                isPrivate
                createdAt
                updatedAt
                stargazerCount
                url
                languages(first: 5) {
                    totalCount
                    nodes {
                        name
                        color
                    }
                }
            }
        }
""";

    return GithubGraphQuery(query + topUserStaredRepo);
  }
}
