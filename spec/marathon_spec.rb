# frozen_string_literal: true

RSpec.describe Marathon do
  it 'has a version number' do
    expect(Marathon::VERSION).not_to be nil
  end
end
