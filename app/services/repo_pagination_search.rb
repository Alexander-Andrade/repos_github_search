class RepoPaginationSearch < RepoBaseSearch
  def initialize(url)
    super()
    @url = url
  end

  def request
    connection.get do |req|
      req.url @url
      req.headers['Accept'] = 'application/vnd.github.v3+json'
    end
  end
end
