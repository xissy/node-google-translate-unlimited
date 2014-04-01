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
  return callback new Error 'invalid params.text'  if not params?.text?

  params.sourceLanguage = 'auto'  if not params?.sourceLang?
  params.toLanguage = 'en'  if not params?.toLang?

  if typeof options is 'function'
    callback = options
    options = {}

  translateUrl = "http://translate.google.com/translate_a/t?client=t&sl=#{params.sourceLang}&tl=#{params.toLang}&text=#{encodeURIComponent params.text}&q=#{encodeURIComponent params.text}"

  request
    url: "#{baseUrl}?method=#{method}&header=Referer|#{referer}&url=#{encodeURIComponent translateUrl}"
  ,
    (err, reps, body) ->
      return callback err  if err?
      if reps.statusCode isnt 200
        return callback new Error "invalid status code: #{reps.statusCode}"

      result = JSON.parse validateGoogleTranslateResponseText body

      callback null,
        translatedText: result?[0]?[0]?[0]
        sourceText: result?[0]?[0]?[1]
        phonetics: result?[0]?[0]?[3]


##
# a recursion function to validate google translate reponse text.
# 
# for example,
# source text: [[["24 hours is not enough","24시간이 모자라","","24sigan-i mojala"]],,"ko",,[["24 hours",[1],true,false,824,0,2,0],["is",[2],true,false,817,2,3,0],["not enough",[3],true,false,812,3,5,0]],[["24 시간",1,[["24 hours",824,true,false],["Twenty-four hours",0,true,false]],[[0,4]],"24시간이 모자라"],["이",2,[["is",817,true,false],["this",0,true,false],["the",0,true,false],["are",0,true,false],["these",0,true,false]],[[4,5]],""],["모자라",3,[["not enough",812,true,false],["less",133,true,false],["short of",0,true,false]],[[6,9]],""]],,,[["ko"]],2]
# validated text: [[["24 hours is not enough","24시간이 모자라","","24sigan-i mojala"]], "" ,"ko", "" ,[["24 hours",[1],true,false,824,0,2,0],["is",[2],true,false,817,2,3,0],["not enough",[3],true,false,812,3,5,0]],[["24 시간",1,[["24 hours",824,true,false],["Twenty-four hours",0,true,false]],[[0,4]],"24시간이 모자라"],["이",2,[["is",817,true,false],["this",0,true,false],["the",0,true,false],["are",0,true,false],["these",0,true,false]],[[4,5]],""],["모자라",3,[["not enough",812,true,false],["less",133,true,false],["short of",0,true,false]],[[6,9]],""]], "" , "" ,[["ko"]],2]
#
validateGoogleTranslateResponseText = (text) ->
  validatedText = text.replace /,,/g, ', "" ,'

  return validatedText  if validatedText is text
  return validateGoogleTranslateResponseText validatedText



module.exports = translate
