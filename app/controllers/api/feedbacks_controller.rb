module Api
  class FeedbacksController < ApplicationController
    def create
      feedback = Feedback.new(feedback_params)
      if feedback.valid?
        feedback.save
        render status: :ok, json: { message: 'succeeded' }
      else
        render status: :unprocessable_entity, json: { message: 'failed' }
      end
    end

    private

    def feedback_params
      params.require(:feedback).permit(:name, :comments)
    end
  end
end
