request = require 'request'


baseUrl = 'http://goxcors-xissy.appspot.com/cors'
method = 'GET'
referer = 'http://translate.google.com'


##
# translate function
#
# params.text - input text, not null
# params.sourceLang - source language, default is 'auto'
# params.toLang - to language, default is 'en'
#
translate = (params, options, callback) ->
  return callback new Error 'invalid params.sourceText'  if not params?.sourceText?

  params.sourceLanguage = 'auto'  if not params?.sourceLang?
  params.toLanguage = 'en'  if not params?.toLang?

  if typeof options is 'function'
    callback = options
    options = {}

  encodedSourceText = encodeURIComponent params.sourceText
  translateUrl = "http://translate.google.com/translate_a/t?client=p&sl=#{params.sourceLanguage}&tl=#{params.toLanguage}&text=#{encodedSourceText}&q=#{encodedSourceText}"

  request
    url: "#{baseUrl}?method=#{method}&header=Referer|#{referer}&url=#{encodeURIComponent translateUrl}"
  ,
    (err, reps, body) ->
      return callback err  if err?
      if reps.statusCode isnt 200
        return callback new Error "invalid status code: #{reps.statusCode}"

      result = JSON.parse body

      callback null,
        sourceText: result?.sentences?[0]?.orig
        translatedText: result?.sentences?[0]?.trans
        phonetics: result.sentences?[0]?.src_translit



module.exports = translate
