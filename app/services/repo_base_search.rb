class RepoBaseSearch
  GITHUB_PATH = 'https://api.github.com/search/repositories'.freeze
  REPOS_SEARCH = '/search/repositories'.freeze

  def call
    response = request
    [response.body['items'], parse_links(response)]
  end

  protected

  def request
    rails NotImplementedError
  end

  private

  def connection
    @connection ||= Faraday.new(url: GITHUB_PATH) do |faraday|
      faraday.response :json
      faraday.adapter Faraday.default_adapter
    end
  end

  def github_client_id
    @github_client_id ||= Rails.application.credentials.dig(:github_client_id)
  end

  def github_client_secret
    @github_client_secret ||= Rails.application.credentials.dig(:github_client_secret)
  end

  def parse_links(response)
    return {} unless response.headers.key?("link")

    parts = response.headers["link"].split(',')
    parts.each_with_object({}) do |part, links|
      section = part.split(';')
      url = section[0][/<(.*)>/,1]
      name = section[1][/rel="(.*)"/,1].to_sym
      links[name] = url
    end
  end
end
