class Queries {
  String readRepositories = """
    query Flutter_Github_GraphQL{
            user(login: "joshuafriso") {
                avatarUrl(size: 200)
                location
                name
                url
                email
                login
                repositories {
                  totalCount
                }
                followers {
                  totalCount
                }
                following {
                  totalCount
                }
              }
      viewer {
              starredRepositories(last: 12) {
                edges {
                  node {
                    id
                    name
                    nameWithOwner
                  }
                }
              }
            }
          }
      """;
}
