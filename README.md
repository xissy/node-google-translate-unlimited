# node-google-translate-xissy
> Use google translate API simply without limit.

## How to use
```javascript
var translate = require('google-translate-xissy')

translate({
  'text': '24시간이 모자라',
  'sourceLanguage': 'auto',
  'toLanguage': 'en'
},
  function(err, result) {
    // result: { translateText: '24 hours is not enough',
    //    sourceText: '24시간이 모자라',
    //    phonetics: '24sigan-i mojala'
    // }
    ...
});
```
