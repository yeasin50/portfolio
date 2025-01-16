part of 'git_user_info.dart';

@Deprecated("gonna drop this. too much dependency")
class GithubGraphQuery {
  GithubGraphQuery([this.query = _userInfo]);
  final String query;

  /// viewer instance
  static const String _userInfo = """
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

  GithubGraphQuery contributionCollection() {
    const String contribution = """
      viewer {
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
    return GithubGraphQuery("$query\n$contribution");
  }

  GithubGraphQuery getTopRep({required String userId, int limit = 10}) {
    final String topUserStaredRepo = """
    user(login: "$userId") {
        gists{
            totalCount 
        } 
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
        }
""";

    return GithubGraphQuery("$query\n$topUserStaredRepo");
  }

  @override
  String toString() => 'GithubGraphQuery(query: $query)';
}
