require 'bundler/setup'
require 'test/unit'
require 'roo'
require 'shoulda/context'
require File.expand_path(File.dirname(__FILE__) + '/../whole_enchilada')

class WholeEnchiladaParsingTest < Test::Unit::TestCase

  context 'WholeEnchilada should be able to parse Excel files following a specific format' do
    setup do
      @enchilada = WholeEnchilada.new('./etc/users.xls')
    end
    
    should 'return a collection of 3 user objects' do
      assert_equal 3, @enchilada.users.size
    end
    
    should 'return a collection of 3 user objects, all with valid properties' do
      @enchilada.users.each do | usr |
        assert_not_nil usr.name, 'name was nil?'
        assert_not_nil usr.email, 'email address was nil?'
        assert_not_nil usr.auto_approve, 'auto_approve was nil?'
        assert_not_nil usr.group, 'user group was nil?'
      end
    end
    
    should 'return a collection of 2 group names' do
      assert_equal 2, @enchilada.groups.size, 'groups does not have 2?'
    end
    
  end
end