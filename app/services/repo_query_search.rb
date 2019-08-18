class RepoQuerySearch < RepoBaseSearch
  def initialize(query, per_page: 15)
    super()
    @query = query
    @per_page = per_page
  end

  def request
    connection.get do |req|
      req.url REPOS_SEARCH, {
        q: @query, 
        client_id: github_client_id, 
        client_secret: github_client_secret,
        per_page: @per_page,
      }
      req.headers['Accept'] = 'application/vnd.github.v3+json'
    end
  end
end
