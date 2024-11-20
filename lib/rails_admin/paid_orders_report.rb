module RailsAdmin
  module Config
    module Actions
      class PaidOrdersReport < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :root? do
          true
        end

        register_instance_option :link_icon do
          'icon-file'
        end

        register_instance_option :visible? do
          true
        end

        register_instance_option :controller do
          Proc.new do
            @paid_orders = Order.where(status: 'paid')

            # Render the view with RailsAdmin's layout
            render :paid_orders_report, layout: 'rails_admin/application'
          end
        end
      end
    end
  end
end
