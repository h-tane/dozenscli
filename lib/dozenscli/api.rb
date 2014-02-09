require 'inifile'
require 'json'
require 'net/http'

module Dozenscli
  class API
    def initialize
      @base_url = 'http://dozens.jp'
      home = File.expand_path('~')
      conf = IniFile.load("#{home}/.dozenscli.conf")

      dozens_id = conf['profile']['dozens_id']
      api_key   = conf['profile']['api_key']

      if dozens_id.nil? || api_key.nil?
        abort("\x1b[31;01m[ERROR]\x1b[39;49;00m Configuration file is missing some required information")
      end

      @headers = {
        'X-Auth-User'  => dozens_id,
        'X-Auth-Key'   => api_key,
        'Host'         => 'dozens.jp',
        'Content-Type' => 'application/json'
      }

      uri = URI.parse("#{@base_url}/api/authorize.json")
      res = Net::HTTP.start(uri.host, uri.port) do |http|
        http.get(uri.path, @headers)
      end

      @auth_token = JSON.parse(res.body)['auth_token']
    end

    def get_data(uri)
      @headers['X-Auth-Token'] = @auth_token

      res = Net::HTTP.start(uri.host, uri.port) do |http|
        http.get(uri.path, @headers)
      end
      JSON.parse res.body
    end

    def post_data(uri, data)
      @headers['X-Auth-Token'] = @auth_token

      http = Net::HTTP.new(uri.host, uri.port)
      res = http.post(uri.request_uri, data, @headers)
      JSON.parse res.body
    end

    def delete_data(uri)
      @headers['X-Auth-Token'] = @auth_token

      http = Net::HTTP.new(uri.host, uri.port)
      res = http.delete(uri.request_uri, @headers)
      JSON.parse res.body
    end

    def get_zone
      uri = URI.parse("#{@base_url}/api/zone.json")
      get_data(uri)
    end

    def create_zone(zone_name)
      uri = URI.parse("#{@base_url}/api/zone/create.json")
      data = JSON.generate({"name" => zone_name})
      post_data(uri, data)
    end

    def delete_zone(zone_id)
      uri = URI.parse("#{@base_url}/api/zone/delete/#{zone_id}.json")
      delete_data(uri)
    end

    def get_record(zone_name)
      uri = URI.parse("#{@base_url}/api/record/#{zone_name}.json")
      get_data(uri)
    end

    def create_record(params)
      uri = URI.parse("#{@base_url}/api/record/create.json")
      begin
        JSON.parse(params)
      rescue JSON::ParserError => e
        abort("\x1b[31;01m[ERROR]\x1b[39;49;00m #{e.message}")
      else
        post_data(uri, params)
      end
    end

    def delete_record(record_id)
      uri = URI.parse("#{@base_url}/api/record/delete/#{record_id}.json")
      delete_data(uri)
    end

    def update_record(record_id, params)
      uri = URI.parse("#{@base_url}/api/record/update/#{record_id}.json")
      begin
        JSON.parse(params)
      rescue JSON::ParserError => e
        abort("\x1b[31;01m[ERROR]\x1b[39;49;00m #{e.message}")
      else
        post_data(uri, params)
      end
    end
  end
end
