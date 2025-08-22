class OrganizationController < ApplicationController

    before_action :find_organization_by_id, only: %i[show update destroy]
    def index
        render json: @organization
    end
    
    def show
        render @organization
    end

    def create
        @organization = Organization.new(organization_params)
        if @Organization.save
            render json: "sds"

    private
    
    def find_organization_by_id(id)
        @organization = Organization.find(params.expect(:id))
    end
end
