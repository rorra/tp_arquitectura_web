require 'rails_helper'

RSpec.describe "Payments", type: :request do
  let(:user) { create(:user) }
  let(:order) { create(:order, user: user) }

  before { sign_in user }

  describe 'GET /payments/new' do
    context 'with a paid order' do
      before do
        order.update(status: :paid)
      end

      it 'redirects to orders path' do
        get new_payment_path(order_id: order.id)
        expect(response).to redirect_to(orders_path)
        expect(flash[:alert]).to eq('This order is already paid.')
      end
    end

    context 'with a pending order' do
      it 'displays the payment form successfully' do
        get new_payment_path(order_id: order.id)
        expect(response).to be_successful
        expect(response.body).to include("Payment for Order ##{order.id}")
        expect(response.body).to include("Order Summary")
        expect(response.body).to include("Proceed to Payment")
      end
    end
  end

  describe 'POST /payments/create' do
    let(:valid_params) { { order_id: order.id } }

    context 'with valid payment data' do
      it 'redirects to MercadoPago payment page' do
        # Mock MercadoPago SDK response
        mock_preference_response = {
          response: {
            'sandbox_init_point' => 'https://sandbox.mercadopago.com/checkout/v1/redirect?pref_id=123'
          }
        }

        sdk_double = double('sdk')
        preference_double = double('preference')

        allow(Mercadopago::SDK).to receive(:new).and_return(sdk_double)
        allow(sdk_double).to receive(:preference).and_return(preference_double)
        allow(preference_double).to receive(:create).and_return(mock_preference_response)

        post payments_path, params: valid_params
        expect(response).to redirect_to('https://sandbox.mercadopago.com/checkout/v1/redirect?pref_id=123')
      end
    end

    context 'with invalid payment data' do
      it 'redirects to cart with error message when MercadoPago fails' do
        # Mock MercadoPago SDK failure
        sdk_double = double('sdk')
        preference_double = double('preference')

        allow(Mercadopago::SDK).to receive(:new).and_return(sdk_double)
        allow(sdk_double).to receive(:preference).and_return(preference_double)
        allow(preference_double).to receive(:create).and_return({})

        post payments_path, params: valid_params
        expect(response).to redirect_to(cart_path)
        expect(flash[:alert]).to eq('There was an error connecting to the payment gateway.')
      end
    end
  end

  describe 'GET /payments/success' do
    let(:payment_params) { { order_id: order.id, payment_id: '123456' } }

    context 'with valid payment confirmation' do
      it 'updates order status and redirects to order page' do
        # Mock MercadoPago SDK payment verification
        sdk_double = double('sdk')
        payment_double = double('payment')

        allow(Mercadopago::SDK).to receive(:new).and_return(sdk_double)
        allow(sdk_double).to receive(:payment).and_return(payment_double)
        allow(payment_double).to receive(:get).and_return({
                                                            response: { "status" => "approved" }
                                                          })

        get success_payments_path, params: payment_params
        expect(order.reload.status).to eq('paid')
        expect(response).to redirect_to(order_path(order))
        expect(flash[:notice]).to eq('Payment was successful! Your order is now complete.')
      end
    end

    context 'with invalid payment confirmation' do
      it 'redirects to cart with error message' do
        get success_payments_path, params: { order_id: order.id }
        expect(response).to redirect_to(cart_path)
        expect(flash[:alert]).to eq('Invalid payment confirmation details.')
      end
    end
  end

  describe 'GET /payments/failure' do
    it 'redirects to cart with failure message' do
      get failure_payments_path, params: { order_id: order.id }
      expect(response).to redirect_to(cart_path)
      expect(flash[:alert]).to eq('Payment failed. Please try again or use a different payment method.')
    end
  end
end
