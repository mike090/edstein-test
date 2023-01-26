# frozen_string_literal: true

module RequestProcessor
  def return_answer_for(msg, *request_params)
    lambda do
      args = request_params.map { |param_name| params[param_name] }
      answer = Core.handle msg, *args
      status answer[0]
      answer[1]
    end
  end
end
