require 'minitest/spec'

describe_recipe 'mozilla-firefox-accounts::fxa-auth-server' do
    it 'creates motd.tail' do
        file('/etc/motd.tail').must_exist
    end
end

