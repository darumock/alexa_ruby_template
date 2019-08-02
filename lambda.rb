require 'json'
require 'aws-sdk-s3'

def handler(event:, context:)
  request = event['request']
  intent = Intent.new

  case request['type']
  when 'LaunchRequest'
    intent.launch
  when 'IntentRequest'
    case request['intent']['name']
    when 'HelloIntent'         then intent.hello
    when 'AMAZON.HelpIntent'   then intent.help
    when 'AMAZON.CancelIntent' then intent.cancel
    when 'AMAZON.StopIntent'   then intent.stop
    end
  end
end

class Intent  
  def launch
    JSON.generate({
      version: 1.0,
      response: {
        outputSpeech: {
          type: 'SSML',
          ssml: '<speak>Welcome. Please say hello to continue.</speak>'
        },
        shouldEndSession: false
      }
    })
  end

  def hello
    JSON.generate({
      version: 1.0,
      response: {
        outputSpeech: {
          type: 'SSML',
          ssml: '<speak>Excellent!</speak>'
        },
        shouldEndSession: true
      }
    })
  end

  def help
    JSON.generate({
      version: 1.0,
      response: {
        outputSpeech: {
          type: 'SSML',
          ssml: '<speak>This skill is say hello.</speak>'
        },
        shouldEndSession: false
      }
    })
  end

  def cancel
    JSON.generate({
      version: 1.0,
      response: {
        outputSpeech: {
          type: 'SSML',
          ssml: '<speak>Cancel the skill.</speak>'
        },
        shouldEndSession: true
      }
    })
  end

  def stop
    JSON.generate({
      version: 1.0,
      response: {
        outputSpeech: {
          type: 'SSML',
          ssml: '<speak>Stop the skill.</speak>'
        },
        shouldEndSession: true
      }
    })
  end
end