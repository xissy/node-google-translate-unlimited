should = require 'should'

translate = require '../lib/index'


describe 'translate', ->
  it 'should be done', (done) ->
    translate
      sourceText: '24시간이 모자라'
    ,
      (err, result) ->
        should.not.exists err
        should.exists result
        should.exists result.translatedText
        should.exists result.sourceText
        should.exists result.phonetics

        # console.log result

        done()
