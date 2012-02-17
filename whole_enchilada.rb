require 'roo'
require 'optparse'
require 'rest_client'
require 'json'

class WholeEnchilada
  
  def initialize(file_path)
    parse file_path
  end
  
  def users
    @users
  end
  
  def parse (spreadsheet)
    @users = []
    @sheet = Excel.new(spreadsheet)
    @sheet.default_sheet = @sheet.sheets.first
    2.upto(@sheet.last_row) do |row|
      @users << App47User.new(@sheet.cell(row, 'A'), @sheet.cell(row, 'B'), @sheet.cell(row, 'C'))
    end
  end
  
end

class App47Client
  
  @@url = "https://cirrus.app47.com"
  
  def initialize(api_token)
    @api_token = api_token
  end
  
  def post(users)
    
    users.each do | user |
      json = { :user => { :name => user.name, :email => user.email, :auto_aproved => user.auto_approve }}.to_json
       response = RestClient.post @@url + "/api/users", json, {"X-Token"=> @api_token, :accept => :json, :content_type => :json}
       if response.code == 201
         puts "#{user.name} was successfully created"
       else
         puts "There seems to have been a problem creating #{user.name}'s record in the App47 system. The response from App47 is: "
         puts response.to_s
       end
    end
    
  end
  
end

class App47User
  attr_accessor :name, :email, :auto_approve 
  
  def initialize(name, email, auto_approve)
    @name = name
    @email = email
    @auto_approve = auto_approve
  end
    
  def to_s
    "#{name} #{email} #{auto_approve}"
  end  
    
end


if __FILE__ == $0
  options = {}
  OptionParser.new do |opts|
    opts.on("-f", "--require INPUT FILE", "Excel File") do | fle |
     options[:file] = fle
    end  
    opts.on("-t", "--require TOKEN", "Require App47 Client Token") do | tkn |
      options[:token] = tkn
    end
  end.parse!
  
  raise "You must provide an input file" if options[:file].nil?
  raise "You must provide your App47 account API token" if options[:token].nil?
  
  enchilada = WholeEnchilada.new(options[:file])
  
  client = App47Client.new(options[:token])
  client.post(enchilada.users)
  
end