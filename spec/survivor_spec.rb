require 'rspec'
require_relative '../me'

describe Me::Survivor do
  let(:radio) { Radio.new }
  subject { described_class.new radio }

  it "can identify parent heartbeats" do
    expect(subject.send :heartbeat, 'parent').to be true
    expect(subject.send :heartbeat, 'other').to be false
  end

end
