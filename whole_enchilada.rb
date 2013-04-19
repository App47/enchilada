require 'roo'
require 'optparse'
require 'rest_client'
require 'json'
require 'iconv'

class WholeEnchilada
  
  def initialize(file_path)
    parse file_path
  end
  
  def groups
    @groups.compact.uniq
  end
  
  def users
    @users
  end
  
  def parse (spreadsheet)
    @users = []
    @groups = []
    sheet = Excel.new(spreadsheet)
    sheet.default_sheet = sheet.sheets.first
    2.upto(sheet.last_row) do |row|
      group = sheet.cell(row, 'C')
      @groups << group
      @users << App47User.new(sheet.cell(row, 'A'), sheet.cell(row, 'B'), group, sheet.cell(row, 'D'), sheet.cell(row, 'E')) 
    end
  end
  
end

class App47Client
  
  @@url = 'https://cirrus.app47.com'
  # @@url = 'http://0.0.0.0:3000'
  
  def initialize(api_token)
    @api_token = api_token
  end
  
  def post(groups, users)
    group_map = {}
    groups.each do | group |
      json = { :group => { :name => group }}.to_json
      req_hash = {'X-Token' => @api_token, :accept => :json, :content_type => :json}
      RestClient.post(@@url + '/api/groups', json, req_hash) { |response, request, result| group_map[group] = extract_group_id response }
    end

    users.each do | user |
      json = { :user => { :name => user.name, :email => user.email, :auto_aproved => user.auto_approve, 
        :group_ids => [group_map[user.group]], :default_passphrase_expiration => user.password_expire }}.to_json
      req_hash = {'X-Token' => @api_token, :accept => :json, :content_type => :json}
      RestClient.post(@@url + '/api/users', json, req_hash) { |response, request, result| handle_user_response response }      
    end
  end
  
  def handle_user_response(response)
    json = JSON.parse(response)
    if response.code == 201
      puts "#{json['name']} was created"
    elsif response.code == 409
      puts "#{json['name']} with an email address of #{json['email']} already exists"
    end
  end
  
  def extract_group_id(response)
    json = JSON.parse(response)
    json['_id']
  end
  
end #end App47Client

class App47User
  attr_accessor :name, :email, :auto_approve, :group, :password_expire 
  
  def initialize(name, email, group, auto_approve, password_expire = 48)
    @name = name
    @email = email
    @group = group
    @auto_approve = auto_approve
    @password_expire = password_expire
  end
    
  def to_s
    "#{name} #{email} #{group} #{auto_approve} #{password_expire}"
  end  
    
end


if __FILE__ == $0
  options = {}
  OptionParser.new do |opts|
    opts.on('-f', '--require INPUT FILE', 'Excel File') do | fle |
     options[:file] = fle
    end  
    opts.on('-t', '--require TOKEN', 'Require App47 Client Token') do | tkn |
      options[:token] = tkn
    end
  end.parse!
  
  raise 'You must provide an input file' if options[:file].nil?
  raise 'You must provide your App47 account API token' if options[:token].nil?
  
  enchilada = WholeEnchilada.new(options[:file])
  
  client = App47Client.new(options[:token])
  client.post(enchilada.groups, enchilada.users)
  
end