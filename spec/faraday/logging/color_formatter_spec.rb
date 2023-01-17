# frozen_string_literal: true

RSpec.describe Faraday::Logging::ColorFormatter do
  let(:log)    { StringIO.new }
  let(:logger) { Logger.new(log) }

  let(:stubs) do
    Faraday::Adapter::Test::Stubs.new do |stub|
      stub.get('/ebi')      { [200, { 'Content-Type' => 'text/plain' }, 'shrimp'] }
      stub.get('/tamago')   { [200, { 'Content-Type' => 'text/plain' }, 'egg'] }
      stub.post('/kohada')  { [200, { 'Content-Type' => 'application/json' }, '{"description":"spotted gizzard shad"}'] }
      stub.patch('/anago')  { [200, { 'Content-Type' => 'application/json' }, '{"desciption":"saltwater eel"}'] }
      stub.put('/anago')    { [200, { 'Content-Type' => 'application/json' }, '{"desciption":"saltwater eel"}'] }
      stub.delete('/ikura') { [200, { 'Content-Type' => 'text/plain' }, 'salmon roe'] }
      stub.get('/goma')     { [100, { 'Content-Type' => 'text/plain' }, 'sesame seeds'] }
      stub.get('/amaebi')   { [200, { 'Content-Type' => 'text/plain' }, 'sweet shrimp'] }
      stub.get('/kani')     { [300, { 'Content-Type' => 'text/plain' }, 'cooked crab meat'] }
      stub.get('/sake')     { [400, { 'Content-Type' => 'text/plain' }, 'salmon'] }
      stub.get('/kaiso')    { [500, { 'Content-Type' => 'text/plain' }, 'seaweed'] }
    end
  end

  let(:connection) do
    Faraday.new(url: 'http://sushi.com') do |builder|
      builder.response(:logger, logger, formatter: described_class)
      builder.adapter(:test, stubs)
    end
  end

  it 'has a version number' do
    expect(described_class::VERSION).not_to be_nil
  end

  it 'new returns an insance of Faraday::Logging::ColorFormatter::Formatter' do
    expect(described_class.new(logger: logger, options: {})).to be_a(Faraday::Logging::ColorFormatter::Formatter)
  end

  it 'includes the request term' do
    connection.get('/ebi')
    log.rewind
    expect(log.read).to include("\e[34mHTTP Request\e[0m")
  end

  it 'formats GET requests in blue' do
    connection.get('/tamago')
    log.rewind
    expect(log.read).to include("\e[34mGET http://sushi.com/tamago\e[0m")
  end

  it 'formats POST requests in green' do
    connection.post('/kohada')
    log.rewind
    expect(log.read).to include("\e[32mPOST http://sushi.com/kohada\e[0m")
  end

  it 'formats PATCH requests in yellow' do
    connection.patch('/anago')
    log.rewind
    expect(log.read).to include("\e[33mPATCH http://sushi.com/anago\e[0m")
  end

  it 'formats PUT requests in yellow' do
    connection.put('/anago')
    log.rewind
    expect(log.read).to include("\e[33mPUT http://sushi.com/anago\e[0m")
  end

  it 'formats DELETE requests in red' do
    connection.delete('/ikura')
    log.rewind
    expect(log.read).to include("\e[31mDELETE http://sushi.com/ikura\e[0m")
  end

  it 'includes the response term' do
    connection.get('/ebi')
    log.rewind
    expect(log.read).to include("\e[34mHTTP Response\e[0m")
  end

  it 'formats 1XX responses in blue' do
    connection.get('/goma')
    log.rewind
    expect(log.read).to include("\e[34mStatus 100\e[0m")
  end

  it 'formats 2XX responses in green' do
    connection.get('/amaebi')
    log.rewind
    expect(log.read).to include("\e[32mStatus 200\e[0m")
  end

  it 'formats 3XX responses in yellow' do
    connection.get('/kani')
    log.rewind
    expect(log.read).to include("\e[33mStatus 300\e[0m")
  end

  it 'formats 4XX responses in red' do
    connection.get('/sake')
    log.rewind
    expect(log.read).to include("\e[31mStatus 400\e[0m")
  end

  it 'formats 5XX responses in red' do
    connection.get('/kaiso')
    log.rewind
    expect(log.read).to include("\e[31mStatus 500\e[0m")
  end
end
