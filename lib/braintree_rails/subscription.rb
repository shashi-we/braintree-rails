module BraintreeRails
  class Subscription
    include Model

    define_attributes(
      :create => [
        :billing_day_of_month, :first_billing_date, :id, :merchant_account_id, :never_expires, :number_of_billing_cycles,
        :payment_method_token, :plan_id, :price, :trial_duration, :trial_duration_unit, :trial_period, :options, :descriptor
      ],
      :update => [
        :merchant_account_id, :never_expires, :number_of_billing_cycles,
        :payment_method_token, :plan_id, :price, :options
      ],
      :readonly => [
        :balance, :billing_period_end_date, :billing_period_start_date, :current_billing_cycle, :days_past_due,
        :failure_count, :next_billing_date, :next_billing_period_amount, :paid_through_date, :status
      ]
    )

    define_associations(:add_ons, :discounts, :transactions, :plan => :plan_id, :credit_card => :payment_method_token)

    def self.cancel(id)
      delete(id)
    end

    def attributes
      super.except(:descriptor)
    end

    def cancel
      destroy
    end

    def price=(val)
      @price = val.blank? ? nil : val
    end

    def never_expires?
      never_expires
    end
  end
end
