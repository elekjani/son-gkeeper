##
## Copyright (c) 2015 SONATA-NFV [, ANY ADDITIONAL AFFILIATION]
## ALL RIGHTS RESERVED.
## 
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
## 
##     http://www.apache.org/licenses/LICENSE-2.0
## 
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
## 
## Neither the name of the SONATA-NFV [, ANY ADDITIONAL AFFILIATION]
## nor the names of its contributors may be used to endorse or promote 
## products derived from this software without specific prior written 
## permission.
## 
## This work has been performed in the framework of the SONATA project,
## funded by the European Commission under Grant number 671517 through 
## the Horizon 2020 and 5G-PPP programmes. The authors would like to 
## acknowledge the contributions of their colleagues of the SONATA 
## partner consortium (www.sonata-nfv.eu).
# encoding: utf-8
require 'sinatra/namespace'
class GtkApi < Sinatra::Base

  register Sinatra::Namespace
  
  namespace '/api/v2/kpi' do
    before do
       if request.request_method == 'OPTIONS'
         response.headers['Access-Control-Allow-Origin'] = '*'
         response.headers['Access-Control-Allow-Methods'] = 'POST'      
         response.headers['Access-Control-Allow-Headers'] = 'Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With'
         halt 200
       end
     end
  
    # POST a request
    post '/?' do
      MESSAGE = "GtkApi::POST /api/v2/kpi"
      params = JSON.parse(request.body.read)
      unless params.nil?
        logger.debug(MESSAGE) {"entered with params=#{params}"}
        new_request = KpiManagerService.create_metric(params)
        if new_request
          logger.debug(MESSAGE) {"new_request =#{new_request}"}
          halt 201, new_request.to_json
        else
          logger.debug(MESSAGE) { "leaving with 'No kpi creation request was created'"}
          json_error 400, 'No kpi create_request was created'
        end
      end
      logger.debug(MESSAGE) { "leaving with 'No request id specified'"}
      json_error 400, 'No params specified for the create request'
    end
  end
end
