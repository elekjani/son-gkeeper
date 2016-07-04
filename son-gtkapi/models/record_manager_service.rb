##
## Copyright 2015-2017 Portugal Telecom Inovacao/Altice Labs
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##   http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
# encoding: utf-8
class RecordManagerService
  
  JSON_HEADERS = { 'Accept'=> 'application/json', 'Content-Type'=>'application/json'}
  CLASS = 'GtkApi::RecordManagerService'
  
  def initialize(url, logger)
    @url = url
    @logger = logger
  end
    
  def find_services_by_uuid(uuid)
    headers = JSON_HEADERS
    #headers[:params] = uuid
    begin
      response = RestClient.get( @url+"/services/#{uuid}", headers)
      JSON.parse response.body
    rescue => e
      @logger.error "ServiceManagerService.find_services_by_uuid: e=#{format_error(e.backtrace)}"
      nil 
    end
  end

  def find_services(params)
    method = "GtkApi: ServiceManagerService.find_records(#{params})"
    headers = JSON_HEADERS
    headers[:params] = params unless params.empty?
    @logger.debug(method) {"headers=#{headers}"}
    begin
      response = RestClient.get(@url+'/services', headers) 
      @logger.debug "ServiceManagerService.find_services(#{params}): response=#{response}"
      JSON.parse response.body
    rescue => e
      @logger.error "ServiceManagerService.find_services: #{e.message} - #{format_error(e.backtrace)}"
      nil 
    end
  end
  
  def get_log
    RestClient.get(@url+"/admin/logs")      
  end
  
  private
  
  def format_error(backtrace)
    first_line = backtrace[0].split(":")
    "In "+first_line[0].split("/").last+", "+first_line.last+": "+first_line[1]
  end
end
