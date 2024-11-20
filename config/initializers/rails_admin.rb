require Rails.root.join("lib", "rails_admin", "paid_orders_report.rb")

RailsAdmin.config do |config|
  RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::PaidOrdersReport)

  config.asset_source = :importmap
  config.asset_source = :sprockets

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :admin_user
  end
  config.current_user_method(&:current_admin_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, "User", "PaperTrail::Version" # PaperTrail >= 3.0.0

  ### More at https://github.com/railsadminteam/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    # Custom action for Paid Orders Report
    paid_orders_report do
      visible true # This makes the action appear in the navigation menu
    end
  end
end
