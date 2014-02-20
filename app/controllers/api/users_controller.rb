class Api::UsersController < ApplicationController
  inherit_resources
  respond_to :json
  actions :all, :except => [:edit, :new]

  # Error handling.
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found

  # Look for Last-Modified header and return HTTP 304 if not modified.
  responders :http_cache

  # Filters
  before_filter :authorize_resources!

  # Response 404 error as JSON data. Non-protected/private because:
  # http://tenderlovemaking.com/2012/09/07/protected-methods-and-ruby-2-0.html
  # TODO: Patch shoulda-matcher to look for private/protected meths.
  def not_found
    render :status => 404, :json => {:_status => 404}
  end

  # Response 401 error as JSON data.
  def not_authorized
    render :status => 401, :json => {
      :_status => 401,
      :_message => "You are not authorized to perform this action."
    }
  end

  protected

  def permitted_params
    params.permit(:user => [
      :first_name,
      :last_name,
      :email,
      :password,
      :position,
      :employee_number,
      :department
    ])
  end

  # Authorize resource against policy. This method will handle policy
  # authorization as appropriate by each resource types. There are three
  # possible authorization strategy.
  #
  # 1. If the action name is :index or equals to action name defined in
  #    custom_actions as collection, the policy will be checked against
  #    collection.
  #
  # 2. If the action name is :show, :edit, :update, :destroy or equals to
  #    action name defined in custom_actions as resource, the policy will
  #    be checked against resource.
  #
  # 3. If the action name is not something of above three, the policy
  #    will be checked against resource class.
  #
  def authorize_resources!
    options = self.class.resources_configuration[:self][:custom_actions]
    collection_actions = [:index] + [*options.try(:fetch, :collection, [])]
    resource_actions = [:show, :edit, :update, :destroy]
    resource_actions += [*options.try(:fetch, :resource, [])]

    case action_name.to_sym
    when *collection_actions then authorize collection
    when *resource_actions   then authorize resource
    else
      # There are cases where resource_class is not present, such as when
      # the resource is loaded as part of belongs_to.
      #
      # It is not possible to use build_resource here either since
      # InheritedResource will cache the newly built object in the same
      # instance variable as resource, causing an actual resource to be
      # unaccessible afterward.
      klass = resource_class
      klass ||= resource_instance_name.to_s.classify.constantize
      authorize klass
    end
  end

  # InheritedResources will load all resources from this association chain.
  # Wiki is scoped to each account that user has access to, this we start at
  # current_user, and make all controllers "belongs_to" accounts.
  # def begin_of_association_chain
  #   current_user
  # end

  # Always wrap the association chain within scope so that collection and
  # any collection overrides are scoped to policy.
  def end_of_association_chain
    policy_scope super
  end
end
