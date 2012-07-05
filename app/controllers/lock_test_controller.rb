class LockTestController < ApplicationController
  def index
    t = Test.create

    t.with_lock do
      Rails.logger.debug("First lock")
    end

    t.with_lock do
      Rails.logger.debug("Second lock")
    end

    Test.uncached do
      t.with_lock do
        Rails.logger.debug("Third lock")
      end
    end

    render nothing: true
  end
end