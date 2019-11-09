# frozen_string_literal: true

class AdminConstraint
  def matches?(request)
    warden = request.env['warden']
    warden.authenticated? && warden.user.admin
  end
end
