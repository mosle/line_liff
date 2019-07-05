require 'webmock/rspec'


LIFF_CONTENT = <<"EOS"
{
  "view":{
    "type":"compact",
    "url":"https://example.com"
  },
  "description":"test title of any",
  "features":{
    "bre":false
  }
}
EOS

LIFF_LIST_CONTENT = <<"EOS"
{
  "apps": [
    #{LIFF_CONTENT}
  ]
}
EOS

WebMock.allow_net_connect!

RSpec.describe LineLiff do
  it "has a version number" do
    expect(LineLiff::VERSION).not_to be nil
  end

#  it "does something useful" do
#    expect(false).to eq(true)
#  end
end

#describe Line::Bot::LiffClient do
RSpec.describe Line::Bot::LiffClient  do
  let(:client) do
    dummy_config = {
      channel_token: 'access token',
    }
    Line::Bot::LiffClient.new do |config|
      config.channel_token = dummy_config[:channel_token]
    end
  end

  it "can make liff api instance" do
    o = Line::Bot::LiffClient.create_by_line_bot_client Line::Bot::Client.new{|config|
      config.channel_token = client.channel_token
    }
    expect(o).to be_an_instance_of(Line::Bot::LiffClient)
    expect(o.channel_token).to eq client.channel_token
  end

  it 'gets a list of liff' do
    uri_template = Addressable::Template.new Line::Bot::LiffClient.default_endpoint + ''
    stub_request(:get, uri_template).to_return(body: LIFF_LIST_CONTENT, status: 200)

    response = client.get_liffs
    expect(WebMock).to have_requested(:get, Line::Bot::LiffClient.default_endpoint + '')
    expect(response.body).to eq LIFF_LIST_CONTENT
  end

  it 'creates a liff' do
    uri_template = Addressable::Template.new Line::Bot::LiffClient.default_endpoint
    stub_request(:post, uri_template).to_return(body: LIFF_CONTENT, status: 200)

    content = JSON.parse(LIFF_CONTENT)
    
    client.create_liff content["view"]["type"],content["view"]["url"],content["description"],content["features"]
    expect(WebMock).to have_requested(:post, Line::Bot::LiffClient.default_endpoint)
      .with(body: JSON.parse(LIFF_CONTENT).to_json)
  end

  it 'deletes a liff' do
    uri_template = Addressable::Template.new Line::Bot::LiffClient.default_endpoint + '/id-of-any'
    stub_request(:delete, uri_template).to_return(body: '{}', status: 200)

    client.delete_liff('id-of-any')
    expect(WebMock).to have_requested(:delete, Line::Bot::LiffClient.default_endpoint + '/id-of-any')
  end

  it 'updates a liff' do
    uri_template = Addressable::Template.new Line::Bot::LiffClient.default_endpoint + '/id-of-any'
    stub_request(:delete, uri_template).to_return(body: '{}', status: 200)

    content = JSON.parse(LIFF_CONTENT)

    client.update_liff 'id-of-any',content["view"]["type"],content["view"]["url"],content["description"],content["features"]
    expect(WebMock).to have_requested(:put, Line::Bot::LiffClient.default_endpoint + '/id-of-any')
  end

end
