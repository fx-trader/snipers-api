require 'sinatra'
require_relative "db/models"

# based on https://x-team.com/blog/how-to-create-a-ruby-api-with-sinatra/

    #use Rack::Auth::Basic, "Restricted Area" do |username, password|
    #    username == 'admin' and password == 'admin'
    #end

    before do
        content_type 'application/json'
    end

    helpers do
        def account
            Account.where(email: "joaocosta@zonalivre.org").first
        end

        def base_url
            @base_url ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
        end

        def json_params
            begin
                JSON.parse(request.body.read)
            rescue
                halt 400, { message:'Invalid JSON' }.to_json
            end
        end

    end

    get "/snipers/" do
        snipers = Sniper.account(account)
        snipers = snipers.send('instrument', params['instrument']) if (params['instrument']);
        snipers.to_json
    end

    get "/snipers/:id" do |id|
        sniper = Sniper.account(account).where(id: id).first
        halt(404, { message:'Not Found'}.to_json) unless(sniper)
        sniper.to_json
    end

    post "/snipers/" do
        sniper = Sniper.new(json_params)
        sniper.account = account

        if sniper.save
            response.headers['Location'] = "#{base_url}/snipers/#{sniper.id}"
            status 201
        else
            status 422
            body sniper.to_json
        end
    end

    patch '/snipers/:id ' do |id|
        sniper = Sniper.account(account).where(id: id).first
        halt(404, { message:'Not Found'}.to_json) unless sniper

        if sniper.update_attributes(json_params)
            sniper.to_json
        else
            status 422
            body sniper.to_json
        end
    end

    delete "/snipers/:id" do |id|
        sniper = Sniper.account(account).where(id: id).first
        sniper.destroy if sniper
        status 204
    end
