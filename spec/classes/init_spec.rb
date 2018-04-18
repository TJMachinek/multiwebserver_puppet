require 'spec_helper'
describe 'multiwebserver' do
  context 'with default values for all parameters' do
    it { should contain_class('multiwebserver') }
  end
end
